//
//  AspectProxy.h
//  Objective
//
//  Created by lmg on 2019/4/4.
//  Copyright © 2019 we. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Invoker.h"

NS_ASSUME_NONNULL_BEGIN

@interface AspectProxy : NSProxy<Invoker>

@property (strong) id proxyTarget;
@property (strong) id<Invoker> invoker;
@property (readonly) NSMutableArray *selectors;

- (id)initWithObject:(id)object andInvoker:(id<Invoker>)invoker;
- (id)initWithObject:(id)object selectors:(NSArray *)selectors andInvoker:(id<Invoker>)invoker;
- (void)registerSelector:(SEL)selector;


@end

NS_ASSUME_NONNULL_END
