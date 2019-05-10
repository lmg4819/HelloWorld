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
 FIFO (First In First Out):先进先出算法
 LFU(least-Frequently-Used):淘汰一定时间内被访问次数最少的数据，以访问次数为依据
 LRU（least-recently-Used）:淘汰最长时间未被使用的数据，以访问时间作为参考
 
 LRU认为用户最新使用过的对象为高频缓存对象，即用户很有可能还会再次使用该缓存对象，而反之，用户很久
 之前使用过的对象为低频缓存对象，即用户很可能不会再使用该缓存对象，通常在资源不足时会先去释放低频缓存对象。
 
 如何设计一个数据缓存
 1.数据缓存分为内存缓存和磁盘缓存，要确定缓存方式，内存缓存提供快速但是容量小的缓存，磁盘缓存提供低速但是
 容量大的缓存
 2.确定缓存策略，LRU（least-recently-Used），LFU(least-Frequently-Used)，FIFO(先进先出算法)，提高缓存命中率
 3.缓存控制，cost,age,count，freeSpace(磁盘缓存)
 4.数据缓存清除方式，自动清理和手动清理，内存缓存可以5s清理一次，磁盘缓存要60s清理一次
 5.清理缓存时机，内存缓存要在应用进入后台或者内存报警的时候清除，磁盘缓存要在应用被杀死的时候清除
 6.内存缓存实现方式，双向链表，最新访问的数据放在head位置，最久未访问的放在tail位置
 7.磁盘缓存分为数据库缓存和文件缓存，设置阈值，大于20KB存为文件,小于20KB存为数据库data
 8.访问缓存策略，先访问内存缓存，没有的话再访问磁盘缓存，然后把访问的数据缓存到内存，以便后续的快速高效的访问
 
 使用的减少内存消耗的小tips：
 1.异步释放缓存对象
 2.锁的选择
 3.使用CoreFouadation来换取微乎其微的性能提升
 
 
 CPU消耗资源和解决方案
 1.对象的创建  尽量使用轻量级对象，比如用CALayer代替UIView
 2.对象调整  尽量避免调整视图层次，添加和移除视图
 3.对象的销毁  将对象捕获到block中，然后扔到后台队列去随便发个消息，就可以让对象在后台线程销毁了
 4.布局计算   后台线程计算好视图布局，然后对视图布局进行缓存，不要多次，频繁的计算和调整这些属性
 5.文本计算
 6.文本渲染
 7.图片解码
 8.图像的绘制
 
 GPU消耗资源和解决方案
 1.纹理的渲染
 2.视图的混合
 3.图形的生成
 
 
 */
@end

NS_ASSUME_NONNULL_END
