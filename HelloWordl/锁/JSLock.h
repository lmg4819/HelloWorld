//
//  JSLock.h
//  MainProject
//
//  Created by lmg on 2019/3/27.
//  Copyright © 2019 lmg. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JSLock : NSObject
/*
 1.OSSpinLock(已弃用)
 2.dispatch_semaphore(信号量)
 3.pthread_mutex(线程锁)
 4.NSLock
 5.NSCondition
 6.NSReursiveLock
 7.NSConditionLock
 8.@synchronized
 
 
 
 锁的性能问题：从高到低   1000000次加锁
 1.OSSpinLock   15.07 ms
 2.dispatch_semaphore(信号量)   17.99 ms
 3.pthread_mutex(互斥锁)        22.98 ms
 4.NSCondition                 24.29 ms
 5.NSLock()                    24.63 ms
 6.pthread_mutex(recursive)    39.08 ms
 7.NSRecursiveLock             48.07 ms
 8.NSConditionLock             80.26 ms
 9.@synchronized               118.84 ms
 
 
 临界区：每个进程中访问临界资源的那段程序称为临界区，每次只允许一个进程进入临界区，进入后不允许其他进程进入。
 互斥锁：用于保护临界区，确保同一时间只有一个线程访问数据。对共享资源的访问，先对互斥量进行加锁，如果互斥量已经上锁，调用线程会阻塞，直到互斥量被解锁。在完成了对共享资源的访问后，要对互斥量进行解锁。
 自旋锁：与互斥量类似，它不是通过休眠使进程阻塞，而是在获取锁之前一直处于忙等(自旋)阻塞状态。用在以下情况：锁持有的时间短，而且线程并不希望在重新调度上花太多的成本。"原地打转"，这样的好处是节省了线程从睡眠状态到唤醒之间内核会产生的消耗。
 读写锁：是计算机程序的并发控制的一种同步机制，也称”共享-互斥锁“或"多读者锁"用于解决多线程对公共资源读写问题，读操作可并发重入，写操作是互斥的。读写锁通常用互斥锁，信号量，条件变量实现
 信号量：信号量是一个计数器，可以用来控制多个进程对共享资源的访问。它常作为一种锁机制，防止某进程正在访问共享资源时，其他进程也访问该资源。因此，主要作为进程间以及同一进程内不同线程之间的同步手段。
 递归锁：在被同一线程重复获取时不会产生死锁
 条件锁：就是条件变量，当进程的某些资源要求不满足时就进入休眠，也就是锁住了。当资源被分配到了，条件锁打开，进程继续进行。
 自旋锁是一种互斥锁的实现方式而已，相比一般的互斥锁会在等待期间放弃cpu，自旋锁（spinlock）则是不断循环并测试锁的状态，这样就一直占着cpu。
 自旋锁与互斥锁的区别：线程在申请自旋锁的时候，线程不会被挂起，而是处于忙等的状态。
 
 互斥锁：
 1.NSLock  在AFNetworking中使用
 2.pthread_mutex   在YYKit中使用
 3.@synchronized   在AFNetworking中，JSPatch中，SDWebImage使用
 自旋锁：
 OSSpinLock
 读写锁：
 pthread_rwlock
 递归锁：
 NSRecursiveLock
 pthread_mutex（recursive）pthread_mutex锁也支持递归，只需要设置PTHRED_MUTEX_RECURSIVE即可
 条件锁：
 1.NSCondition
 2.NSConditionLock
 信号量：
 dispatch_semaphore
 
 
 
 */
@end

NS_ASSUME_NONNULL_END
