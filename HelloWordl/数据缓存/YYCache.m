//
//  YYCache.m
//  HelloWordl
//
//  Created by lmg on 2019/5/7.
//  Copyright © 2019 lmg. All rights reserved.
//

#import "YYCache.h"
#import "YYMemoryCache.h"
#import "YYDiskCache.h"

@implementation YYCache

- (instancetype)init{
    NSLog(@"Use \"initWithName\" or \"initWithPath\" to create YYCache instance.");
    return [self initWithPath:@""];
}

- (instancetype)initWithPath:(NSString *)path
{
    if (path.length == 0) return nil;
    YYDiskCache *diskCache = [[YYDiskCache alloc]initWithPath:path];
    if (!diskCache) return nil;
    NSString *name = [path lastPathComponent];
    YYMemoryCache *memoryCache = [YYMemoryCache new];
    memoryCache.name = name;
    
    self = [super init];
    _name = name;
    _diskCache = diskCache;
    _memoryCache = memoryCache;
    return self;
}

- (instancetype)initWithName:(NSString *)name
{
    if (name.length == 0) return nil;
    NSString *cacheFolder = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *path = [cacheFolder stringByAppendingPathComponent:name];
    return [self initWithPath:path];
}

+ (instancetype)cacheWithPath:(NSString *)path
{
    return [[self alloc] initWithPath:path];
}

+ (instancetype)cacheWithName:(NSString *)name
{
    return [[self alloc]initWithName:name];
}

- (BOOL)containsObjectForKey:(NSString *)key
{
    return [_memoryCache containsObjectForKey:key] || [_diskCache containsObjectForKey:key];
}

-(void)containsObjectForKey:(NSString *)key withBlock:(void (^)(NSString * _Nonnull, BOOL))block
{
    if (!block) {
        return;
    }
    if ([_memoryCache containsObjectForKey:key]) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            block(key,YES);
        });
    }else{
        [_diskCache containsObjectForKey:key withBlock:block];
    }
}

- (id<NSCoding>)objectForKey:(NSString *)key
{
    id<NSCoding> object = [_memoryCache objectForKey:key];
    if (!object) {
        object = [_diskCache objectForKey:key];
        if (object) {
            [_memoryCache setObject:object forKey:key];
        }
    }
    return object;
}

- (void)objectForKey:(NSString *)key withBlock:(void (^)(NSString * _Nonnull, id<NSCoding> _Nonnull))block
{
    if (!block) {
        return;
    }
    id<NSCoding> object = [_memoryCache objectForKey:key];
    if (object) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            block(key,object);
        });
    }else{
        [_diskCache objectForKey:key withBlock:^(NSString * _Nonnull key, id<NSCoding>  _Nullable object) {
            if (object && ![_memoryCache objectForKey:key]) {
                [_memoryCache objectForKey:key];
            }
            block(key,object);
        }];
    }
}

- (void)setObject:(id<NSCoding>)object forKey:(NSString *)key
{
    [_memoryCache setObject:object forKey:key];
    [_diskCache setObject:object forKey:key];
}

- (void)setObject:(id<NSCoding>)object forKey:(NSString *)key withBlock:(void (^)(void))block
{
    [_memoryCache setObject:object forKey:key];
    [_diskCache setObject:object forKey:key withBlock:block];
}

- (void)removeObjectForKey:(NSString *)key
{
    [_memoryCache removeObjectForKey:key];
    [_diskCache removeObjectForKey:key];
}

- (void)removeObjectForKey:(NSString *)key withBlock:(void (^)(NSString * _Nonnull))block
{
    [_memoryCache removeObjectForKey:key];
    [_diskCache removeObjectForKey:key withBlock:block];
}

- (void)removeAllObjects
{
    [_memoryCache removeAllObjects];
    [_diskCache removeAllObjects];
}

- (void)removeAllObjectsWithBlock:(void (^)(void))block
{
    [_memoryCache removeAllObjects];
    [_diskCache removeAllObjectsWithBlock:block];
}

- (void)removeAllObjectsWithProgressBlock:(void (^)(int, int))progress endBlock:(void (^)(BOOL))end
{
    [_memoryCache removeAllObjects];
    [_diskCache removeAllObjectsWithProgressBlock:progress endBlock:end];
}

-(NSString *)description
{
    if (_name) {
        return [NSString stringWithFormat:@"<%@:%p>,(%@)",self.class,self,_name];
    }else{
        return [NSString stringWithFormat:@"<%@:%p>",self.class,self];
    }
}

@end
