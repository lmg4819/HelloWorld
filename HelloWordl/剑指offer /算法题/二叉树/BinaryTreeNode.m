//
//  BinaryTreeNode.m
//  HelloWordl
//
//  Created by lmg on 2019/5/6.
//  Copyright © 2019 lmg. All rights reserved.
//

#import "BinaryTreeNode.h"

@implementation BinaryTreeNode

@end

@implementation BinaryTree

+ (BinaryTreeNode *)createTreeWithValues:(NSArray *)values
{
    BinaryTreeNode *rootNode = nil;
    for (NSNumber *number in values) {
        NSInteger value = number.integerValue;
        rootNode = [self addTreeNode:rootNode value:value];
    }
    return rootNode;
}

+ (BinaryTreeNode *)addTreeNode:(BinaryTreeNode *)treeNode value:(NSInteger)value
{
    if (!treeNode) {
        treeNode = [BinaryTreeNode new];
        treeNode.value = value;
    }else if(value <= treeNode.value){
        treeNode.leftNode = [self addTreeNode:treeNode.leftNode value:value];
    }else
    {
        treeNode.rightNode = [self addTreeNode:treeNode.rightNode value:value];
    }
    return treeNode;
}
/*
 某个位置的节点
 */
+ (BinaryTreeNode *)treeNodeAtIndex:(int)index inTree:(BinaryTreeNode *)rootNode
{
    if (!rootNode || index < 0) {
        return nil;
    }
    NSMutableArray *queueArray = [NSMutableArray array]; //数组当成队列
    [queueArray addObject:rootNode]; //压入根节点
    while (queueArray.count > 0) {
        BinaryTreeNode *node = [queueArray firstObject];
        if (index == 0) {
            return node;
        }
        [queueArray removeObjectAtIndex:0];
        index--;
        if (node.leftNode) {
            [queueArray addObject:node.leftNode];
        }
        if (node.rightNode) {
            [queueArray addObject:node.rightNode];
        }
    }
    return nil;
}

/*
 前序遍历，递归 root---左---右
 */
+ (void)preOrderTravreseTree:(BinaryTreeNode *)rootNode handle:(void(^)(BinaryTreeNode *treeNode))handle
{
    if (rootNode) {
        if (handle) {
            handle(rootNode);
        }
        
        [self preOrderTravreseTree:rootNode.leftNode handle:handle];
        [self preOrderTravreseTree:rootNode.rightNode handle:handle];
    }
}
/*
 中序遍历  左-----root------右
 */
+ (void)inOrderTraverseTree:(BinaryTreeNode *)rootNode handle:(void(^)(BinaryTreeNode *treeNode))handle
{
    if (rootNode) {
        
        [self inOrderTraverseTree:rootNode.leftNode handle:handle];
        
        if (handle) {
            handle(rootNode);
        }
        
        [self inOrderTraverseTree:rootNode.rightNode handle:handle];
       
    }

}
/*
 后序遍历 左-----右-----root
 */
+ (void)postOrderTraverseTree:(BinaryTreeNode *)rootNode handle:(void(^)(BinaryTreeNode *treeNode))handle
{
    if (rootNode) {
        [self postOrderTraverseTree:rootNode.leftNode handle:handle];
        [self postOrderTraverseTree:rootNode.rightNode handle:handle];
        if (handle) {
            handle(rootNode);
        }
    }
}
/*
 层次遍历
 按照从上到下，从左到右的次序进行遍历，先遍历完一层，再遍历下一层，因此又叫广度优先遍历
 */
+ (void)levelTraverseTree:(BinaryTreeNode *)rootNode handle:(void(^)(BinaryTreeNode *treeNode))handle
{
    if (!rootNode) {
        return;
    }
    NSMutableArray *queueArray = [NSMutableArray array]; //数组当成队列
    [queueArray addObject:rootNode]; //压入根节点
    while (queueArray.count > 0) {
        BinaryTreeNode *node = [queueArray firstObject];
        
        if (handle) {
            handle(node);
        }
        [queueArray removeObjectAtIndex:0];
        if (node.leftNode) {
            [queueArray addObject:node.leftNode]; //压入左节点
        }
        if (node.rightNode) {
            [queueArray addObject:node.rightNode]; //压入右节点
        }
    }
}

/*
 二叉树的深度
 */
+ (NSInteger)depthOfTree:(BinaryTreeNode *)rootNode
{
    if (!rootNode) {
        return 0;
    }
    if (!rootNode.leftNode && !rootNode.rightNode) {
        return 1;
    }
    //左子树深度
    NSInteger leftDepth = [self depthOfTree:rootNode.leftNode];
    //右子树深度
    NSInteger rightDepth = [self depthOfTree:rootNode.rightNode];
    return MAX(leftDepth, rightDepth)+1;
}

+ (NSInteger)widthOfTree:(BinaryTreeNode *)rootNode
{
    if (!rootNode) {
        return 0;
    }
    NSMutableArray *queueArray = [NSMutableArray array];
    [queueArray addObject:rootNode];
    NSInteger maxWidth = 1;//最大的宽度，初始化为1（因为已经有根节点）
    NSInteger curWidth = 0;//当前层的宽度
    
    while (queueArray.count > 0) {
        curWidth = queueArray.count;
         //依次弹出当前层的节点
        for (int i=0; i<curWidth; i++) {
            BinaryTreeNode *node = [queueArray firstObject];
            [queueArray removeObjectAtIndex:0];//弹出最前面的节点，仿照队列先进先出原则
            if (node.leftNode) {
                [queueArray addObject:node.leftNode];
            }
            if (node.rightNode) {
                [queueArray addObject:node.rightNode];
            }
        }
        maxWidth = MAX(maxWidth, queueArray.count);
    }
    
    return maxWidth;
}

/**
 二叉树的所有节点数
 */
+ (NSInteger)numberOfNodesInTree:(BinaryTreeNode *)rootNode
{
    if (!rootNode) {
        return 0;
    }
    return [self numberOfNodesInTree:rootNode.leftNode] + [self numberOfNodesInTree:rootNode.rightNode] + 1;
}
/*
 二叉树某层中的节点数
 */
+ (NSInteger)numberOfNodesOnLevel:(NSInteger)level inTree:(BinaryTreeNode *)treeNode
{
    if (!treeNode || level < 1) {//根节点不存在或者level==0
        return 0;
    }
    if (level == 1) {//level=1，返回1（根节点）
        return 1;
    }
    return [self numberOfNodesOnLevel:level-1 inTree:treeNode.leftNode] + [self numberOfNodesOnLevel:level-1 inTree:treeNode.rightNode];
}

/**
二叉树叶子节点数
 */
+ (NSInteger)numberOfLeafsInTree:(BinaryTreeNode *)rootNode
{
    if (!rootNode) {
        return 0;
    }
    if (!rootNode.leftNode && !rootNode.rightNode) {
        return 1;
    }
    return [self numberOfLeafsInTree:rootNode.leftNode] + [self numberOfLeafsInTree:rootNode.rightNode];
    
}
/*
 翻转二叉树又叫二叉树的镜像
 */
+ (BinaryTreeNode *)invertBinaryTree:(BinaryTreeNode *)rootNode
{
    if (!rootNode) {
        return nil;
    }
    if (!rootNode.leftNode && !rootNode.rightNode) {
        return rootNode;
    }
    
    [self invertBinaryTree:rootNode.leftNode];
    [self invertBinaryTree:rootNode.rightNode];
    
    BinaryTreeNode *tempNode = rootNode.leftNode;
    rootNode.leftNode = rootNode.rightNode;
    rootNode.rightNode = tempNode;
    return rootNode;
}

/**
 二叉树中两个节点最近的公共父节点
 */
+ (BinaryTreeNode *)parentOfNode:(BinaryTreeNode *)nodeA andNode:(BinaryTreeNode *)nodeB inTree:(BinaryTreeNode *)rootNode
{
    if (!rootNode || !nodeA || !nodeB) {
        return nil;
    }
    if (nodeA == nodeB) {
        return nodeA;
    }
    //从根节点到节点A的路径
    NSArray *pathA = [self pathOfTreeNode:nodeA inTree:rootNode];
    //从根节点到节点B的路径
    NSArray *pathB = [self pathOfTreeNode:nodeB inTree:rootNode];
    if (pathA.count == 0 || pathB.count == 0) {
        return nil;
    }
    for (int i=0; i<pathA.count; i++) {
        for (int j=0; i<pathB.count; j++) {
            if ([pathA objectAtIndex:i] == [pathB objectAtIndex:j]) {
                return [pathA objectAtIndex:i];
            }
        }
    }
    return nil;
}

/**
二叉树中某个节点到根节点的路径
 */
+ (NSArray *)pathOfTreeNode:(BinaryTreeNode *)treeNode inTree:(BinaryTreeNode *)rootNode
{
    NSMutableArray *pathArray = [NSMutableArray array];
    [self isFoundTreeNode:treeNode inTree:rootNode routePath:pathArray];
    return pathArray;
}

/**
 查找某个节点是否在树中
 */
+ (BOOL)isFoundTreeNode:(BinaryTreeNode *)treeNode inTree:(BinaryTreeNode *)rootNode routePath:(NSMutableArray *)path
{
    if (!rootNode || !treeNode) {
        return NO;
    }
    
    if (rootNode == treeNode) {
        [path addObject:rootNode];
        return YES;
    }
    
    [path addObject:rootNode];
    BOOL find = [self isFoundTreeNode:treeNode inTree:rootNode.leftNode routePath:path];
    if (!find) {
        find = [self isFoundTreeNode:treeNode inTree:rootNode.rightNode routePath:path];
    }
    //如果2边都没查找到，则弹出此根节点
    if (!find) {
        [path removeLastObject];
    }
    return find;
}

@end
