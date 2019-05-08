//
//  Section50.m
//  HelloWordl
//
//  Created by lmg on 2019/5/5.
//  Copyright © 2019 lmg. All rights reserved.
//

#import "Section50.h"

@implementation Section50
-(instancetype)init
{
    self = [super init];
    if (self) {
        [self charIndexWithString:@"abaccdeff"];
    }
    return self;
}

- (NSString *)charIndexWithString:(NSString *)string
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    for (int i=0; i<string.length; i++) {
        NSString *str = [string substringWithRange:NSMakeRange(i, 1)];
        if (![dict.allKeys containsObject:str]) {
            dict[str] = @(1);
        }else{
            NSInteger count = [dict[str] integerValue];
            dict[str] = @(count+1);
        }
    }
    
    for (int i=0; i<string.length; i++) {
        NSString *str = [string substringWithRange:NSMakeRange(i, 1)];
        NSInteger count = [dict[str] integerValue];
        if (count == 1) {
            return str;
        }
    }
    return @"";
}
@end
