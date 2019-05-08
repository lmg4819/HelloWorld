//
//  Section65.m
//  HelloWordl
//
//  Created by lmg on 2019/5/7.
//  Copyright © 2019 lmg. All rights reserved.
//

#import "Section65.h"

@implementation Section65
/*
 对数字做运算，除了四则运算之外，就只有位运算了
 
 5
 
   101
 10001
 
 10110
 
 
 
 */
-(instancetype)init
{
    self = [super init];
    if (self) {
        int num1 = 5,num2 = 17;
        int sum,carry;
        do {
            sum = num1 ^ num2;
            carry = (num1 & num2)<<1;
            num1 = sum;
            num2 = carry;
        } while (num2 != 0);
        NSLog(@"---%d---",num1);
        
    }
    return self;
}

@end
