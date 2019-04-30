//
//  JSThread.m
//  MainProject
//
//  Created by lmg on 2019/3/27.
//  Copyright © 2019 lmg. All rights reserved.
//

#import "JSThread.h"

@interface JSThread ()

@property (nonatomic,strong) dispatch_queue_t serialQueue;
@property (nonatomic,strong) dispatch_queue_t conCurrentQueue;

@end

@implementation JSThread

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.serialQueue = dispatch_queue_create("com.cn.cheyipai.serial", DISPATCH_QUEUE_SERIAL);
        //        self.serialQueue = dispatch_get_main_queue();
        
        self.conCurrentQueue = dispatch_queue_create("com.cn.cheyipai.concurrent", DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}
/*
 一般情况下，如果一个NSBlockOperation对象封装了多个操作，NSBlockOperation 是否开启新线程，取决于操作的个数，如果添加的操作的个数多，就会自动开启新线程。
 当然开启的线程数是由系统决定的。
 
 maxConcurrentOperationCount控制的并不是并发线程的数量，而是一个队列中同时能并发执行的最大操作数，而且一个操作也并非只能在一个线程中执行。
 开启线程是由系统决定的，不需要我们自己来决定。
 默认为-1，不限制，1时为串行队列，大于1时为并行队列
 
 queuePriority属性决定了进入准备就绪状态下的操作之间的开始执行顺序
 并且，优先级不能取代依赖关系
 
 
 1.设置并发执行的最大操作数
 2.任务间添加依赖
 3.设置任务优先级
 4.可以取消操作
 5.可以KVO观察任务的执行状况
 
 
 线程同步和线程安全的问题
 
 
 这里的暂停和取消（包括操作的取消和队列的取消），并不代表可以将当前的操作立刻取消，而是当当前的操作完成以后不再执行新的操作
 暂停和取消的区别是：暂停操作之后还可以恢复操作，继续向下执行；而取消所有操作之后，所有的操作都清空了，无法再继续执行剩下的操作
 
 锁可能存在的问题：
 死锁
 资源饥饿
 优先级反转
 尽量减少资源间线程共享
 
 */

/*
 同步+串行
 在当前线程执行，不会创建新线程
 当前线程为主线程，任务执行的队列为串行队列时，会在主线程执行
 当前线程为主线程，任务执行的队列为主队列时，会崩溃
 主队列是特殊的串行队列
 新线程：0
 */
- (void)sync_SerialQueue{
    dispatch_sync(self.serialQueue, ^{
        NSLog(@"1111111-----%@",[NSThread currentThread]);
    });
    
    dispatch_sync(self.serialQueue, ^{
        NSLog(@"2222222-----%@",[NSThread currentThread]);
    });
    
    dispatch_sync(self.serialQueue, ^{
        NSLog(@"3333333-----%@",[NSThread currentThread]);
    });
    
    dispatch_sync(self.serialQueue, ^{
        NSLog(@"4444444-----%@",[NSThread currentThread]);
    });
    
    dispatch_sync(self.serialQueue, ^{
        NSLog(@"5555555-----%@",[NSThread currentThread]);
    });
    
    dispatch_sync(self.serialQueue, ^{
        NSLog(@"6666666-----%@",[NSThread currentThread]);
    });
}

/**
 同步+并行
 在当前线程执行，不会创建新线程
 当前线程为主线程，任务执行的队列为并行队列时，会在主线程执行
 全局队列是并行队列
 新线程：0
 */
- (void)sync_ConCurrent{
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"1111111-----%@",[NSThread currentThread]);
    });
    
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"2222222-----%@",[NSThread currentThread]);
    });
    
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"3333333-----%@",[NSThread currentThread]);
    });
    
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"4444444-----%@",[NSThread currentThread]);
    });
    
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"5555555-----%@",[NSThread currentThread]);
    });
    
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"6666666-----%@",[NSThread currentThread]);
    });
}


/**
 异步+串行
 串行队列为主队列时，不会创建新线程，主队列只有一条主线程
 串行队列为其他队列时，会创建一条新线程
 
 新线程： <= 1
 */
- (void)async_SerialQueue{
    dispatch_async(self.serialQueue, ^{
        NSLog(@"1111111-----%@",[NSThread currentThread]);
    });
    
    dispatch_async(self.serialQueue, ^{
        NSLog(@"2222222-----%@",[NSThread currentThread]);
    });
    
    dispatch_async(self.serialQueue, ^{
        NSLog(@"3333333-----%@",[NSThread currentThread]);
    });
    
    dispatch_async(self.serialQueue, ^{
        NSLog(@"4444444-----%@",[NSThread currentThread]);
    });
    
    dispatch_async(self.serialQueue, ^{
        NSLog(@"5555555-----%@",[NSThread currentThread]);
    });
    
    dispatch_async(self.serialQueue, ^{
        NSLog(@"6666666-----%@",[NSThread currentThread]);
    });
}


/**
 异步+并行
 创建一条或多条新线程
 新线程： >= 1
 */
- (void)async_ConCurrent{
    dispatch_async(self.conCurrentQueue, ^{
        NSLog(@"1111111-----%@",[NSThread currentThread]);
    });
    
    dispatch_async(self.conCurrentQueue, ^{
        NSLog(@"2222222-----%@",[NSThread currentThread]);
    });
    
    dispatch_async(self.conCurrentQueue, ^{
        NSLog(@"3333333-----%@",[NSThread currentThread]);
    });
    
    dispatch_async(self.conCurrentQueue, ^{
        NSLog(@"4444444-----%@",[NSThread currentThread]);
    });
    
    dispatch_async(self.conCurrentQueue, ^{
        NSLog(@"5555555-----%@",[NSThread currentThread]);
    });
    
    dispatch_async(self.conCurrentQueue, ^{
        NSLog(@"6666666-----%@",[NSThread currentThread]);
    });
}


/**
 信号量管理
 创建信号量不能小于0，信号量为0则堵塞线程，大于0则不会堵塞，我们通过改变信号量的值，来控制是否堵塞线程，从而达到线程同步
 创建时为0 则先signal再wait
 创建时为1，则先wait再signal
 dispatch_semaphore_wait:信号量-1
 dispatch_semaphore_signal:信号量+1
 */
- (void)semephore{
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    
    dispatch_async(self.conCurrentQueue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"run task 1");
        sleep(5);
        NSLog(@"complete task 1");
        dispatch_semaphore_signal(semaphore);
    });
    
    dispatch_async(self.conCurrentQueue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"run task 2");
        sleep(1);
        NSLog(@"complete task 2");
        dispatch_semaphore_signal(semaphore);
    });
    
    dispatch_async(self.conCurrentQueue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"run task 3");
        sleep(3);
        NSLog(@"complete task 3");
        dispatch_semaphore_signal(semaphore);
    });
}

/**
 线程障碍
 */
- (void)barrier{
    dispatch_async(self.conCurrentQueue, ^{
        NSLog(@"%@---111111",[NSThread currentThread]);
    });
    
    NSLog(@"------big------");
    NSLog(@"------small------");
    
    dispatch_async(self.conCurrentQueue, ^{
        NSLog(@"%@---222222",[NSThread currentThread]);
    });
    
    dispatch_barrier_async(self.conCurrentQueue, ^{
        NSLog(@"-----barrier----%@",[NSThread currentThread]);
    });
    
    
    dispatch_async(self.conCurrentQueue, ^{
        NSLog(@"%@---333333",[NSThread currentThread]);
    });
    
    
    dispatch_async(self.conCurrentQueue, ^{
        NSLog(@"%@---444444",[NSThread currentThread]);
    });
}

@end
