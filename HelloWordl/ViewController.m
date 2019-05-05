//
//  ViewController.m
//  HelloWordl
//
//  Created by lmg on 2019/4/28.
//  Copyright © 2019 lmg. All rights reserved.
//

#import "ViewController.h"
#import "JSRunTime.h"
#import "JSTextContext.h"
#import <pthread/pthread.h>

@interface ViewController ()
@property (nonatomic,strong) UITextField *textField;

@property (nonatomic,strong) NSThread *thread;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    ((UINavigationController *)[UIApplication sharedApplication].delegate.window.rootViewController).topViewController
  
    JSTextContext *context =[JSTextContext new];
    self.thread = [[NSThread alloc]initWithTarget:self selector:@selector(run1) object: nil];
    [self.thread start];

}

- (void)run1
{
//    NSLog(@"----run1----");
    
    [[NSRunLoop currentRunLoop] addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop] run];
    
    NSLog(@"未开启RunLoop");
    
}

- (void)run2
{
    NSLog(@"----run2------");
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self performSelector:@selector(run2) onThread:self.thread withObject:nil waitUntilDone:NO];
}

/*
 1.如何去除苹果自带输入法输入英文时的“空格”
 解决方法：“空格”的字符为“8198”。
 */
- (void)question1
{
    NSString *checker = [NSString stringWithFormat:@"%C",8198];
    if ([self.textField.text rangeOfString:checker].length) {
        self.textField.text = [self.textField.text stringByReplacingOccurrencesOfString:checker withString:@""];
    }
}
/*
 2.[PHPhotoLibrary performChanges:completionHandler:]和
 [PHPhotoLibrary performChangesAndWait:error:]不要在主线程中调用此方法。您的更改块，以及Photos代表您执行的应用它请求的更改的工作，都需要一些时间来执行。(照片可能需要提示用户执行更改，所以这个方法可以无限期地阻止执行。)如果您已经在后台队列上执行了操作，导致要应用于照片库的更改，请使用此方法。要从主队列请求更改，请使用performChanges:completionHandler:方法。
 */
- (void)question2
{
//    [PHPhotoLibrary performChanges:completionHandler:]是异步执行的，任务完成后执行回调
//    [PHPhotoLibrary performChangesAndWait:error:]同步执行，返回错误值，不要在主线程中执行这个方法
}

@end


@interface _YYLinkedMapNode : NSObject
{
    @package
    __unsafe_unretained _YYLinkedMapNode *_prev;
    __unsafe_unretained _YYLinkedMapNode *_next;
    id _key;
    id _value;
    NSUInteger _cost;
    NSTimeInterval _time;
}
@end
@implementation _YYLinkedMapNode
@end


@interface _YYLinkedMap : NSObject
{
    @package
    CFMutableDictionaryRef _dic;
    NSUInteger _totalCost;
    NSUInteger _totalCount;
    _YYLinkedMapNode *_head;
    _YYLinkedMapNode *_tail;
    BOOL _releaseOnMainThread;
    BOOL _releaseAsynchronously;
}
- (void)insertNodeAtHead:(_YYLinkedMapNode *)node;

- (void)bringNodeToHead:(_YYLinkedMapNode *)node;

- (void)removeNode:(_YYLinkedMapNode *)node;

- (_YYLinkedMapNode *)removeTailNode;
/// Remove all node in background queue.
- (void)removeAll;

@end

@implementation _YYLinkedMap

-(instancetype)init
{
    self = [super init];
    _dic = CFDictionaryCreateMutable(CFAllocatorGetDefault(), 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    _releaseOnMainThread = NO;
    _releaseAsynchronously = YES;
    return self;
}

-(void)dealloc
{
    CFRelease(_dic);
}

-(void)insertNodeAtHead:(_YYLinkedMapNode *)node
{
    CFDictionarySetValue(_dic, (__bridge const void *)(node->_key), (__bridge const void *)(node));
    _totalCost += node->_cost;
    _totalCount ++;
    if (_head) {
        node->_next = _head;
        _head->_prev = node;
        _head = node;
    }else{
        _head = _tail = node;
    }
}

-(void)bringNodeToHead:(_YYLinkedMapNode *)node
{
    if (node == _head) {
        return;
    }
    if (_tail == node) {
        _tail = node->_prev;
        _tail->_next = nil;
    }else
    {
        node->_next->_prev = node->_prev;
        node->_prev->_next = node->_next;
    }
    node->_next = _head;
    node->_prev = nil;
    _head->_prev = node;
    _head = node;
}

-(void)removeNode:(_YYLinkedMapNode *)node
{
    CFDictionaryRemoveValue(_dic, (__bridge const void *)(node->_key));
    _totalCount--;
    _totalCost -= node->_cost;
    if (node->_next) {
        node->_next->_prev = node->_prev;
    }
    if (node->_prev) {
        node->_prev->_next = node->_next;
    }
    
    if (node == _head) {
        _head = node->_next;
    }
    if (node == _tail) {
        _tail = node->_prev;
    }
}

-(_YYLinkedMapNode *)removeTailNode
{
    if (!_tail) {
        return nil;
    }
    _YYLinkedMapNode *tail = _tail;
    CFDictionaryRemoveValue(_dic, (__bridge const void *)(tail->_key));
    _totalCost -= _tail->_cost;
    _totalCount--;
    if (_head == _tail) {
        _head = _tail = nil;
    }else{
        _tail = _tail->_prev;
        _tail->_next = nil;
    }
    return tail;
}

-(void)removeAll
{
    _totalCost = 0;
    _totalCount = 0;
    _head = _tail = nil;
    if (CFDictionaryGetCount(_dic) > 0) {
        CFMutableDictionaryRef holder = _dic;
        _dic = CFDictionaryCreateMutable(CFAllocatorGetDefault(), 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
        
        if (_releaseAsynchronously) {
            dispatch_queue_t queue = _releaseOnMainThread ?dispatch_get_main_queue():dispatch_get_global_queue(0, 0);
            dispatch_async(queue, ^{
                CFRelease(holder);
            });
        }else if (_releaseOnMainThread && !pthread_main_np()){
            dispatch_async(dispatch_get_main_queue(), ^{
                CFRelease(holder);
            });
        }
    }
}

@end
