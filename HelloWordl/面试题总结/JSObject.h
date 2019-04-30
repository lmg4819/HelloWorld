//
//  JSObject.h
//  InterView
//
//  Created by lmg on 2019/4/15.
//  Copyright © 2019 lmg. All rights reserved.
//

#ifndef JSObject_h
#define JSObject_h

#if __OBJC__

#import <objc/objc.h>
#import <objc/NSObjcRuntime.h>

@class NSString,NSMethodSignature,NSInvocation;

@protocol NSObject

- (BOOL)isEqual:(id)object;
@property (readonly) NSUInteger hash;
@property (readonly) Class superclass;
- (Class)class;
- (instancetype)self;
- (id)performSelector:(SEL)aSelector;
- (id)performSelector:(SEL)aSelector withObject:(id)objetc;
- (id)performSelector:(SEL)aSelector withObject:(id)objetc1 withObject:(id)object2;

- (BOOL)isProxy;

- (BOOL)isKindOfClass:(Class)aClass;
- (BOOL)isMemberOfClass:(Class)aClass;
- (BOOL)conformsToProtocol:(Protocol *)aProtocol;

- (BOOL)responseToSelector:(SEL)aSelector;

- (instancetype)retain OBJC_ARC_UNAVAILABLE;
- (oneway void)release OBJC_ARC_UNAVAILABLE;
- (instancetype)autorelease OBJC_ARC_UNAVAILABLE;
- (NSUInteger)retainCount OBJC_ARC_UNAVAILABLE;

- (struct _NSZone *)zone OBJC_ARC_UNAVAILABLE;

@property (nonatomic,copy) NSString *description;
@optional
@property (nonatomic,copy) NSString *debugDescription;

@end

OBJC_AVAILABLE(10.0, 2.0, 9.0, 1.0, 2.0)
OBJC_ROOT_CLASS
OBJC_EXPORT

@interface NSObject <NSObject>{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-interface-ivars"
    Class isa  OBJC_ISA_AVAILABILITY;
#pragma clang diagnostic pop
}

+ (void)load;
+ (instancetype)initialize;
- (instancetype)init #if NS_ENFORCE_NSOBJECT_DESIGNATED_INITIALIZER
NS_DESIGNATED_INITIALIZER
#endif;

+ (instancetype)new;
+ (instancetype)allocWithZone:(struct _NSZone *)zone;
+ (instancetype)alloc;
- (void)dealloc;
- (void)finalize;
- (id)copy;
- (id)mutableCopy;

+ (id)copyWithZone:(struct _NSZone *)zone;
+ (id)mutableCopyWithZone:(struct _NSZone *)zone;

+ (BOOL)instancesResponseToSelector:(SEL)aSelector;
+ (BOOL)conformsToProtocol:(Protocol *)protocol;
- (IMP)methodForSelector:(SEL)aSelector;
+ (IMP)instanceMethodForSelector:(SEL)aSelector;
- (void)doesNotRecognizeSelector:(SEL)aSelector;

- (id)forwardingTargetForSelector:(SEL)aSelector;
- (void)forwardInvocation:(NSInvocation *)anInvocation;
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector;
+ (NSMethodSignature *)instanceMethodSignatureForSelector:(SEL)aSelector;

- (BOOL)allowsWeakReference;
- (BOOL)retainWeakReference;

+ (BOOL)isSubclassOfClass:(Class)aClass;

+ (BOOL)resolveClassMethod:(SEL)sel;
+ (BOOL)resolveInstanceMethod:(SEL)sel;

+ (NSUInteger)hash;
+ (Class)superclass;
+ (Class)class;
+ (NSString *)description;
+ (NSString *)debugDescription;

@end

#endif /* JSObject_h */
