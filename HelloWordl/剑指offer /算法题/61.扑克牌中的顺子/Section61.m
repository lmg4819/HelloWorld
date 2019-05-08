//
//  Section61.m
//  HelloWordl
//
//  Created by lmg on 2019/5/6.
//  Copyright © 2019 lmg. All rights reserved.
//

#import "Section61.h"

@implementation Section61

-(instancetype)init
{
    self = [super init];
    if (self) {
        BOOL isContains =  [self isContains:@[@2,@4,@5,@6,@0]];
    }
    return self;
}

- (BOOL)isContains:(NSArray *)numbers
{
    numbers = [numbers sortedArrayUsingSelector:@selector(compare:)];
    int sum = 0;
    for (int i=0; i<numbers.count-1; i++) {
        
        NSNumber *number = numbers[i];
        if ([number intValue] == 0) {
            
        }else{
            if ([numbers[i+1] intValue] == [numbers[i] intValue]) {
                return NO;
            }else
            {
                int temp = [numbers[i+1] intValue] - [numbers[i] intValue];
                sum += temp;
            }
        }
    }
    
    return sum <= 4;
}

@end
