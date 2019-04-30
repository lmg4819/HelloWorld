//
//  JSRunLoop.h
//  HelloWordl
//
//  Created by lmg on 2019/4/29.
//  Copyright © 2019 lmg. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JSRunLoop : NSObject
/*
 RunLoop:运行循环，用来处理程序运行过程中出现的各种事件（比如说触摸事件，UI刷新事件，定时器事件，Selector事件），从而保证程序的持续运行，在没有事件处理的时候，会使线程处于休眠模式，从而节省CPU资源，提高程序性能
 
 RunLoop和线程之间的关系：默认情况下，线程执行完任务就会退出，就不能再执行任务了，这时我们就需要采用一种方式来让线程不断的处理任务，并不退出
 1.一个线程对应一个RunLoop，每个线程都有唯一对应的RunLoop对象
 2.线程的RunLoop对象是懒加载的，第一次获取时创建，销毁则是在线程结束的时候
 3.主线程的RunLoop对象系统已经帮我们创建好了，而子线程的RunLoop则需要我们主动创建和维护
 
 RunLoop就是线程中的一个循环，RunLoop会在循环中不断检测，通过Input Sources(输入源)和Timer Sources(定时源)两种来源等待接收事件，然后对接收到的事件通知线程进行处理，并在没有事件的时候让线程进行休息。
 
 一个RunLoop对象中包含若干个运行模式（RunLoopMode），每一个运行模式下又包含若干个输入源（RunLoopSource）,定时源（RunLoopTimer），观察者(RunLoopObserver)
 1.每次RunLoop启动时，只能指定其中一个运行模式，这个运行模式被称作当前运行模式
 2.如果需要切换运行模式，只能退出当前运行模式，再重新指定一个运行模式进入
 3.这样主要是为了分隔开不同组的输入源，定时源，观察者，让其互不影响
 
 
 Mode：
 kCFRunLoopModeDefaultMode:APP的默认运行方式，通常主线程在这个模式下运行
 UITrackingRunLoopMode：跟踪用户交互事件（保证页面滑动时不受其他Mode影响）
 UIInitializationRunLoopMode:在刚启动APP时进入的第一个Mode，启动完成后就不再使用
 GSEventReceiveRunLoopMode：接受系统内部事件，通常用不到
 kCFRunLoopCommonModes：伪模式，不是一种真正的模式
 
 
 CFRunLoopObserverRef可以监听的状态改变：
 1.kCFRunLoopEntry：即将进入RunLoop 1
 2.kCFRunLoopBeforeTimers: 即将处理Timer  2
 3.kCFRunLoopBeforeSources:即将处理Source   4
 4.kCFRunLoopBeforeWaiting:即将进入休眠    32
 5.kCFRunLoopAfterWaiting:即将从休眠中唤醒   64
 6.kCFRunLoopExit:即将从Loop中退出  128 
 7.kCFRunLoopAllActivities:监听全部状态改变 
 
 
 RunLoop在开发中的使用
 1.NSTimer在滑动时停止的问题
 2.ImageView延迟加载
 3.后台常驻线程
 

 */
@end

NS_ASSUME_NONNULL_END
