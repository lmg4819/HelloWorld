//
//  YYCacheAyalyse.h
//  HelloWordl
//
//  Created by lmg on 2019/5/9.
//  Copyright © 2019 lmg. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYCacheAyalyse : NSObject
/*
 使用LRU（least-recently-used）算法
 最近最少使用算法
 
 YYMemoryCache:容量小但是高速内存缓存
 加锁用的是互斥锁
 提供cost,age,count三个维度控制大小
 收到内存警告或者进入后台时清除缓存
 缓存自动清理时间间隔5s
 头结点（MRU最常用节点）
 尾节点（LRU最少用节点）
 
 YYDiskCache:容量大但是低速磁盘缓存
 加锁用的是信号量
 提供cost,age,count,freeDiskSpace四个维度控制大小
 应用将要被杀死时清除对象
 缓存自动清理时间间隔60s
 
 
 缓存策略：
 FIFO (First In First Out)
 MRU (Most Recently Used)
 
 LRU认为用户最新使用过的对象为高频缓存对象，即用户很有可能还会再次使用该缓存对象，而反之，用户很久
 之前使用过的对象为低频缓存对象，即用户很可能不会再使用该缓存对象，通常在资源不足时会先去释放低频缓存对象。
 
 
 */
@end

NS_ASSUME_NONNULL_END
