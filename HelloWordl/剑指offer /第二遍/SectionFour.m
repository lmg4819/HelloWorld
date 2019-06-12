//
//  SectionFour.m
//  PushProject
//
//  Created by lmg on 2019/5/21.
//  Copyright © 2019 lmg. All rights reserved.
//

#import "SectionFour.h"

@implementation SectionFour

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self questionOne];
    }
    return self;
}
/*
 用两个栈实现一个队列。队列的声明如下，请实现它的两个函数appendTail和deleteHead，分别实现在队尾插入节点和对头删除节点的功能。
 {1,2,3,4}
 stack1  {a,b,c} 栈顶
 
 stack2  {}
 
 
 删除
 stack1  {}
 stack2  {c,b,   //a} 栈顶
 
 
 插入
 stack1 {d}
 stack2 {c,b}
 
 
 用两个队列实现一个栈
 queue1  {c,b,a}
 queue2  {}
 
 queue1  {c}
 queue2  {b,a}
 
 删除
 queue1 {}
 queue2 {b,a}
 
 插入
 queue1 {a}
 queue2 {}
 */
- (void)questionOne
{
    
}

@end
