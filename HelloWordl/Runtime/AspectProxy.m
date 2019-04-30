//
//  AspectProxy.m
//  Objective
//
//  Created by lmg on 2019/4/4.
//  Copyright © 2019 we. All rights reserved.
//

#import "AspectProxy.h"

@implementation AspectProxy

-(id)initWithObject:(id)object andInvoker:(id<Invoker>)invoker
{
    return [self initWithObject:object selectors:nil andInvoker:invoker];
}

-(id)initWithObject:(id)object selectors:(NSArray *)selectors andInvoker:(id<Invoker>)invoker
{
    _proxyTarget = object;
    _invoker = invoker;
    _selectors = selectors.mutableCopy;
    return self;
}

-(void)registerSelector:(SEL)selector
{
    NSValue *setValue = [NSValue valueWithPointer:selector];
    [self.selectors addObject:setValue];
}

-(NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    return [self.proxyTarget methodSignatureForSelector:sel];
}

-(void)forwardInvocation:(NSInvocation *)invocation
{
    //在调用目标方法前执行横切方法
    if ([self.invoker respondsToSelector:@selector(preInvoke:withTarget:)]) {
        if (self.selectors != nil) {
            SEL methodSel = [invocation selector];
            for (NSValue *selValue in self.selectors) {
                if (methodSel == [selValue pointerValue]) {
                    [[self invoker] preInvoke:invocation withTarget:self.proxyTarget];
                    break;
                }
            }
        }else{
            [[self invoker] preInvoke:invocation withTarget:self.proxyTarget];
        }
    }
    //调用目标方法
    [invocation invokeWithTarget:self.proxyTarget];
    //在调用目标方法后执行目标方法
    if ([self.invoker respondsToSelector:@selector(postInvoek:withTarget:)]) {
        if (self.selectors != nil) {
            SEL methodSel = [invocation selector];
            for (NSValue *selValue in self.selectors) {
                if (methodSel == [selValue pointerValue]) {
                    [[self invoker] postInvoek:invocation withTarget:self.proxyTarget];
                }
            }
        }else{
            [[self invoker] postInvoek:invocation withTarget:self.proxyTarget];
        }
    }
}

@end
