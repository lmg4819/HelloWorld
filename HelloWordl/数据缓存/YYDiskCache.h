//
//  YYDiskCache.h
//  HelloWordl
//
//  Created by lmg on 2019/5/7.
//  Copyright © 2019 lmg. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYDiskCache : NSObject

#pragma mark -Attribute

@property (nonatomic,copy) NSString *name;

@property (readonly) NSString *path;


/**
 默认值为20kB,当data的大小大于这个值时会被存储为文件，小于这个值时会被存储为sqlite数据库
 当设置为0时，所有数据都会被存储成单独的文件
 当设置为NSUIntegerMax时，所有数据都会被存储进数据库
 */
@property (readonly) NSUInteger inlineThreshold;

@property (nullable,copy) NSData *(^customArchiveBlock)(id object);

@property (nullable,copy) id (^customUnarchiveBlock)(NSData *data);


/**
 当一个对象需要保存为文件的时候，将会调用这个方法来生成文件名，如果这个block为空，会使用key的md5
 */
@property (nullable,copy) NSString *(^customFileNameBlock)(NSString *key);

#pragma mark -Limit
/*
 默认无限制
 */
@property NSUInteger countLimit;
@property NSUInteger costLimit;
@property NSTimeInterval ageLimit;
@property NSUInteger freeDiskSpaceLimit;
/**
 默认60s
 */
@property NSTimeInterval autoTrimInterval;
@property BOOL errorLogsEnabled;

#pragma mark -Initializer

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

- (nullable instancetype)initWithPath:(NSString *)path;
- (nullable instancetype)initWithPath:(NSString *)path inlineThreshold:(NSUInteger)inlineThreshold NS_DESIGNATED_INITIALIZER;

#pragma mark -Access Method

- (BOOL)containsObjectForKey:(NSString *)key;
- (void)containsObjectForKey:(NSString *)key withBlock:(void(^)(NSString *key,BOOL contains))block;

- (nullable id<NSCoding>)objectForKey:(NSString *)key;
- (void)objectForKey:(NSString *)key withBlock:(void(^)(NSString *key,id<NSCoding> _Nullable object))block;

- (void)setObject:(nullable id<NSCoding>)object forKey:(NSString *)key;
- (void)setObject:(nullable id<NSCoding>)object forKey:(NSString *)key withBlock:(void(^)(void))block;

- (void)removeObjectForKey:(NSString *)key;
- (void)removeObjectForKey:(NSString *)key withBlock:(void(^)(NSString *key))block;

- (void)removeAllObjects;
- (void)removeAllObjectsWithBlock:(void(^)(void))block;
- (void)removeAllObjectsWithProgressBlock:(nullable void(^)(int removedCount, int totalCount))progress
                                 endBlock:(nullable void(^)(BOOL error))end;

- (NSInteger)totalCount;
- (void)totalCountWithBlock:(void(^)(NSInteger totalCount))block;

- (NSInteger)totalCost;
- (void)totalCostWithBlock:(void(^)(NSInteger totalCost))block;

#pragma mark -Trim

- (void)trimToCount:(NSUInteger)count;
- (void)trimToCount:(NSUInteger)count withBlock:(void(^)(void))block;

- (void)trimToCost:(NSUInteger)cost;
- (void)trimToCost:(NSUInteger)cost withBlock:(void(^)(void))block;

- (void)trimToAge:(NSTimeInterval)age;
- (void)trimToAge:(NSTimeInterval)age withBlock:(void(^)(void))block;

#pragma mark -Extended Data
+ (nullable NSData *)getExtendedDataFromObject:(id)object;
+ (void)setExtendedData:(nullable NSData *)extendedData toObject:(id)object;

@end

NS_ASSUME_NONNULL_END
