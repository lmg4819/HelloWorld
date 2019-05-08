//
//  Section53.m
//  HelloWordl
//
//  Created by lmg on 2019/5/6.
//  Copyright © 2019 lmg. All rights reserved.
//

#import "Section53.h"

@implementation Section53
/*
 {1,2,3,3,3,3,4,5}
 
 */
-(instancetype)init
{
    self = [super init];
    if (self) {
        NSArray *tempArray = @[@1,@2,@3,@3,@3,@3,@4,@5];
        int firstInd = [self getFirstIndex:tempArray target:3 start:0 end:(int)tempArray.count-1];
        int lastInd = [self getLastIndex:tempArray target:3 start:0 end:(int)tempArray.count-1];
        if (firstInd > -1 && lastInd > -1) {
            int count = lastInd - firstInd + 1;
            NSLog(@"----%d---",count);
        }
    }
    return self;
}

- (int)getFirstIndex:(NSArray *)array target:(int)target start:(int)start end:(int)end
{
    if (start > end) {
        return -1;
    }
    int middleIndex = (start + end)/2;
    int mid_data = [array[middleIndex] intValue];
    if (mid_data == target) {
        if ((mid_data != [array[middleIndex-1] intValue] && middleIndex > 0)|| middleIndex == 0 ) {
            return middleIndex;
        }else
        {
            end = middleIndex - 1;
        }
    }else if (mid_data > target){
        end = middleIndex - 1;
    }else{
        start = middleIndex + 1;
    }
    return [self getFirstIndex:array target:target start:start end:end];
}

- (int)getLastIndex:(NSArray *)array target:(int)target start:(int)start end:(int)end
{
    if (start > end) {
        return -1;
    }
    int middleIndex = (start + end)/2;
    int mid_data = [array[middleIndex] intValue];
    if (mid_data == target) {
        if ((mid_data != [array[middleIndex+1] intValue] && middleIndex < end-1)|| middleIndex == end) {
            return middleIndex;
        }else{
            start = middleIndex + 1;
        }
    }else if (mid_data > target){
        end = middleIndex - 1;
    }else{
        start = middleIndex + 1;
    }
    return [self getLastIndex:array target:target start:start end:end];
}

@end
