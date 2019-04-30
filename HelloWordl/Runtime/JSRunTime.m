//
//  JSRunTime.m
//  HelloWordl
//
//  Created by lmg on 2019/4/29.
//  Copyright © 2019 lmg. All rights reserved.
//

#import "JSRunTime.h"
#import <objc/message.h>
#import <objc/runtime.h>
#import <UIKit/UIKit.h>

@implementation JSRunTime
/*
 alloc方法：系统会为该对象分配内存，并且它的实例变量也会被设置为默认值0.
 init：自定义初始化方法
 
 重构是指在不改变外部行为的情况下重新构建现有代码。旨在为软件提高性能，新增特性等。
 
 OC还支持多态性即不同的接收器可以拥有同一方法的不同实现代码，接收器的类型会在运行时确定。
 
 点语法只是一种替代语法，而不是直接访问支持属性的实例变量的机制。编译器会将点表达式转换为响应的属性访问器方法。
 
 在运行时，OC语言会执行其他语言在程序编译时或链接时执行的许多常规操作，如确定类型和方法解析。
 
 对象消息传递是以动态方式实现的特性，接收器的类型和相应的调用方法是在运行时决定的。
 
 
 选择器：文本字符串
 SEL：选择器类型，SEL是一种特殊的OC数据类型，是用于编译源代码时替换选择器值的唯一标识符。
 方法签名：定义了方法输入参数的数据类型和方法的返回值类型。
 
 静态类型：NSString等OC对象类型，编译时确定的类型
 动态类型：id类型，在运行时确定的类型
 
 动态绑定：是指在运行程序时（而不是编译时）将消息和方法对应起来的过程。动态绑定实现了OOP的多态性。动态绑定应用于使用了动态类型的情况。
 */
/*
 
 
 运行时系统是OC平台的关键因素，OC语言的动态特性和面向对象功能就是由它实现的。
 OC的运行时系统由两个关键部分组成：编译器和运行时系统库。
 编译器的作用是接收输入的源代码，生成使用了运行时系统库的代码，从而得到合法的，可执行的OC程序。
 运行时系统由下列部分组成：
 1.类元素（接口，实现代码，分类，协议，方法，属性，实例变量）
 2.类实例（对象）
 3.对象消息传递（包括动态类型和动态绑定）
 4.动态方法决议
 5.动态加载
 6.对象内省
 
 
 
 
 编译器如何实现对象消息：
 1.生成对象消息传递代码。
 2.生成类和对象的代码。
 3.查看运行时系统的数据结构
 
 实现运行时系统的对象消息传递：
 1.对象的类定义（objc_getClass）
 2.类的父类（objc_getSuperclass）
 3.对象的元类定义（objc_getMetaClass）
 4.类的名称（class_getName）
 5.类的版本信息（class_getVersion）
 6.以字节为单位的类尺寸（class_getInstanceSize）
 7.类的实例变量列表（class_copyIvarList）
 8.类的方法列表（class_copyMethodLsit）
 9.类的协议列表（class_copyProtocolList）
 10.类的属性列表（class_copyPropertyList）
 
 isa指针     isa指针       isa指针
 对象实例变量--------》类---------》元类--------》NSObject的元类（isa指向自身）
 （实例方法的虚函数表）  （类方法的虚函数表）
 
 super指针
 ---------》NSObjecth根类
 
 super指针     super指针        super指针             super指针
 对象实例变量-------》类----------------》父类-------》NSObject根类---------》nil
 struct objc_object
 {
 Class isa;
 /*
 ...含有实例变量值的长度可变数据...
 */
/*
typedof struct objc_object
{
    Class isa;
} *id;


struct objc_method{
    SEL method_name;方法的名字
    char *method_types;方法参数的数据类型
    IMP method_imp;方法的地址
}

typedef objc_method Method;
虚函数表是一个用于存储IMP类型数据的数组，每个运行时系统类实例都有一个指向虚函数表的指针。

元类是一种特殊的类对象，运行时系统

OC与运行时系统交互：
1.OC源代码
2.Foundation框架中的NSObject类的方法
3.运行时系统API

Foundation框架中的NSObject提供了：
1.对象内省
2.动态方法决议
3.动态加载
4.消息转发操作

OC运行时系统由两个主要部分组成：编译器和运行时系统。编译器会接收OC源代码并生成由运行时系统库执行的代码。运行时系统库会与所有OC程序链接（在链接阶段）。这两个关键组成部分一起实现了OC语言的面向对象特性和动态功能。

运行时系统库实现了各种特性和机制，使用它们可以增强应用程序的性能和可扩展性。典型的特性和机制包括方法缓存，虚方法表和dyld共享缓存。

AOP是一种编程范式，其目的是通过横切将（依赖或影响其他部分的）功能与程序中的其他部分分隔开，提高程序的模块化程度。

 */
-(instancetype)init
{
    self = [super init];
    if (self) {
        ((void(*)(id,SEL))objc_msgSend)(self,@selector(hello));
    }
    return self;
}

- (void)hello
{
    NSLog(@"------Hello-----");
}

+(BOOL)resolveClassMethod:(SEL)sel
{
    return YES;
}
+(BOOL)resolveInstanceMethod:(SEL)sel
{
    NSString *method = NSStringFromSelector(sel);
    if ([method hasPrefix:@"absoluteValue"]) {
        class_addMethod([self class], sel, (IMP)absoulteValue, "@@:@");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}

id absoulteValue(id self,SEL sel,id value){
    NSInteger intVal = [value integerValue];
    if (intVal < 0) {
        return [NSNumber numberWithInteger:(intVal * -1)];
    }
    return value;
}

-(NSNumber *)sumAddend1:(NSNumber *)adder1 :(NSNumber *)adder2
{
    NSLog(@"Invoking method on %@ object with selector %@",NSStringFromClass([self class]),NSStringFromSelector(_cmd));
    return [NSNumber numberWithInteger:([adder1 integerValue] + [adder2 integerValue])];
}

-(NSNumber *)sumAddend1:(NSNumber *)adder1 addend2:(NSNumber *)adder2
{
    NSLog(@"Invoking method on %@ object with selector %@",NSStringFromClass([self class]),NSStringFromSelector(_cmd));
    return [NSNumber numberWithInteger:([adder1 integerValue] + [adder2 integerValue])];
}

#pragma mark -Working with Classes

- (void)test{
    //
    //    NSLog(@"UIView's Framework: %s", class_getImageName(NSClassFromString(@"UIView")));
    //    unsigned int imageCount = 0;
    ////    const char **imageNames = objc_copyImageNames(&imageCount);
    //    const char **imageNames = objc_copyClassNamesForImage(class_getImageName(NSClassFromString(@"UIView")), &imageCount);
    //    for (int i=0; i<imageCount; i++) {
    //        const char *imageName = imageNames[i];
    //        NSString *name = [NSString stringWithUTF8String:imageName];
    //        NSLog(@"-------%@-------",name);
    //    }
    
    //    Protocol *protocol = objc_getProtocol("UITableViewDataSource");
    //    unsigned int proCount;
    //    struct objc_method_description *structDescs =  protocol_copyMethodDescriptionList(protocol, YES, YES, &proCount);
    //    for (int i=0; i<proCount; i++) {
    //        struct objc_method_description structDesc = structDescs[i];
    //        NSString *className = NSStringFromSelector(structDesc.name);
    //        NSLog(@"=====%@=====",className);
    //    }
    
    
    //    JSPerson *person = [JSPerson new];
    //    person.js_userId(@"111").js_userName(@"aaa");
    //    NSLog(@"-----%@-----%@",person.userName,person.userId);
    
    //    [self js_classGetName];
    //    [self js_classGetSuperClass];
    //    [self js_classIsMetaClass];
    //    [self js_classGetInstanceSize];
    //    [self js_classGetInstanceVariable];
    //    [self js_classGetClassVariable];
    //    [self js_classAddIvar];
    //    [self js_classCopyIvarList];
    //    [self js_classGetIvarLayout];
    //    [self js_classSetIvarLayout];
    //    [self js_classGetWeakIvarLayout];
    //    [self js_classGetProperty];
    //    [self js_classCopyPropertyList];
    //    [self js_classAddMethod];
    //    [self js_classGetInstanceMethod];
    //    [self js_classGetClassMethod];
    //    [self js_classCopyMethodList];
    //    [self js_classGetMethodImplementation];
    //    [self js_classGetMethodImplementationStret];
    //    [self js_classRespondsToSelector];
    //    [self js_classAddProtocol];
    //    [self js_classConformsToProtocol];
    //    [self js_classAddProperty];
    //    [self js_classReplaceProperty];
    //    [self js_classCopyProtocolList];
    //    [self js_classSetVersion];
    //    [self js_classGetVersion];
    //    [self js_objcAllocateClassPair];
    //    [self js_classCreateInstance];
    
    //    id student = [NSClassFromString(@"JSStudent") new];
    //    [student test:@"1111111"];
    
    //    DetailViewController *detailVC = [[DetailViewController alloc]init];
    //    [detailVC setValue:@"helloworld" forKey:@"addName"];
    //    NSLog(@"%@", [detailVC valueForKey:@"addName"]);
    // [detailVC performSelector:@selector(test)];
}

/*
 log:DetailViewController
 */
- (void)js_classGetName
{
    NSString *className = [NSString stringWithCString:class_getName(NSClassFromString(@"DetailViewController")) encoding:NSUTF8StringEncoding];
    NSLog(@"%@",className);
}
/*
 log:UIViewController
 */
- (void)js_classGetSuperClass
{
    Class superClass = class_getSuperclass(NSClassFromString(@"DetailViewController"));
    NSString *className = [NSString stringWithCString:class_getName(superClass) encoding:NSUTF8StringEncoding];
    NSLog(@"%@",className);
}
/*
 UIViewController is not meta class
 */
- (void)js_classIsMetaClass
{
    Class superClass = class_getSuperclass(NSClassFromString(@"DetailViewController"));
    if (class_isMetaClass(superClass)) {
        NSLog(@"%@ is meta class",superClass);
    }else{
        NSLog(@"%@ is not meta class",superClass);
    }
}
/*
 904
 */
- (void)js_classGetInstanceSize
{
    Class class = NSClassFromString(@"DetailViewController");
    size_t size = class_getInstanceSize(class);
    NSLog(@"%zu",size);
}
/*
 _number @"NSNumber"
 */
- (void)js_classGetInstanceVariable
{
    Class class = NSClassFromString(@"DetailViewController");
    Ivar ivar = class_getInstanceVariable(class, "_number");
    NSString *name = [NSString stringWithCString:ivar_getName(ivar) encoding:NSUTF8StringEncoding];
    NSString *type = [NSString stringWithCString:ivar_getTypeEncoding(ivar) encoding:NSUTF8StringEncoding];
    NSString *desc = [NSString stringWithFormat:@"%@ %@",name,type];
    NSLog(@"%@",desc);
}
/*
 OC一般没有类成员的定义，此方法一般不用
 */
- (void)js_classGetClassVariable
{
    Class class = NSClassFromString(@"DetailViewController");
    class_getClassVariable(class, "XXX");
}
/*
 This function may only be called after objc_allocateClassPair and before objc_registerClassPair.
 Adding an instance variable to an existing class is not supported.
 */
- (void)js_classAddIvar
{
    //    class_addIvar();
}
/*
 log:-----(
 "_isTrue B",
 "_floatNumber f",
 "_content @\"NSString\"",
 "_number @\"NSNumber\"",
 "_index q",
 "_url @\"NSURL\"",
 "_currentTime @\"NSDate\"",
 "_doubleNumber d",
 "_vc @\"ViewController\""
 )-----
 
 */
- (void)js_classCopyIvarList
{
    Class class = NSClassFromString(@"DetailViewController");
    unsigned int count;
    Ivar *ivars = class_copyIvarList(class, &count);
    NSMutableArray *resultArray = [NSMutableArray array];
    for (int i=0; i<count; i++) {
        Ivar ivar = ivars[i];
        NSString *name = [NSString stringWithCString:ivar_getName(ivar) encoding:NSUTF8StringEncoding];
        NSString *type = [NSString stringWithCString:ivar_getTypeEncoding(ivar) encoding:NSUTF8StringEncoding];
        NSString *desc = [NSString stringWithFormat:@"%@ %@",name,type];
        [resultArray addObject:desc];
        
    }
    NSLog(@"-----%@-----",resultArray);
    free(ivars);
    
}
/*
 strong:
 \x12
 \x12
 ----------
 weak:
 */
- (void)js_classGetIvarLayout
{
    printf("strong:\n");
    const uint8_t *array_s = class_getIvarLayout([UIViewController class]);
    int i = 0;
    if (!array_s) {
        return;
    }
    uint8_t value_s = array_s[i];
    while (value_s != 0x0) {
        printf("\\x%02x\n", value_s);
        value_s = array_s[++i];
    }
    
    printf("----------\n");
    
    printf("weak:\n");
    const uint8_t *array_w = class_getWeakIvarLayout([UIViewController class]);
    int j = 0;
    if (!array_w) {
        return;
    }
    uint8_t value_w = array_w[j];
    while (value_w != 0x0) {
        printf("\\x%02x\n", value_w);
        value_w = array_w[++j];
    }
}

- (void)js_classSetIvarLayout
{
    //    class_setIvarLayout();
}

- (void)js_classGetWeakIvarLayout
{
    //    class_getWeakIvarLayout();
}
/*
 number T@"NSNumber",&,N,V_number
 */
- (void)js_classGetProperty
{
    Class class = NSClassFromString(@"DetailViewController");
    objc_property_t property = class_getProperty(class, "number");
    NSString *name = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
    NSString *attribute = [NSString stringWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
    NSString *desc = [NSString stringWithFormat:@"%@ %@",name,attribute];
    NSLog(@"%@",desc);
}
/*
 -----(
 "content T@\"NSString\",C,N,V_content",
 "number T@\"NSNumber\",&,N,V_number",
 "index Tq,N,V_index",
 "url T@\"NSURL\",&,N,V_url",
 "currentTime T@\"NSDate\",&,N,V_currentTime",
 "isTrue TB,N,V_isTrue",
 "floatNumber Tf,N,V_floatNumber",
 "doubleNumber Td,N,V_doubleNumber"
 )----
 */
- (void)js_classCopyPropertyList
{
    Class class = NSClassFromString(@"DetailViewController");
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList(class, &count);
    NSMutableArray *array = [NSMutableArray array];
    for (int i=0; i<count; i++) {
        objc_property_t property = properties[i];
        NSString *name = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        NSString *attribute = [NSString stringWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
        NSString *desc = [NSString stringWithFormat:@"%@ %@",name,attribute];
        [array addObject:desc];
    }
    free(properties);
    NSLog(@"-----%@----",array);
}

- (void)test:(NSString *)string{
    NSLog(@"helloworld--%@---%@",NSStringFromClass([self class]),string);
}
/*
 log:helloworld--DetailViewController
 */
- (void)js_classAddMethod
{
    Class class = NSClassFromString(@"DetailViewController");
    SEL selector = @selector(test:);
    Method method = class_getInstanceMethod([self class], selector);
    IMP selectorIMP = method_getImplementation(method);
    BOOL isSuccess = class_addMethod(class, selector, selectorIMP, method_getTypeEncoding(method));
    if (isSuccess) {
        NSLog(@"添加方法成功");
    }else
    {
        NSLog(@"添加方法失败");
    }
}
/*
 log:----viewDidLoad v16@0:8----
 */
- (void)js_classGetInstanceMethod
{
    Class class = NSClassFromString(@"DetailViewController");
    
    Method method = class_getInstanceMethod(class, @selector(viewDidLoad));
    NSString *name = [NSString stringWithCString:sel_getName(method_getName(method)) encoding:NSUTF8StringEncoding];
    NSString *type = [NSString stringWithCString:method_getTypeEncoding(method) encoding:NSUTF8StringEncoding];
    NSString *desc = [NSString stringWithFormat:@"%@ %@",name,type];
    NSLog(@"----%@----",desc);
    
}
/*
 log:----getDescription: @24@0:8@16----
 */
- (void)js_classGetClassMethod
{
    Class class = NSClassFromString(@"DetailViewController");
    
    Method method = class_getClassMethod(class, @selector(getDescription:));
    NSString *name = [NSString stringWithCString:sel_getName(method_getName(method)) encoding:NSUTF8StringEncoding];
    NSString *type = [NSString stringWithCString:method_getTypeEncoding(method) encoding:NSUTF8StringEncoding];
    NSString *desc = [NSString stringWithFormat:@"%@ %@",name,type];
    NSLog(@"----%@----",desc);
}
/*
 log:------(
 "floatNumber f16@0:8",
 "doubleNumber d16@0:8",
 "isTrue B16@0:8",
 "setIsTrue: v20@0:8B16",
 "setFloatNumber: v20@0:8f16",
 "setDoubleNumber: v24@0:8d16",
 "url @16@0:8",
 ".cxx_destruct v16@0:8",
 "setIndex: v24@0:8q16",
 "index q16@0:8",
 "number @16@0:8",
 "setNumber: v24@0:8@16",
 "content @16@0:8",
 "setContent: v24@0:8@16",
 "setCurrentTime: v24@0:8@16",
 "currentTime @16@0:8",
 "viewDidLoad v16@0:8",
 "previewActionItems @16@0:8",
 "setUrl: v24@0:8@16"
 )-----
 
 */
- (void)js_classCopyMethodList
{
    Class class = NSClassFromString(@"DetailViewController");
    unsigned int count;
    NSMutableArray *resultArray = [NSMutableArray array];
    Method *methods = class_copyMethodList(class, &count);
    for (int i=0; i<count; i++) {
        Method method = methods[i];
        NSString *name = [NSString stringWithCString:sel_getName(method_getName(method)) encoding:NSUTF8StringEncoding];
        NSString *type = [NSString stringWithCString:method_getTypeEncoding(method) encoding:NSUTF8StringEncoding];
        NSString *desc = [NSString stringWithFormat:@"%@ %@",name,type];
        [resultArray addObject:desc];
    }
    free(methods);
    NSLog(@"------%@-----",resultArray);
}

- (void)js_classGetMethodImplementation
{
    //    class_getMethodImplementation(,);
}

- (void)js_classGetMethodImplementationStret
{
    //    class_getMethodImplementation_stret(,);
}
/*
 DetailViewController is responds to selector
 */
- (void)js_classRespondsToSelector
{
    Class class = NSClassFromString(@"DetailViewController");
    SEL selector = @selector(viewDidLoad);
    BOOL isSuccess = class_respondsToSelector(class, selector);
    if (isSuccess) {
        NSLog(@"%@ is responds to selector",class);
    }else
    {
        NSLog(@"%@ is not responds to selector",class);
    }
}
/*
 add protocol: <Protocol: 0x1145b4dd8> successed
 */
- (void)js_classAddProtocol
{
    Protocol *protocol = objc_getProtocol("UITableViewDelegate");
    Class class = NSClassFromString(@"DetailViewController");
    BOOL isSuccess =  class_addProtocol(class, protocol);
    if (isSuccess) {
        NSLog(@"add protocol: %@ successed ",protocol);
    }else{
        NSLog(@"add protocol: %@ failure",protocol);
    }
}
/*
 {
 attribute =         (
 strong,
 atomic   );
 isDynamic = 0;
 name = addName;
 type = "__NSCFConstantString*";
 }
 */
- (void)js_classAddProperty
{
    Class class = NSClassFromString(@"DetailViewController");
    NSString *value = @"hello";
    objc_property_attribute_t type = {"T",[[NSString stringWithFormat:@"@\"%@\"",NSStringFromClass([value class])] UTF8String]};
    objc_property_attribute_t ownership = {"&","N"};
    objc_property_attribute_t backingivar = {"V",[[NSString stringWithFormat:@"_%@",@"addName"] UTF8String]};
    objc_property_attribute_t attrs[] = {type,ownership,backingivar};
    unsigned int attrsCount = 3;
    BOOL isSuccess = class_addProperty(class, [@"addName" UTF8String], attrs, attrsCount);
    class_addMethod(class, @selector(setAddName:), method_getImplementation(class_getInstanceMethod([self class], @selector(setAddName:))), method_getTypeEncoding(class_getInstanceMethod([self class], @selector(setAddName:))));
    
    class_addMethod(class, @selector(addName), method_getImplementation(class_getInstanceMethod([self class], @selector(addName))), method_getTypeEncoding(class_getInstanceMethod([self class], @selector(addName))));
    
    if (isSuccess) {
        NSLog(@"动态添加属性成功");
    }else{
        NSLog(@"动态添加属性失败");
    }
    
//    NSArray *array = [[UIViewController new] propertiesInfo];
//    NSLog(@"%@",array);
}

- (NSString *)addName{
    return objc_getAssociatedObject(self, @selector(addName));
}

- (void)setAddName:(NSString *)name{
    objc_setAssociatedObject(self, @selector(addName), name, OBJC_ASSOCIATION_COPY);
}
/*
 比较麻烦，一般不用
 */
- (void)js_classReplaceProperty
{
    //    Class class = NSClassFromString(@"DetailViewController");
    //    class_replaceProperty(class, , , )
}
/*
 log:DetailViewController conform to <Protocol: 0x119ab5dd8>
 */
- (void)js_classConformsToProtocol
{
    Class class = NSClassFromString(@"DetailViewController");
    Protocol *protocol = objc_getProtocol("UITableViewDelegate");
    BOOL isSuccess = class_conformsToProtocol(class, protocol);
    if (isSuccess) {
        NSLog(@"%@ conform to %@",class,protocol);
    }else{
        NSLog(@"%@ not conform to %@",class,protocol);
    }
}
/*
 log:-----(
 UITableViewDelegate,
 UITableViewDataSource,
 UIAlertViewDelegate
 )------
 */
- (void)js_classCopyProtocolList
{
    unsigned int count;
    Class class = NSClassFromString(@"DetailViewController");
    Protocol * __unsafe_unretained * protocols = class_copyProtocolList(class, &count);
    NSMutableArray *resultArary = [NSMutableArray array];
    for (int i=0; i<count; i++) {
        Protocol __unsafe_unretained *protocol = protocols[i];
        NSString *name = [NSString stringWithCString:protocol_getName(protocol) encoding:NSUTF8StringEncoding];
        [resultArary addObject:name];
    }
    free(protocols);
    NSLog(@"-----%@------",resultArary);
}
/*
 默认初始化为0
 log:---0----
 */
- (void)js_classGetVersion
{
    int version = class_getVersion([UIView class]);
    NSLog(@"---%d----",version);
}
- (void)js_classSetVersion
{
    class_setVersion([UIView class], 2);
}
#pragma mark -Adding Classes
- (void)js_objcAllocateClassPair
{
    Class superClass = [NSObject class];
    Class targetClass =  objc_allocateClassPair(superClass, "JSStudent", 0);
    Method method = class_getInstanceMethod([self class], @selector(test:));
    class_addMethod(targetClass, @selector(test:), method_getImplementation(method), method_getTypeEncoding(method));
    objc_registerClassPair(targetClass);
}

#pragma mark -Instantiating Classes
- (void)js_classCreateInstance
{
    Class class = NSClassFromString(@"JSStudent");
    id student = class_createInstance(class,0);
    [student test:@"2222222"];
}

#pragma mark -Working with Instances








@end
