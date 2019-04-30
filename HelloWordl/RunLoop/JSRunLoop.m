//
//  JSRunLoop.m
//  HelloWordl
//
//  Created by lmg on 2019/4/29.
//  Copyright © 2019 lmg. All rights reserved.
//

#import "JSRunLoop.h"
#import <UIKit/UIKit.h>


@interface JSRunLoop ()
@property (nonatomic,strong) UIImageView *imageView;
@end

@implementation JSRunLoop

-(instancetype)init
{
    self = [super init];
    if (self) {
        CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
            NSLog(@"监听到RunLoop发生改变---%zd",activity);
        });
        
        CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
        CFRelease(observer);
        
        
        //延迟加载图片
        [self.imageView performSelector:@selector(setImage:) withObject:[UIImage imageNamed:@"tupian"] afterDelay:2.0 inModes:@[NSDefaultRunLoopMode]];
        
        
        
    }
    return self;
}

@end
