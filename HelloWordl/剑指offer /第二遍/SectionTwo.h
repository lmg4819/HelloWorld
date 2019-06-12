//
//  SectionTwo.h
//  PushProject
//
//  Created by lmg on 2019/5/21.
//  Copyright © 2019 lmg. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SectionTwo : NSObject
/*
 字符串是由若干字符组成的序列
 链表由指针把若干个节点连接成链状结构，链表是一种动态数据结构，内存分配不是在创建链表时一次性完成的，而是没添加一个节点分配一次内存，由于没有闲置的内存，链表的空间效率比数组高。
 
 由于链表中的内存不是一次性分配的，因而我们无法保证链表的内存和数组一样是连续的，因此，要想在链表中找到它的第i个节点，那么我们只能从头节点开始，沿着指向下一个节点的指针遍历链表，它的时间效率为0（n），而在数组中，我们可以根据下标在0（1）时间内找到第i个元素
 */
@end

@interface ListNode : NSObject
@property (nonatomic,assign) int  m_nKey;
@property (nonatomic,strong) ListNode *m_pNext;
- (instancetype)initWithValue:(int)value;
@end

NS_ASSUME_NONNULL_END
