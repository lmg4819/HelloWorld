//
//  JSMemory.h
//  HelloWordl
//
//  Created by lmg on 2019/4/30.
//  Copyright © 2019 lmg. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JSMemory : NSObject
/*
 常见的内存泄露的几种情况：
 1.AFNetworking内存泄露，使用单例模式
 2.block的循环引用，使用弱引用
 3.delegate循环引用,将代理属性设置为nil
 4.NSTimer循环引用，将NSTimer调用停止，并置为nil
 5.非OC对象内存管理，手动释放内存
 6.地图类处理，使用完毕时将地图，代理等置为nil
 7.大次数循环内存暴涨问题，使用自动释放池。（短时间内产生大量的临时对象，直至循环结束才释放，可能导致内存泄露）
 
 
 属性的内存管理语义：
 原子性：
 atomic
 nonatomic iOS上会影响性能，默认为atomic，但是推荐使用nonatoic
 
 设置器语义：
 assign:默认设置，执行简单的赋值操作
 retain:在赋值时，输入值会被发送一条保留消息，而上一个值会被发送一条释放消息
 copy:在赋值时，输入值会被发送一条新消息的副本，而上一条值会被发送一条释放消息
 strong:在ARC下，和retain相同
 weak:在ARC下，和assign特性类似，但如果引用对象被释放了，属性的值会被设置为nil
 
 
 可读写性：
 readwrite：默认属性，必须实现getter和setter方法
 readonly：只读，必须实现getter方法
 
 方法名称：
 setter：将setter方法设置为新设置器的方法
 getter：将getter方法设置为新读取器的方法
 
 开发项目时你是怎么检查内存泄露？
 1.静态分析
 2.instruments-->leaks
 3.腾讯的MLeaksFinder
 
 __unsafe_unretained存在的原因：
 1.__weak只支持iOS5.0和OS X Mountain Lion，iOS4.0的话只能使用__unsafe_unretained
 2.__weak对性能会有一定的损耗，当一个对象里面有大量__weak引用对象的时候，如果对象被废弃，那么就要遍历weak表，把表里所有的指针置空消耗CPU资源。
 
 
 -fobjc-arc 设置ARC有效
 -fno-objc-arc 设置ARC无效
 
 */
@end

NS_ASSUME_NONNULL_END
