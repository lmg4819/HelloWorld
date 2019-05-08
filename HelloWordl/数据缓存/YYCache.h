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



@end

NS_ASSUME_NONNULL_END
