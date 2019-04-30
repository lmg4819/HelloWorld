//
//  JSThread.h
//  HelloWordl
//
//  Created by lmg on 2019/4/29.
//  Copyright © 2019 lmg. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JSThread : NSObject
/*
 iOS中多线程编程
 1.pthread
 2.NSThread
 3.GCD
 
 同步执行：不创建新线程，在当前线程执行任务
 异步执行：虽然具备开启新线程的能力，但是并不一定创建新线程，这和任务所指定的队列类型有关
 
 串行队列和并行队列，两者都符合先进先出的原则，两者的主要区别是，执行顺序不同，以及线程开启数不同
 
 同步执行+串行队列  不创建新线程，串行执行任务
 同步执行+主队列    如果在主线程，会死锁，不在主线程，会在主线程执行，不能创建新线程
 同步执行+并行队列  不创建新线程，串行执行任务
 
 异步执行+串行队列  创建一条新线程，串行执行任务
 异步执行+主队列    不创建新线程，串行执行任务
 异步执行+并行队列   创建一或多条新线程，并发执行任务
 
 《并发队列的并发功能，只有在异步函数下才有效》
 
 4.NSOperation和NSOperationQueue
 相比GCD的优点
 1.任务之间可以添加依赖
 2.可以使用KVO监听
 3.可以取消或者暂停
 4.可以设置任务优先级
 5.GCD是C语言语言的API，NSOperationQueue是OC对象
 6.NSOperationQueue可以设置最大并发执行任务数
 7.我们可以对NSOperation进行继承，可以添加更多自定制的功能
 8.GCD更底层，速度更快一些，对于简单的线程管理我们可以使用GCD，对于复杂的线程管理我们
 可以使用NSOpeartionQueue
 
 
 
 造成主线程阻塞的原因可能是：
 1.主线程在进行大量I/O操作，为了方便代码编写，直接在主线程去写入大量数据。
 2.主线程在进行大量计算：代码编写不合理，主线程进行复杂计算。
 3.大量UI绘制：界面过于复杂，UI绘制需要大量时间。
 4.主线程在等锁：主线程需要获取锁A，但是当前某个子线程持有这个锁A，导致主线程不得不等待子线程完成任务。
 */
@end

NS_ASSUME_NONNULL_END
