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
 
 
 
 锁的性能问题：从高到低
 1.OSSpinLock
 2.dispatch_semaphore(信号量)
 3.pthread_mutex(互斥锁)
 4.NSLock()
 5.@synchronized
 
 
 */
@end

NS_ASSUME_NONNULL_END
