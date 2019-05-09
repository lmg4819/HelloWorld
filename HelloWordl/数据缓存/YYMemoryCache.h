//
//  YYMemoryCache.h
//  HelloWordl
//
//  Created by lmg on 2019/5/7.
//  Copyright © 2019 lmg. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/*
 LRU 最近最少使用算法
 MRU 最近最常使用算法
 
 */
@interface YYMemoryCache : NSObject

@property (nullable,copy) NSString *name;
@property (readonly) NSUInteger totalCount;
@property (readonly) NSUInteger totalCost;

#pragma mark -Limit

@property NSUInteger countLimit;
@property NSUInteger costLimit;
@property NSTimeInterval ageLimit;
/*
 The default value is 5s
 */
@property NSTimeInterval autoTrimInterval;

/**
 The default value is 'YES'
 */
@property BOOL shouldRemoveAllObjectsOnMemoryWarning;


/**
 The default value is `YES`
 */
@property BOOL shouldRemoveAllObjectsWhenEnteringBackground;

@property (nullable,copy) void(^didReceiveMemoryWarningBlock)(YYMemoryCache *cache);

@property (nullable,copy) void(^didEnterBackgroundBlock)(YYMemoryCache *cache);

/**
 Default is NO.
 */
@property BOOL releaseOnMainThread;

/**
 Default is YES.
 */
@property BOOL releaseAsynchronously;

#pragma mark -Access Methods

- (BOOL)containsObjectForKey:(id)key;
- (nullable id)objectForKey:(id)key;
- (void)setObject:(nullable id)object forKey:(id)key;
- (void)setObject:(nullable id)object forKey:(id)key withCost:(NSUInteger)cost;
- (void)removeObjectForKey:(id)key;
- (void)removeAllObjects;

#pragma mark -Trim
- (void)trimToCount:(NSUInteger)count;
- (void)trimToCost:(NSUInteger)cost;
- (void)trimToAge:(NSTimeInterval)age;

@end

NS_ASSUME_NONNULL_END
