//
//  Section57.m
//  HelloWordl
//
//  Created by lmg on 2019/5/6.
//  Copyright © 2019 lmg. All rights reserved.
//

#import "Section57.h"

@implementation Section57

-(instancetype)init
{
    self = [super init];
    if (self) {
        NSArray *tempArray = @[@2,@3,@4,@5,@6,@7,@8];
        
        NSArray *result = [self FindNumbersWithSum:12 start:0 end:(int)tempArray.count - 1 array:tempArray];
        NSLog(@"----%@----",result);
    }
    return self;
}

- (NSArray *)FindNumbersWithSum:(int)target start:(int)start end:(int)end array:(NSArray *)array
{
    while (start < end) {
        int startValue = [array[start] intValue];
        int endValue = [array[end] intValue];
        
        if (startValue + endValue == 12) {
            return  @[@(startValue),@(endValue)];
        }else if (startValue + endValue < 12){
            start++;
        }else{
            end--;
        }
    }
    return nil;
}


@end
