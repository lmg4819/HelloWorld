//
//  BinaryTreeNode.h
//  HelloWordl
//
//  Created by lmg on 2019/5/6.
//  Copyright © 2019 lmg. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BinaryTreeNode : NSObject

@property (nonatomic,assign) NSInteger value;
@property (nonatomic,strong) BinaryTreeNode *leftNode;
@property (nonatomic,strong) BinaryTreeNode *rightNode;

@end

@interface BinaryTree : NSObject

+ (BinaryTreeNode *)createTreeWithValues:(NSArray *)values;
+ (BinaryTreeNode *)addTreeNode:(BinaryTreeNode *)treeNode value:(NSInteger)value;
+ (BinaryTreeNode *)treeNodeAtIndex:(int)index inTree:(BinaryTreeNode *)rootNode;

/**
前序遍历
 */
+ (void)preOrderTravreseTree:(BinaryTreeNode *)rootNode handle:(void(^)(BinaryTreeNode *treeNode))handle;
/**
 中序遍历
 */
+ (void)inOrderTraverseTree:(BinaryTreeNode *)rootNode handle:(void(^)(BinaryTreeNode *treeNode))handle;
/**
 后序遍历
 */
+ (void)postOrderTraverseTree:(BinaryTreeNode *)rootNode handle:(void(^)(BinaryTreeNode *treeNode))handle;
/**
 层序遍历
 */
+ (void)levelTraverseTree:(BinaryTreeNode *)rootNode handle:(void(^)(BinaryTreeNode *treeNode))handle;

/**
 二叉树的深度
 */
+ (NSInteger)depthOfTree:(BinaryTreeNode *)rootNode;

/**
 二叉树的宽度
 */
+ (NSInteger)widthOfTree:(BinaryTreeNode *)rootNode;

/**
 二叉树的所有节点数
 */
+ (NSInteger)numberOfNodesInTree:(BinaryTreeNode *)rootNode;


/**
 二叉树某层中的节点数
 */
+ (NSInteger)numberOfNodesOnLevel:(NSInteger)level inTree:(BinaryTreeNode *)treeNode;

/**
 二叉树叶子节点数
 */
+ (NSInteger)numberOfLeafsInTree:(BinaryTreeNode *)rootNode;

/**
 翻转二叉树
 */
+ (BinaryTreeNode *)invertBinaryTree:(BinaryTreeNode *)rootNode;


/**
二叉树中某个节点到根节点的路径
 */
+ (NSArray *)pathOfTreeNode:(BinaryTreeNode *)treeNode inTree:(BinaryTreeNode *)rootNode;

/**
 查找某个节点是否在树中
 */
+ (BOOL)isFoundTreeNode:(BinaryTreeNode *)treeNode inTree:(BinaryTreeNode *)rootNode routePath:(NSMutableArray *)path;

/**
 二叉树中两个节点最近的公共父节点
 */
+ (BinaryTreeNode *)parentOfNode:(BinaryTreeNode *)nodeA andNode:(BinaryTreeNode *)nodeB inTree:(BinaryTreeNode *)rootNode;

@end

NS_ASSUME_NONNULL_END
