//
//  YYCache.h
//  HelloWordl
//
//  Created by lmg on 2019/5/7.
//  Copyright © 2019 lmg. All rights reserved.
//

#import <Foundation/Foundation.h>

#if __has_include(<YYCache/YYCache.h>)
FOUNDATION_EXPORT double YYCacheVersionNumber;
FOUNDATION_EXPORT const unsigned char YYCacheVersionString[];
#import <YYCache/YYMemoryCache.h>
#import <YYCache/YYDiskCache.h>
#import <YYCache/YYKVStorage.h>
#elif __has_include(<YYWebImage/YYCache.h>)
#import <YYWebImage/YYMemoryCache.h>
#import <YYWebImage/YYDiskCache.h>
#import <YYWebImage/YYKVStorage.h>
#else
#import "YYMemoryCache.h"
#import "YYDiskCache.h"
#import "YYKVStorage.h"
#endif


NS_ASSUME_NONNULL_BEGIN

@interface YYCache : NSObject

@property (readonly,copy) NSString *name;
@property (strong,readonly) YYMemoryCache *memoryCache;
@property (strong,readonly) YYDiskCache *diskCache;
- (nullable instancetype)initWithName:(NSString *)name;
+ (nullable instancetype)cacheWithName:(NSString *)name;
- (nullable instancetype)initWithPath:(NSString *)path NS_DESIGNATED_INITIALIZER;
+ (nullable instancetype)cacheWithPath:(NSString *)path;

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

#pragma mark -Access Methods

- (BOOL)containsObjectForKey:(NSString *)key;
- (void)containsObjectForKey:(NSString *)key withBlock:(nonnull void (^)(NSString *key, BOOL contains))block;

- (nullable id<NSCoding>)objectForKey:(NSString *)key;
- (void)objectForKey:(NSString *)key withBlock:(nullable void(^)(NSString *key,id<NSCoding> object))block;

- (void)setObject:(nullable id<NSCoding>)object forKey:(NSString *)key;
- (void)setObject:(nullable id<NSCoding>)object forKey:(NSString *)key withBlock:(nonnull void (^)(void))block;

- (void)removeObjectForKey:(NSString *)key;
- (void)removeObjectForKey:(NSString *)key withBlock:(nonnull void (^)(NSString *key))block;

- (void)removeAllObjects;
- (void)removeAllObjectsWithBlock:(void(^)(void))block;
- (void)removeAllObjectsWithProgressBlock:(nullable void(^)(int removedCount,int totalCount))progress endBlock:(nullable void(^)(BOOL error))end;


@end

NS_ASSUME_NONNULL_END
