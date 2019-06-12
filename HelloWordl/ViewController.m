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
#import "CYPAuthenticationView.h"

@interface ViewController ()
@property (nonatomic,strong) UITextField *textField;

@property (nonatomic,strong) NSThread *thread;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    ((UINavigationController *)[UIApplication sharedApplication].delegate.window.rootViewController).topViewController
    
    
    
    
    
    NSLock *mainLock = [[NSLock alloc]init];
//    [ViewController helloWorld];
    dispatch_async(dispatch_get_main_queue(), ^{
        
    });
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
    });
    
  
    JSTextContext *context =[JSTextContext new];
    self.thread = [[NSThread alloc]initWithTarget:self selector:@selector(run1) object: nil];
    [self.thread start];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifica) name:@"hello" object:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"hello" object:nil userInfo:nil];
    });

}

- (void)notifica{
    NSLog(@"-----%@------",[NSThread currentThread]);
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    
}
- (void)run1
{
//    NSLog(@"----run1----");
    
    [[NSRunLoop currentRunLoop] addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop] run];
    
    NSLog(@"未开启RunLoop");
    
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CYPAuthenticationView *authView = [[CYPAuthenticationView alloc]initWithFrame:CGRectZero];
        [self.view addSubview:authView];
    });
   
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


//@implementation NSObject (VCExtension)
//
//-(void)helloWorld
//{
//    NSLog(@"----------11111111111");
//}
//
//@end
