//
//  Section60.m
//  HelloWordl
//
//  Created by lmg on 2019/5/6.
//  Copyright © 2019 lmg. All rights reserved.
//

#import "Section60.h"

@implementation Section60

-(instancetype)init
{
    self = [super init];
    if (self) {
        for (int i=3; i<=18; i++) {
            int count = [self getSumCount:3 sum:i];
            NSLog(@"-----%d-----",count);
        }
    }
    return self;
}

- (int)getSumCount:(int)n sum:(int)sum
{
    if (n<1 || sum < n || sum > 6*n) {
        return 0;
    }
    if (n == 1) {
        return 1;
    }
    int resCount = 0;
    resCount = [self getSumCount:n-1 sum:sum-1] + [self getSumCount:n-1 sum:sum-2] +
    [self getSumCount:n-1 sum:sum-3] + [self getSumCount:n-1 sum:sum-4] + [self getSumCount:n-1 sum:sum-5] + [self getSumCount:n-1 sum:sum-6];
    return resCount;
}


@end
