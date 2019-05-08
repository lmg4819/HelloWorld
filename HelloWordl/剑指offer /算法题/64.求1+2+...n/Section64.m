//
//  Section64.m
//  HelloWordl
//
//  Created by lmg on 2019/5/7.
//  Copyright © 2019 lmg. All rights reserved.
//

#import "Section64.h"

@implementation Section64

-(instancetype)init
{
    self = [super init];
    if (self) {
        int value = [self sum_solution:100];
        NSLog(@"------%d------",value);
    }
    return self;
}

- (int)sum_solution:(int)number
{
    int result = number;
    number&&(result += [self sum_solution:number-1]);
    return result;
}


@end
