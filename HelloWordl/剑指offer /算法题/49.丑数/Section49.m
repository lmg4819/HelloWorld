//
//  Section49.m
//  HelloWordl
//
//  Created by lmg on 2019/5/5.
//  Copyright © 2019 lmg. All rights reserved.
//

#import "Section49.h"

@implementation Section49

-(instancetype)init
{
    self = [super init];
    if (self) {
        [self GetUglyNumber:1500];
    }
    return self;
}

- (int)GetUglyNumber:(int)index
{
    if (index <= 0) {
        return 0;
    }
    NSMutableArray *uglyNumbers = [NSMutableArray array];
    [uglyNumbers addObject:@1];
    int nextUglyIndex = 1;
    int multiply2 = 0;
    int multiply3 = 0;
    int multiply5 = 0;
    int min = 0;
    while (nextUglyIndex < index) {
        int multiply2Res = [uglyNumbers[multiply2] intValue] * 2;
        int multiply3Res = [uglyNumbers[multiply3] intValue] * 3;
        int multiply5Res = [uglyNumbers[multiply5] intValue] * 5;
        int temp = MIN(multiply2Res, multiply3Res);
        min = MIN(temp, multiply5Res);
        uglyNumbers[nextUglyIndex] = @(min);
        
        while ([uglyNumbers[multiply2] intValue] * 2 <= min) {
            multiply2++;
        }
        while ([uglyNumbers[multiply3] intValue] * 3 <= min) {
            multiply3++;
        }
        while ([uglyNumbers[multiply5] intValue] * 5 <= min) {
            multiply5++;
        }
        
        nextUglyIndex++;
    }
    return [[uglyNumbers lastObject] intValue];
}

@end
