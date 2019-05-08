

//
//  Section63.m
//  HelloWordl
//
//  Created by lmg on 2019/5/7.
//  Copyright © 2019 lmg. All rights reserved.
//

#import "Section63.h"

@implementation Section63
/*
 {9,11,8,5,7,12,16,14}
 
 */
-(instancetype)init
{
    self = [super init];
    if (self) {
        NSArray *array = @[@9,@11,@8,@5,@7,@12,@16,@14];
        int min = [array[0] intValue];
        int maxDiff = [array[1] intValue] - min;
        
        for (int i=2; i<array.count; i++) {
            if ([array[i-1] intValue] < min) {
                min = [array[i-1] intValue];
            }
            int currentDiff = [array[i] intValue] - min;
            if (currentDiff > maxDiff) {
                maxDiff = currentDiff;
            }
        }
        NSLog(@"---%d---",maxDiff);
    }
    return self;
}

@end
