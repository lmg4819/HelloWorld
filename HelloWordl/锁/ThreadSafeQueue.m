//
//  ThreadSafeQueue.m
//  HelloWordl
//
//  Created by lmg on 2019/5/27.
//  Copyright © 2019 lmg. All rights reserved.
//

#import "ThreadSafeQueue.h"



@implementation ThreadSafeQueue
{
    NSMutableArray *_elements;
    NSLock *_lock;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _elements = [NSMutableArray array];
        _lock = [[NSLock alloc]init];
    }
    return self;
}

- (void)push:(id)element
{
    [_lock lock];
    [_elements addObject:element];
    [_lock unlock];
}

@end
