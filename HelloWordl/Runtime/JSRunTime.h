//
//  JSRunTime.h
//  HelloWordl
//
//  Created by lmg on 2019/4/29.
//  Copyright © 2019 lmg. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JSRunTime : NSObject
/*
 Runtime是C语言和汇编语言写的，OC是一门动态语言，这意味着它不仅需要一个编译器，还需要一个运行时系统来动态的创建类和对象。进行消息传递和转发
 
 类对象（objc_class）
 实例（objc_object）
 元类（meta_class）
 Method
 SEL
 selector
 类缓存objc_cache
 分类
 
 
 RunTime消息传递流程
 1.通过对象的isa指针找到对应的class
 2.在class的cache中找，如果找到，就去执行
 3.cache中找不到去method_List中找，找到就加入cache然后去执行
 4.找不到就去父类的method——list中找，一直到基类，找到就加入cache然后去执行
 5.找不到就走消息转发的流程
 
 
 RunTime消息转发流程
 1.动态方法解析
 2.备源接受者
 3.完整的消息转发流程
 3.1 methodSignatureForSelector:创建方法签名
 3.2 走forwardInvocation
 3.3 doesNotRecognizerSelector
 
 
 Runtime的应用：
 1.Method Swizzling
 2.实现给分类增加属性
 3.实现字典和模型的自动转换
 4.JSPatch动态创建类，新增方法，成员变量，协议，消息转发等
 5.实现NSCoding的自动归档和自动解档
 6.KVO的实现
 
 
 
 
 
 
 */


@end

NS_ASSUME_NONNULL_END
