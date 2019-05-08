//
//  YYKVStorage.h
//  HelloWordl
//
//  Created by lmg on 2019/5/7.
//  Copyright © 2019 lmg. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface YYKVStorageItem : NSObject
@property (nonatomic,strong) NSString *key;///< key
@property (nonatomic,strong) NSData *value;///< value
@property (nonatomic,strong,nullable) NSString *filename;///< filename (nil if inline)
@property (nonatomic) int size;
@property (nonatomic) int modTime;
@property (nonatomic) int accessTime;
@property (nonatomic,strong,nullable) NSData *extendedData;
@end

typedef NS_ENUM(NSUInteger,YYKVStorageType) {
    
    /// The `value` is stored as a file in file system.
    YYKVStorageTypeFile = 0,
    
    /// The `value` is stored in sqlite with blob type.
    YYKVStorageTypeSQLite = 1,
    
    /// The `value` is stored in file system or sqlite based on your choice.
    YYKVStorageTypeMixed = 2,
    
};

@interface YYKVStorage : NSObject

#pragma mark -Attribute

@property (nonatomic,readonly) NSString *path;

@property (nonatomic,readonly) YYKVStorageType type;

@property (nonatomic) BOOL errorLogsEnabled;

#pragma mark -Initializer

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

- (nullable instancetype)initWithPath:(NSString *)path type:(YYKVStorageType)type NS_DESIGNATED_INITIALIZER;

#pragma mark -Save Items

- (BOOL)saveItem:(YYKVStorageItem *)item;

- (BOOL)saveItemWithKey:(NSString *)key value:(NSData *)value;

- (BOOL)saveItemWithKey:(NSString *)key value:(NSData *)value
               filename:(nullable NSString *)fileName
           extendedData:(nullable NSData *)extendedData;

#pragma mark -Remove Items

- (BOOL)removeItemForKey:(NSString *)key;

- (BOOL)removeItemForKeys:(NSArray<NSString *> *)keys;

- (BOOL)removeItemsLargerThanSize:(int)size;

- (BOOL)removeItemsEarlierThanTime:(int)time;

- (BOOL)removeItemsToFitSize:(int)maxSize;

- (BOOL)removeItemsToFitCount:(int)maxCount;

- (BOOL)removeAllItems;

- (BOOL)removeAllItemsWithProgressBlock:(nullable void(^)(int removedCount,int totalCount))progress
                               endBlock:(nullable void(^)(BOOL error))end;


#pragma mark -Get Items

- (nullable YYKVStorageItem *)getItemForKey:(NSString *)key;

- (nullable YYKVStorageItem *)getItemInfoForKey:(NSString *)key;

- (nullable NSData *)getItemValueForKey:(NSString *)key;

- (nullable NSArray<YYKVStorageItem *>*)getItemForKeys:(NSArray<NSString *>*)keys;

- (nullable NSArray<YYKVStorageItem *>*)getItemInfoForKeys:(NSArray<NSString *>*)keys;

- (nullable NSDictionary<NSString *,NSData *>*)getItemValueForKeys:(NSArray<NSString *>*)keys;


#pragma mark -Get Storage Status

- (BOOL)itemExistsForKey:(NSString *)key;


- (int)getItemsCount;

/*
 Get item value's total size in bytes.
 @return Total size in bytes, -1 when an error occurs.
 */
- (int)getItemsSize;

@end

NS_ASSUME_NONNULL_END
