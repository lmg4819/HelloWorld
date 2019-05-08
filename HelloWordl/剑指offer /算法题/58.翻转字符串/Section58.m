//
//  Section58.m
//  HelloWordl
//
//  Created by lmg on 2019/5/6.
//  Copyright © 2019 lmg. All rights reserved.
//

#import "Section58.h"

@implementation Section58

-(instancetype)init
{
    self = [super init];
    if (self) {
        NSString *string = @"I am a studnet.";
        NSArray *tempArray = [string componentsSeparatedByString:@" "];
        NSMutableArray *resultArray = [NSMutableArray array];
        
        for (NSString *temp in tempArray.reverseObjectEnumerator) {
            [resultArray addObject:temp];
        }
        NSString *resultString = [resultArray componentsJoinedByString:@" "];
        NSLog(@"----%@-----",resultString);
    }
    return self;
}

@end
