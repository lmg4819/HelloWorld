//
//  JSTextContext.m
//  HelloWordl
//
//  Created by lmg on 2019/4/30.
//  Copyright © 2019 lmg. All rights reserved.
//

#import "JSTextContext.h"

@implementation JSTextContext

-(instancetype)init
{
    self = [super init];
    if (self) {
        [self findRepeatElementFromArray:@[@2,@3,@1,@0,@2,@5,@3]];
    }
    return self;
}


/*
 1.找出数组中重复的元素
 在一个长度为n的数组里的元素都在0---n-1的范围内。数组中某些数字是重复的，但不知道有几个数字重复了，也不知道哪个数字重复了几次。请找出数组中任意一个重复的数字。例如，如果输入长度为7的数组
 {2,3,1,0,2,5,3},那么对应的输出是重复的数字是2或者3
 
 2.不修改数组找出重复的数字
 在一个长度为n+1的数组里的所有数字都在1~n的范围内，所以数组中至少有一个数字是重复的。
 请找出数组中任意一个重复的数字，但不能修改输入的数组
 */
- (int)findRepeatElementFromArray:(NSArray *)array
{
    NSMutableArray *result = [NSMutableArray array];
    for (NSNumber *number in array) {
        if ([result containsObject:number]) {
            return number.intValue;
        }else{
            [result addObject:number];
        }
    }
    return -1;
}
/*
3.二维数组中的查找
 在一个二维数组中，每一行都按照从左到右递增的顺序排序，每一列都按照从上到下递增的顺序排序。
 请完成这样一个函数，输入这样的一个二维数组和一个整数，判断数组中是否还有该函数。
 */


/*
 4.替换空格
 请实现一个函数，把字符串中的每个空格换成“%20”。例如，输入‘we are happy’，则输出“we%20are%20happy”
 
 */

/*
 5.
 */


@end
