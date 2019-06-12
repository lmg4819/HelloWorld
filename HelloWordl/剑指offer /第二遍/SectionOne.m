//
//  SectionOne.m
//  PushProject
//
//  Created by lmg on 2019/5/18.
//  Copyright © 2019 lmg. All rights reserved.
//

#import "SectionOne.h"

@implementation SectionOne
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self questionOne];
        [self questionTwo];
        [self questionThree];
    }
    return self;
}
/*
 在一个长度为n的数组里的所有数字都在0~n-1之间，数组中某些数字是重复的，但不知道有几个数字重复了，也不知道每个数字重复了几次。请找出数组中任意一个重复的数字。例如，如果输入长度为7的数字{
 2,3,1,0,2,5,3},那么对应的输出是重复的数字2或者3
 
 解决方案
 1.排序   时间复杂度0(nlogn)
 2.哈希表   时间复杂度0(n)以一个大小为0(n)的哈希表为代价的
 3.重排    时间复杂度0(n)空间复杂度0(1)
 */
/*
 2,3,1,0,2,5,3
 1,3,2,0,2,5,3
 3,1,2,0,2,5,3
 0,1,2,3,2,5,3
 
 
 
 */
- (void)questionOne{
    //2.哈希表
//    NSArray *array = @[@2,@3,@1,@0,@2,@5,@3];
//    NSMutableArray *result = [NSMutableArray array];
//    for (NSNumber *number in array) {
//        if ([result containsObject:number]) {
//            NSLog(@"-----%@",number);
//            return;
//        }else{
//            [result addObject:number];
//        }
//    }
//    NSLog(@"-1");
    //3.重排
    NSMutableArray *array = @[@2,@3,@1,@0,@2,@5,@3].mutableCopy;
    for (int i=0; i<array.count; i++) {
        while ([array[i] intValue] != i) {
            if ([array[i] intValue] == [array[([array[i] intValue])] intValue]) {
                NSLog(@"----%@-----",array[i]);
                return;
            }else{
                [array exchangeObjectAtIndex:i withObjectAtIndex:[array[i] intValue]];
            }
        }
    }
    NSLog(@"-1");
}
/*
 在一个长度为n+1的数组里所有的数字都在1~n的范围内，所以数组中至少有一个数字是重复的。请找出数组中任意一个重复的数字，但不能修改输入的数组。例如，如果输入长度为8的数组{2,3,5,4,3,2,6,7},那么对应的输入的数字应该是2或者3
 
 解决方案
 1.哈希表   时间复杂度0(n)以一个大小为0(n)的哈希表为代价的
 2.二分法   时间复杂度0（nlogn）,空间复杂度0(1)
 */
- (void)questionTwo
{
//        NSArray *array = @[@2,@3,@5,@4,@3,@2,@6,@7];
//        NSMutableArray *result = [NSMutableArray array];
//        for (NSNumber *number in array) {
//            if ([result containsObject:number]) {
//                NSLog(@"-----%@",number);
//                return;
//            }else{
//                [result addObject:number];
//            }
//        }
//        NSLog(@"-1");
    NSArray *array = @[@2,@3,@5,@4,@3,@2,@6,@7];
    int start = 1;
    int end = (int)array.count - 1;
    while (start <= end) {
        int middle = (start + end)/2;
        int count = [self countRangeWithArray:array length:(int)array.count start:start end:middle];
        if (end == start) {
            if (count > 1) {
                NSLog(@"--------%d",start);
                return;
            }else{
                break;
            }
        }
        
        if (count > (middle - start + 1)) {
            end = middle;
        }else{
            start = middle + 1;
        }
    }
    NSLog(@"-1");
    
}

- (int)countRangeWithArray:(NSArray *)array length:(int)length start:(int)start end:(int)end
{
    if (!array) {
        return 0;
    }
    int count = 0;
    for (int i=0; i<length; i++) {
        if ([array[i] intValue] >= start && [array[i] intValue] <= end) {
            count++;
        }
    }
    return count;
}

/*
 在一个二维数组中，每一行都按照从左到右递增的顺序排序，每一列都按照从上到下的递增的顺序排序。请完成一个函数，实现输入这样的一个二维数组和一个参数，判断数组中是否含有该参数
 
 解题思路：
 i=0，j=column-1  while i<row && j >= 0
 array[i][j]从右上角元素开始，如果所在位置元素大于target,j--;
 如果所在位置小于target，i++;如果相等的话，那么就返回YES，否则最后返回NO
 */
- (void)questionThree
{
    NSArray *array = @[@[@1,@2,@8,@9],@[@2,@4,@9,@12],@[@4,@7,@10,@13],@[@6,@8,@11,@15]];
    int target = 13;
    int i = 0;
    int j = (int)array.count-1;
    while (j>=0 && i<[array[0] count]) {
        if ([array[i][j] intValue] > target) {
            j--;
        }else if ([array[i][j] intValue] < target){
            i++;
        }else{
            NSLog(@"%d-----%d",i,j);
            return ;
        }
    }
    NSLog(@"-1");
}



@end
