//
//  Invoker.h
//  Objective
//
//  Created by lmg on 2019/4/4.
//  Copyright © 2019 we. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol Invoker <NSObject>
@required
- (void)preInvoke:(NSInvocation *)inv withTarget:(id)target;

@optional
- (void)postInvoek:(NSInvocation *)inv withTarget:(id)target;


@end

NS_ASSUME_NONNULL_END
