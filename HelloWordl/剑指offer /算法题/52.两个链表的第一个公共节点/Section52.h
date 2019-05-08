//
//  Section52.h
//  HelloWordl
//
//  Created by lmg on 2019/5/6.
//  Copyright © 2019 lmg. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Section52 : NSObject
/*
 输入两个链表，找出他们的第一个公共节点
 1.暴力法
 2.使用栈，后进先出，从栈顶开始找到最后一个相同的节点
 3.遍历两个链表得到他们的长度，长的链表上先走若干步，然后同时在两个链表上遍历，第一个相同的节点就是
 他们的第一个公共节点
 */
@end

NS_ASSUME_NONNULL_END
