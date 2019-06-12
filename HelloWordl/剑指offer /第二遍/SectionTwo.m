//
//  SectionTwo.m
//  PushProject
//
//  Created by lmg on 2019/5/21.
//  Copyright © 2019 lmg. All rights reserved.
//

#import "SectionTwo.h"

@implementation SectionTwo

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self questionOne];
        
        ListNode *node = [[ListNode alloc]initWithValue:2];
        node.m_pNext = [[ListNode alloc]initWithValue:3];
        node.m_pNext.m_pNext = [[ListNode alloc]initWithValue:4];
        node.m_pNext.m_pNext.m_pNext = [[ListNode alloc]initWithValue:5];
        
        [self printNodeWithListNode:node];
        
    }
    return self;
}
/*
 请实现一个函数，把字符串中的每个空格替换成20%，例如，输入，we are happy.,则输出“we20%are20%happy.”
 
 解法：
 1.从前向后遍历，遇到一个就替换一个，由于后边的元素每次都要后移，时间复杂度为0（n2）
 2.先遍历字符串，计算出空格的个数，计算出替换后字符的总长度，从后向前移动，每个字符只移动一次，
 时间复杂度为0（n）
 */
- (void)questionOne
{
    
}

/*
 输入一个链表的头节点，从尾到头反过来打印出每个节点的值
 1.while循环
 2.递归
 */
- (void)printNodeWithListNode:(ListNode *)listNode
{
//    NSMutableArray *array = [NSMutableArray array];
//    ListNode *node = listNode;
//    while (node) {
//        [array addObject:@(node.m_nKey)];
//        node = node.m_pNext;
//    }
//    for (NSNumber *number in array.reverseObjectEnumerator) {
//        NSLog(@"----%@----",number);
//    }
    if (listNode) {
        [self printNodeWithListNode:listNode.m_pNext];
        NSLog(@"%d",listNode.m_nKey);
    }
}

@end

@implementation ListNode

- (instancetype)initWithValue:(int)value
{
    self = [super init];
    if (self) {
        _m_nKey = value;
    }
    return self;
}

@end
