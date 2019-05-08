//
//  Section66.m
//  HelloWordl
//
//  Created by lmg on 2019/5/7.
//  Copyright © 2019 lmg. All rights reserved.
//

#import "Section66.h"

@implementation Section66
-(instancetype)init
{
    self = [super init];
    if (self) {
        /*
         1 3 4 5 6 7
         2 1 4 5 6 7
         2 3 1 5 6 7
         2 3 4 1 6 7
         2 3 4 5 1 7
         2 3 4 5 6 1
         */
        NSArray *array = @[@2,@3,@4,@5,@6,@7];
        NSMutableArray *arrayB = [NSMutableArray array];
        [arrayB addObject:@1];
        for (int i=1; i<array.count; i++) {
            int value = [arrayB[i-1] intValue] * [array[i-1] intValue];
            arrayB[i] = @(value);
        }
        int temp = 1;
        for (int j = (int)array.count-2; j>=0; j--) {
            temp *= [array[j+1] intValue];
            int value = [arrayB[j] intValue] * temp;
            arrayB[j] = @(value);
        }
        NSLog(@"-------------");
    }
    return self;
}
@end
