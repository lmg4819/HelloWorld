//
//  SectionThree.m
//  PushProject
//
//  Created by lmg on 2019/5/21.
//  Copyright © 2019 lmg. All rights reserved.
//

#import "SectionThree.h"

@implementation SectionThree

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
/*
 输入某二叉树前序遍历和中序遍历的结果，请重建该二叉树，假设输入的前序遍历和中序遍历的结果中都不含重复的数字。例如，输入前序遍历序列{1,2,4,7,3,5,6,8}和中序遍历序列{4,7,2,1,5,3,8,6},则重建如图所示的二叉树并输入他的头结点，二叉树的定义如下
 
 1  { 2 {4 7}} {3 {5 {6 8}}}
 {{4 7} 2} 1 {5 {3} 8 6}
        1
     2     3
  4     5     6
    7      8
 
 */
- (void)questionOne
{
    
}

/*
 给定一颗二叉树和其中的一个节点，如何找出中序遍历序列的下一个节点，树中的节点除了有两个分别指向左，右子节点的指针，还有一个指向父节点的指针
              a
        b              c
    d       e      f        g
          h   i
 
 中序遍历{d b h e i a f c g}
 */
- (void)questionTwo
{
    
}

@end
