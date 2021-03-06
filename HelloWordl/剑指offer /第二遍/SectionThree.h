//
//  SectionThree.h
//  PushProject
//
//  Created by lmg on 2019/5/21.
//  Copyright © 2019 lmg. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SectionThree : NSObject
/*
        10
   6           14
4     8     12    16
 
 
 在二叉树中每个节点最多只能有两个子节点：
 前序遍历：  根  左  右   10 6 1 8 14 12 16
 中序遍历：  左  根  右   4 6 8 10 12 14 16
 后序遍历：  左  右  根   4 8 6 12 16 14 10
 层序遍历（宽度优先遍历）   10 6 14 4 8 12 16
 
 二叉搜索树：左子节点总是小于或等于根节点，而右子节点总是大于或等于根节点
 我们可以平均在 0（logn）的时间内根据数值在二叉搜索树中找出一个节点
 
 堆：大顶堆和小顶堆
 大顶堆中跟节点的值最大，小顶堆中根节点的堆最小
 在许多需要快速找到最大值或者最小值的问题都可以用堆来解决
 
 红黑树是把树中的节点定义为红黑两种颜色，并通过规则确保从根节点到叶节点的长度不超过最短路径的两倍
 。
 
 
 二叉树的优点：
 二叉搜索树是一种比较有用的折中方案
 平衡二叉搜索树，又被称为AVL树
 
 
 数组的搜索比较方便，可以直接用下标，但是删除或者插入某些元素就比较麻烦。
 链表与之相反，删除和插入元素很快，但查找很慢
 二叉排序树既有数组的好处，也有链表的好处。
 在处理大批量的动态的数据时比较有用
 
 
 AVL树具有以下性质：
 它是一颗空树，或者它的左右两个子树的高度差的绝对值不超过1，并且左右两个子树都是一颗平衡二叉树。
 由于普通的二叉查找树会容易失去平衡，极端情况下，二叉查找树会退化成线性的链表，导致插入和查找的复杂度下降到0（n），所以，这也是平衡二叉树设计的初衷
 
 当有新的节点插入时，检查是否因插入后而破坏了树的平衡，如果是，则需要做旋转改变树的结构
 
 左旋
 
 右旋
 
 */
@end

NS_ASSUME_NONNULL_END
