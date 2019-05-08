//
//  YYDiskCache.m
//  HelloWordl
//
//  Created by lmg on 2019/5/7.
//  Copyright © 2019 lmg. All rights reserved.
//

#import "YYDiskCache.h"
#import "YYKVStorage.h"
#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonCrypto.h>
#import <objc/runtime.h>
#import <time.h>

#define Lock()  dispatch_semaphore_wait(self->_lock, DISPATCH_TIME_FOREVER);
#define UnLock()   dispatch_semaphore_signal(self->_lock);

static const int extended_data_key;

/// Free disk space in bytes.
static int64_t _YYDiskSpaceFree(){
    NSError *error = nil;
    NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error) return -1;
    int64_t space =  [[attrs objectForKey:NSFileSystemFreeSize] longLongValue];
    if (space < 0) space = -1;
    return space;
}

/// String's md5 hash.
static NSString *_YYNSStringMD5(NSString *string){
    if (!string) return nil;
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(data.bytes, (CC_LONG)data.length, result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0],  result[1],  result[2],  result[3],
            result[4],  result[5],  result[6],  result[7],
            result[8],  result[9],  result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

/// weak reference for all instances
static NSMapTable *_globalInstance;
static dispatch_semaphore_t _globalInstancesLock;
static void _YYDiskCacheInitGlobal(){
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _globalInstancesLock = dispatch_semaphore_create(1);
        _globalInstance = [[NSMapTable alloc]initWithKeyOptions:NSPointerFunctionsStrongMemory valueOptions:NSPointerFunctionsWeakMemory capacity:0];
    });
}

static YYDiskCache *_YYDiskCacheGetGlobal(NSString *path){
    if (path.length == 0) {
        return nil;
    }
    _YYDiskCacheInitGlobal();
    dispatch_semaphore_wait(_globalInstancesLock, DISPATCH_TIME_FOREVER);
    id cache = [_globalInstance objectForKey:path];
    dispatch_semaphore_signal(_globalInstancesLock);
    return cache;
}

static void _YYDiskCacheSetGlobal(YYDiskCache *cache){
    if (cache.path.length == 0) {
        return ;
    }
    _YYDiskCacheInitGlobal();
    dispatch_semaphore_wait(_globalInstancesLock, DISPATCH_TIME_FOREVER);
    [_globalInstance setObject:cache forKey:cache.path];
    dispatch_semaphore_signal(_globalInstancesLock);
}

@implementation YYDiskCache
{
    YYKVStorage *_kv;
    dispatch_semaphore_t _lock;
    dispatch_queue_t _queue;
}

- (void)_trimRecursively
{
    __weak typeof(self) _self = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(_autoTrimInterval * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        __strong typeof(_self) self = _self;
        if (!self) return ;
        [self _trimInBackground];
        [self _trimRecursively];
    });
}

- (void)_trimInBackground
{
    __weak typeof(self) _self = self;
    dispatch_async(_queue, ^{
        __strong typeof(_self) self = _self;
        if (!self) return ;
        Lock();
        [self _trimToCost:self.costLimit];
        [self _trimToCount:self.countLimit];
        [self _trimToAge:self.ageLimit];
        [self _trimToFreeDiskSpace:self.freeDiskSpaceLimit];
        UnLock();
    });
}

- (void)_trimToCost:(NSUInteger)costLimit
{
    if (costLimit >= INT_MAX) {
        return ;
    }
    [_kv removeItemsToFitSize:(int)costLimit];
}

- (void)_trimToCount:(NSUInteger)countLimit
{
    if (countLimit >= INT_MAX) {
        return ;
    }
    [_kv removeItemsToFitCount:(int)countLimit];
}

- (void)_trimToAge:(NSTimeInterval)ageLimit
{
    if (ageLimit <= 0) {
        [_kv removeAllItems];
        return ;
    }
    long timestamp = time(NULL);
    if (timestamp <= ageLimit)return;
    long age = timestamp - ageLimit;
    if (age >= INT_MAX) return;
    [_kv removeItemsEarlierThanTime:(int)age];
}

- (void)_trimToFreeDiskSpace:(NSUInteger)targetFreeDiskSpace
{
    if (targetFreeDiskSpace == 0) return;
    int64_t totalBytes = [_kv getItemsSize];
    if (totalBytes <= 0) return;
    int64_t diskFreeBytes = _YYDiskSpaceFree();
    if (diskFreeBytes < 0) return;
    int64_t needTrimBytes = targetFreeDiskSpace - diskFreeBytes;
    if (needTrimBytes <= 0) return;
    int64_t costLimit = totalBytes - needTrimBytes;
    if (costLimit < 0) costLimit = 0;
    [self _trimToCost:costLimit];
}

- (NSString *)_filenameForKey:(NSString *)key
{
    NSString *filename = nil;
    if (_customFileNameBlock) {
       filename = _customFileNameBlock(key);
    }
    if (!filename) {
        filename = _YYNSStringMD5(key);
    }
    return filename;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillTerminateNotification object:nil];
}

- (instancetype)init {
    @throw [NSException exceptionWithName:@"YYDiskCache init error" reason:@"YYDiskCache must be initialized with a path. Use 'initWithPath:' or 'initWithPath:inlineThreshold:' instead." userInfo:nil];
    return [self initWithPath:@"" inlineThreshold:0];
}


- (instancetype)initWithPath:(NSString *)path
{
    return [self initWithPath:path inlineThreshold:1024*20];//20kb
}


- (instancetype)initWithPath:(NSString *)path inlineThreshold:(NSUInteger)inlineThreshold
{
    self = [super init];
    if (!self) {
        return nil;
    }
    YYDiskCache *globalCache = _YYDiskCacheGetGlobal(path);
    if (globalCache) {
        return globalCache;
    }
    
    YYKVStorageType type;
    if (inlineThreshold == 0) {
        type = YYKVStorageTypeFile;
    }else if (inlineThreshold == NSUIntegerMax){
        type = YYKVStorageTypeSQLite;
    }else{
        type = YYKVStorageTypeMixed;
    }
    
    YYKVStorage *kv = [[YYKVStorage alloc]initWithPath:path type:type];
    if (!kv) return nil;
    
    _kv = kv;
    _path = path;
    _lock = dispatch_semaphore_create(1);
    _queue = dispatch_queue_create("com.ibireme.cache.disk", DISPATCH_QUEUE_CONCURRENT);
    _inlineThreshold = inlineThreshold;
    _countLimit = NSUIntegerMax;
    _costLimit = NSUIntegerMax;
    _ageLimit = DBL_MAX;
    _freeDiskSpaceLimit = 0;
    _autoTrimInterval = 60;
    
    [self _trimRecursively];
    _YYDiskCacheSetGlobal(self);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_appWillBeTerminate) name:UIApplicationWillTerminateNotification object:nil];
    return self;
}

- (void)_appWillBeTerminate
{
    Lock();
    _kv = nil;
    UnLock();
}


#pragma mark -Public Method

- (BOOL)containsObjectForKey:(NSString *)key
{
    if (!key) {
        return NO;
    }
    Lock();
    BOOL contains = [_kv itemExistsForKey:key];
    UnLock();
    return contains;
}

- (void)containsObjectForKey:(NSString *)key withBlock:(void (^)(NSString * _Nonnull, BOOL))block
{
    if (!block) return ;
    __weak typeof(self) _self = self;
    dispatch_async(_queue, ^{
        __strong typeof(_self) self = _self;
        BOOL contains = [self containsObjectForKey:key];
        block(key,contains);
    });
}

- (id<NSCoding>)objectForKey:(NSString *)key
{
    if (!key) return nil;
    Lock();
    YYKVStorageItem *item = [_kv getItemForKey:key];
    UnLock();
    if (!item.value) return nil;
    
    id object = nil;
    if (_customUnarchiveBlock) {
        object = _customUnarchiveBlock(item.value);
    }else
    {
        @try {
            object = [NSKeyedUnarchiver unarchiveObjectWithData:item.value];
        } @catch (NSException *exception) {
            
        }
    }
    if (object && item.extendedData) {
        [YYDiskCache setExtendedData:item.extendedData toObject:object];
    }
    return object;
}

- (void)objectForKey:(NSString *)key withBlock:(void (^)(NSString * _Nonnull, id<NSCoding> _Nullable))block
{
    if (!block) return;
    __weak typeof(self) _self = self;
    dispatch_async(_queue, ^{
        __strong typeof(_self) self = _self;
        id<NSCoding> object = [self objectForKey:key];
        block(key,object);
    });
}

- (void)setObject:(id<NSCoding>)object forKey:(NSString *)key
{
    if (!key) return;
    if (!object) {
        [self removeObjectForKey:key];
        return ;
    }
    
    NSData *extendedData = [YYDiskCache getExtendedDataFromObject:object];
    NSData *value = nil;
    if (_customArchiveBlock) {
        value = _customArchiveBlock(object);
    }else{
        @try {
            value = [NSKeyedArchiver archivedDataWithRootObject:object];
        } @catch (NSException *exception) {
            
        }
    }
    if (!value) return ;
    NSString *fileName = nil;
    if (_kv.type != YYKVStorageTypeSQLite) {
        if (value.length > _inlineThreshold) {
            fileName = [self _filenameForKey:key];
        }
    }
    Lock();
    [_kv saveItemWithKey:key value:value filename:fileName extendedData:extendedData];
    UnLock();
}

- (void)setObject:(id<NSCoding>)object forKey:(NSString *)key withBlock:(void (^)(void))block
{
    __weak typeof(self) _self = self;
    dispatch_async(_queue, ^{
        __strong typeof(_self) self = _self;
        [self setObject:object forKey:key];
        if(block) block();
    });
}

- (void)removeObjectForKey:(NSString *)key
{
    if (!key) return;
    Lock();
    [_kv removeItemForKey:key];
    UnLock();
}

- (void)removeObjectForKey:(NSString *)key withBlock:(void(^)(NSString * _Nonnull))block
{
    __weak typeof(self) _self = self;
    dispatch_async(_queue, ^{
        __strong typeof(_self) self = _self;
        [self removeObjectForKey:key];
        if (block) block(key);
    });
}

-(void)removeAllObjects
{
    Lock();
    [_kv removeAllItems];
    UnLock();
}

-(void)removeAllObjectsWithBlock:(void (^)(void))block
{
    __weak typeof(self) _self = self;
    dispatch_async(_queue, ^{
        __strong typeof(_self) self = _self;
        [self removeAllObjects];
        if (block) block();
    });
}

-(void)removeAllObjectsWithProgressBlock:(void (^)(int, int))progress endBlock:(void (^)(BOOL))end
{
    __weak typeof(self) _self = self;
    dispatch_async(_queue, ^{
        __strong typeof(_self) self = _self;
        if (!self) {
            if (end) {
                end(YES);
                return ;
            }
        }
        Lock();
        [_kv removeAllItemsWithProgressBlock:progress endBlock:end];
        UnLock();
    });
}

- (NSInteger)totalCount
{
    Lock();
    int count = [_kv getItemsCount];
    UnLock();
    return count;
}

- (void)totalCountWithBlock:(void (^)(NSInteger))block
{
    if (!block) {
        return;
    }
    __weak typeof(self) _self = self;
    dispatch_async(_queue, ^{
        __strong typeof(_self) self = _self;
        NSInteger totalCount = [self totalCount];
        block(totalCount);
    });
}

- (NSInteger)totalCost
{
    Lock();
    int cost = [_kv getItemsSize];
    UnLock();
    return cost;
}

-(void)totalCostWithBlock:(void (^)(NSInteger))block
{
    if (!block) {
        return;
    }
    __weak typeof(self) _self = self;
    dispatch_async(_queue, ^{
        __strong typeof(_self) self = _self;
        NSInteger totalCost = [self totalCost];
        block(totalCost);
    });
}

- (void)trimToCost:(NSUInteger)cost
{
    Lock();
    [self _trimToCost:cost];
    UnLock();
}

- (void)trimToCost:(NSUInteger)cost withBlock:(void (^)(void))block
{
    __weak typeof(self) _self = self;
    dispatch_async(_queue, ^{
        __strong typeof(_self) self = _self;
        [self trimToCost:cost];
        if (block) block();
    });
}

- (void)trimToCount:(NSUInteger)count
{
    Lock();
    [self _trimToCount:count];
    UnLock();
}

- (void)trimToCount:(NSUInteger)count withBlock:(void (^)(void))block
{
    __weak typeof(self) _self = self;
    dispatch_async(_queue, ^{
        __strong typeof(_self) self = _self;
        [self trimToCount:count];
        if (block) block();
    });
}

- (void)trimToAge:(NSTimeInterval)age
{
    Lock();
    [self _trimToAge:age];
    UnLock();
}

- (void)trimToAge:(NSTimeInterval)age withBlock:(void (^)(void))block
{
    __weak typeof(self) _self = self;
    dispatch_async(_queue, ^{
        __strong typeof(_self) self = _self;
        [self trimToAge:age];
        if (block) block();
    });
}

-(NSString *)description
{
    if (_name) {
        return [NSString stringWithFormat:@"<%@,%p> (%@:%@)",self.class,self,_name,_path];
    }
    return [NSString stringWithFormat:@"<%@: %p> (%@)", self.class, self, _path];
}

+ (NSData *)getExtendedDataFromObject:(id)object
{
    if (!object) return nil;
    return objc_getAssociatedObject(object, &extended_data_key);
}

+ (void)setExtendedData:(NSData *)extendedData toObject:(id)object
{
    if (!object) return;
    objc_setAssociatedObject(object, &extended_data_key, extendedData, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


-(BOOL)errorLogsEnabled
{
    Lock();
    BOOL enabled = _kv.errorLogsEnabled;
    UnLock();
    return enabled;
}

-(void)setErrorLogsEnabled:(BOOL)errorLogsEnabled
{
    Lock();
    _kv.errorLogsEnabled = errorLogsEnabled;
    UnLock();
}

@end
