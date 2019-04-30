//
//  JSLock.m
//  MainProject
//
//  Created by lmg on 2019/3/27.
//  Copyright © 2019 lmg. All rights reserved.
//

#import "JSLock.h"
#import <pthread/pthread.h>

#define Lock() pthread_mutex_lock(&self->_lock)
#define Unlock() pthread_mutex_unlock(&self->_lock)

@implementation JSLock
{
    pthread_mutex_t _lock;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
//        [self synchronizedTest];
//        [self semaphoreTest];
//        [self NSLockTest];
        [self pthreadMutexTest];
    }
    return self;
}

/**
 互斥锁
 优点：不需要在代码中显式的创建锁对象，便可以实现锁的机制
 缺点：作为一种预防机制，会隐式的添加一个异常处理例程来保护代码，该处理例程会在异常处理的时候自动的释放互斥锁
 */
- (void)synchronizedTest{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        @synchronized (self) {
            NSLog(@"需要线程同步的操作1 开始----%@",[NSThread currentThread]);
            sleep(10);
            NSLog(@"需要线程同步的操作1 结束-----%@",[NSThread currentThread]);
        }
    });
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        sleep(1);
        @synchronized (self) {
            NSLog(@"需要线程同步的操作2----%@",[NSThread currentThread]);
        }
    });
}

/**
 信号量设为1的情况下可以当锁来用，在没有等待的情况下,它的性能比pthread_mutex还要高，但一旦有等待出现，性能就会下降很多
 */
- (void)semaphoreTest{
    dispatch_semaphore_t signal = dispatch_semaphore_create(0);
    dispatch_time_t overTime = dispatch_time(DISPATCH_TIME_NOW, 3*NSEC_PER_SEC);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       
        NSLog(@"需要线程同步的操作1 开始------%@",[NSThread currentThread]);
        sleep(2);
        NSLog(@"需要线程同步的操作1 结束------%@",[NSThread currentThread]);
        dispatch_semaphore_signal(signal);
    });
     dispatch_semaphore_wait(signal, overTime);
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);
        NSLog(@"需要线程同步的操作2------%@",[NSThread currentThread]);
        dispatch_semaphore_signal(signal);
    });
     dispatch_semaphore_wait(signal, overTime);
   
}

/**
 最常用的锁
 */
- (void)NSLockTest{
    NSLock *lock = [[NSLock alloc]init];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [lock lockBeforeDate:[NSDate dateWithTimeIntervalSinceNow:1000]];
        NSLog(@"1111111111");
        sleep(5);
        NSLog(@"2222222222");
        [lock unlock];
    });
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [lock lockBeforeDate:[NSDate dateWithTimeIntervalSinceNow:1000]];
        NSLog(@"3333333333");
        sleep(1);
        NSLog(@"4444444444");
        [lock unlock];
    });
}


- (void)pthreadMutexTest
{
    pthread_mutex_init(&_lock, NULL);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        Lock();
        NSLog(@"11111111111----%@",[NSThread currentThread]);
        sleep(3);
        NSLog(@"222222222222----%@",[NSThread currentThread]);
        Unlock();
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        Lock();
        NSLog(@"333333333----%@",[NSThread currentThread]);
        sleep(1);
        NSLog(@"44444444444----%@",[NSThread currentThread]);
        Unlock();
    });
    
    
//    pthread_mutex_t _lock;
//    pthread_mutex_init(&_lock, NULL);
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        Lock();
//        NSLog(@"需要线程同步的操作1 开始");
//        sleep(4);
//        NSLog(@"需要线程同步的操作1 结束");
//        Unlock();
//    });
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        sleep(1);
//        Lock();
//        NSLog(@"需要线程同步的操作2 开始");
//        Unlock();
//    });
    
}

@end
