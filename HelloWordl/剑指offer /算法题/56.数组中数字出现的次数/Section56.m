//
//  Section56.m
//  HelloWordl
//
//  Created by lmg on 2019/5/6.
//  Copyright © 2019 lmg. All rights reserved.
//

#import "Section56.h"

@implementation Section56

-(instancetype)init
{
    self = [super init];
    if (self) {
        NSMutableArray *tempArray = [NSMutableArray array];
        NSArray *array = @[@2,@3,@4,@6,@4,@3];
        for (NSNumber *number in array) {
            if (![tempArray containsObject:number]) {
                [tempArray addObject:number];
            }else{
                [tempArray removeObject:number];
            }
        }
        NSLog(@"-------%@-------",tempArray);
    }
    return self;
}



@end
