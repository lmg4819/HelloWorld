//
//  SectionFive.m
//  PushProject
//
//  Created by lmg on 2019/5/22.
//  Copyright © 2019 lmg. All rights reserved.
//

#import "SectionFive.h"

@implementation SectionFive

- (instancetype)init
{
    self = [super init];
    if (self) {
//        int result = [self questionOneWithNumber:10];
//        int value = [self questionTwoWithNumber:10];
        [self questionThree];
        [self questionFour];
        NSArray *array = @[
                           @[@"a",@"b",@"t",@"g"],
                           @[@"c",@"f",@"c",@"s"],
                           @[@"j",@"d",@"e",@"h"],
                           ];
        NSArray *targetArray = @[@"b",@"f",@"c",@"e"];
        [self questionFiveWithArray:array withTargetArray:targetArray];
        NSLog(@"");
    }
    return self;
}

- (int)questionOneWithNumber:(int)value
{
    
    //递归
    if (value > 0) {
       return [self questionOneWithNumber:value-1]+value;
    }
    return 0;
    
    //循环1
//    int temp = value;
//    int result = 0;
//    while (temp > 0) {
//        result += temp;
//        temp--;
//    }
//    return result;
    
//    //循环2
//    int result = 0;
//    for (int i=1; i<=value; i++) {
//        result += i;
//    }
//    return result;
    
}
/*
 求斐波那契数列的第n项
 0 1 1 2 3 5 8 13 21 34 55
 
 
 解法分析：
 1.递归，但是时间效率极差
 2.循环，去除了重复计算的问题
 */
- (int)questionTwoWithNumber:(int)n
{
    NSMutableArray *array = @[@0,@1].mutableCopy;
    if (n <= 1) {
        return [array[n] intValue];
    }
    int value = 0;
    for (int i=2; i<=n; i++) {
        value = [array[i-1] intValue] + [array[i-2] intValue];
        [array addObject:@(value)];
    }
    return [[array lastObject] intValue];
    
//    if (n == 0) {
//        return 0;
//    }
//    if (n == 1) {
//        return 1;
//    }
//    return [self questionTwoWithNumber:n-1] + [self questionTwoWithNumber:n-2];
}

/*
 一只青蛙一次可以跳上一个台阶，也可以跳上两个台阶，求该青蛙跳上一个n级的台阶一共有多少种方法
 0   0
 1   1
 2   1，1  2
 3   1，1，1  1，2 2，1 3
 4
 
 
 */
- (void)questionThree
{
    NSMutableArray *array = @[@0,@1,@2].mutableCopy;
    int value = 0;
    for (int i=3; i<=10; i++) {
        value = [array[i-1] intValue] + [array[i-2] intValue];
        [array addObject:@(value)];
    }
    NSLog(@"---%@---",array);
}
/*
 排序数组中查找一个数字，或者统计某个数字出现的次数，我们都可以尝试使用二分查找算法

 
 把一个数组最开始的若干个元素搬到数组的末尾，我们称之为数组的旋转。输入一个递增排序的数组的一个旋转，输出旋转数组的最小元素，例如，数组{3,4,5,1,2}为{1,2,3,4,5}的一个旋转，该数组的最小值为1
 
 二分查找法来解决
 */
- (void)questionFour
{
    
}

/*
 请设计一个函数，用来判断在一个矩阵中是否存在一条包含某字符串所有字符的路径。路径可以从矩阵的
 任意一格开始，每一步可以在矩阵中向上下左右移动一格，如果一条路径经过了矩阵的某一个，那么该路径就不能再次进入该格子。例如，在下面的3*4的矩阵中包含一条字符串bfce的路径，但矩阵中不包含abfb的路径，因为字符串的第一个字符b占据了矩阵中的第一行第二个格子以后，路径不能再次进入这个格子
 */
- (BOOL)questionFiveWithArray:(NSArray *)array withTargetArray:(NSArray *)targetArray
{
    int row = (int)array.count;
    int column = (int)[array[0] count];
    
    NSMutableArray *visited = [NSMutableArray array];
    for (int i=0; i<row; i++) {
        NSMutableArray *columnArray = [NSMutableArray array];
        for (int j=0; j<column; j++) {
            [columnArray addObject:@(NO)];
        }
        [visited addObject:columnArray];
    }
    
    int pathLength = 0;
    for (int i=0; i<row; i++) {
        for (int j=0; i<column; j++) {
            if ([self hasPathCoreWithArray:array targetArray:targetArray visitedArray:visited i:i j:j pathLength:pathLength]) {
                return true;
            }
        }
    }
    return false;
}

- (BOOL)hasPathCoreWithArray:(NSArray *)array targetArray:(NSArray *)targetArray visitedArray:(NSMutableArray *)visitedArray i:(int)i j:(int)j pathLength:(int)pathLength
{
    int row = (int)array.count;
    int column = (int)[array[0] count];
    

    if (pathLength == targetArray.count) {
        return true;
    }
    
    return false;
}


@end
