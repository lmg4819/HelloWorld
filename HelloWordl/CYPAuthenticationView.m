//
//  CYPAuthenticationView.m
//  PushProject
//
//  Created by lmg on 2019/5/31.
//  Copyright © 2019 lmg. All rights reserved.
//

#import "CYPAuthenticationView.h"

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

@interface CYPAuthenticationView ()
@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) UILabel *numberLabel;
@property (nonatomic,strong) UIView *centerView;
@property (nonatomic,strong) UITextField *textField;
@property (nonatomic,strong) UIButton *sendMsgButton;
@property (nonatomic,strong) UIButton *agreeButton;
@property (nonatomic,strong) UIButton *cancelButton;
@property (nonatomic,strong) UIButton *sureButton;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,assign) int timeCount;
@end

@implementation CYPAuthenticationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    if (self) {
        self.backgroundColor =  [UIColor colorWithRed:140/255.0 green:140/255.0 blue:140/255.0 alpha:1/1.0];
        self.contentView = [[UIView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-270)/2.0, (SCREEN_HEIGHT-240)/2-44, 270, 240)];
        self.contentView.layer.cornerRadius = 4;
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.contentView.layer.masksToBounds = YES;
        [self addSubview:self.contentView];
        
        CGFloat originalY = 20;
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(16, originalY, 270-32, 18)];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor colorWithRed:27/255.0 green:28/255.0 blue:51/255.0 alpha:1/1.0];
        titleLabel.font = [UIFont systemFontOfSize:18];
        titleLabel.text = @"手机验证";
        [self.contentView addSubview:titleLabel];
        
        originalY += (18+16);
        UILabel *numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(16, originalY, 270-32, 36)];
        numberLabel.text = @"我们将发送验证码到您的手机：\n150****1136";
        numberLabel.numberOfLines = 2;
        numberLabel.font = [UIFont systemFontOfSize:12];
        numberLabel.textColor = [UIColor colorWithRed:27/255.0 green:28/255.0 blue:51/255.0 alpha:1/1.0];
        [self.contentView addSubview:numberLabel];
        self.numberLabel = numberLabel;
        
        originalY += (32+16);
        UIView *centerView = [[UIView alloc]initWithFrame:CGRectMake(16,originalY, 270-32, 44)];
        centerView.layer.borderWidth = 1.0;
        
        centerView.layer.borderColor = [UIColor colorWithWhite:239/255.0  alpha:1.0].CGColor;
        centerView.layer.masksToBounds = YES;
        [self.contentView addSubview:centerView];
        self.centerView = centerView;
        
        UITextField *tf = [[UITextField alloc]initWithFrame:CGRectMake(12, 0, 100, 44)];
        tf.placeholder = @"请输入验证码";
        tf.font = [UIFont systemFontOfSize:14];
        tf.textColor = [UIColor colorWithWhite:221/255.0  alpha:1.0];
        [self.centerView addSubview:tf];
        self.textField = tf;
        
        UIView *sepView = [[UIView alloc]initWithFrame:CGRectMake(144, 8, 0.5, 28)];
        sepView.backgroundColor = [UIColor colorWithWhite:221/255.0  alpha:1.0];
        [self.centerView addSubview:sepView];
    
        UIButton *sendBtn = [[UIButton alloc]initWithFrame:CGRectMake(145, 0, 80, 44)];
        [sendBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
        [sendBtn setTitleColor:[UIColor colorWithRed:27/255.0 green:28/255.0 blue:51/255.0 alpha:1/1.0] forState:UIControlStateNormal];
        sendBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [sendBtn addTarget:self action:@selector(sendBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.centerView addSubview:sendBtn];
        self.sendMsgButton = sendBtn;
        
        
        originalY += (44+16);
        UIButton *agreeBtn = [[UIButton alloc]initWithFrame:CGRectMake(16, originalY, 44, 12)];
        [agreeBtn setTitle:@"同意" forState:UIControlStateNormal];
        [agreeBtn setTitle:@"同意" forState:UIControlStateSelected];
        [agreeBtn setImage:[UIImage imageNamed:@"对号2-2"] forState:UIControlStateSelected];
        agreeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, -8);
        agreeBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 5);
        [agreeBtn setImage:[UIImage imageNamed:@"对号2-1"] forState:UIControlStateNormal];
        agreeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [agreeBtn setTitleColor:[UIColor colorWithWhite:102/255.0  alpha:1.0] forState:UIControlStateNormal];
        [agreeBtn addTarget:self action:@selector(agreeBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:agreeBtn];
        self.agreeButton = agreeBtn;
        
        UIButton *payProtocolBtn = [[UIButton alloc]initWithFrame:CGRectMake(60, originalY, 150, 12)];
        [payProtocolBtn setTitle:@"《车易拍平台支付协议》" forState:UIControlStateNormal];
        [payProtocolBtn setTitleColor:[UIColor colorWithRed:255/255.0 green:87/255.0 blue:26/255.0 alpha:1.0] forState:UIControlStateNormal];
        payProtocolBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [payProtocolBtn addTarget:self action:@selector(payProtocolBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:payProtocolBtn];
        
        originalY += (12+16);
        UIView *sepView1 = [[UIView alloc]initWithFrame:CGRectMake(0, originalY, 270, 0.5)];
        sepView1.backgroundColor = [UIColor colorWithWhite:235/255.0  alpha:1.0];
        [self.contentView addSubview:sepView1];
        
        UIButton *cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(0, originalY+0.5, 134, 46)];
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        cancelButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [cancelButton setTitleColor:[UIColor colorWithRed:27/255.0 green:28/255.0 blue:51/255.0 alpha:1/1.0] forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:cancelButton];
        
        UIView *sepView2 = [[UIView alloc]initWithFrame:CGRectMake(134, originalY+1, 0.5, 46)];
        sepView2.backgroundColor = [UIColor colorWithWhite:235/255.0  alpha:1.0];
        [self.contentView addSubview:sepView2];
        
        UIButton *sureButton = [[UIButton alloc]initWithFrame:CGRectMake(135, originalY+0.5, 134, 46)];
        [sureButton setTitle:@"确认绑卡" forState:UIControlStateNormal];
        sureButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [sureButton setTitleColor:[UIColor colorWithRed:255/255.0 green:87/255.0 blue:26/255.0 alpha:1/1.0] forState:UIControlStateNormal];
        [sureButton addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:sureButton];
        
        
    }
    return self;
}

- (void)cancelAction
{
    [self removeFromSuperview];
}

- (void)sureAction
{
    
}

- (void)sendBtnAction:(UIButton *)sender
{
    self.sendMsgButton.enabled = NO;
    self.timeCount = 60;
    [self.sendMsgButton setTitle:[NSString stringWithFormat:@"%dS",self.timeCount] forState:UIControlStateNormal];
    [self.sendMsgButton setTitleColor:[UIColor colorWithWhite:221/255.0 alpha:1.0] forState:UIControlStateNormal];
     [self.timer fire];
    
}

- (void)agreeBtnAction
{
    self.agreeButton.selected = !self.agreeButton.selected;
}

- (void)payProtocolBtnAction
{
    
}

#pragma mark -Lazy init
-(NSTimer *)timer
{
    if (!_timer) {
        __weak typeof(self) weakSelf = self;
        _timer = [NSTimer timerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if (!strongSelf) {
                return ;
            }
            strongSelf.timeCount--;
            if (strongSelf.timeCount == 0) {
                strongSelf.sendMsgButton.enabled = YES;
                [strongSelf.sendMsgButton setTitle:@"重新发送" forState:UIControlStateNormal];
                [strongSelf.sendMsgButton setTitleColor:[UIColor colorWithRed:27/255.0 green:28/255.0 blue:51/255.0 alpha:1/1.0] forState:UIControlStateNormal];
                [strongSelf.timer invalidate];
                strongSelf.timer = nil;
                
            }else{
                [strongSelf.sendMsgButton setTitle:[NSString stringWithFormat:@"%dS",strongSelf.timeCount] forState:UIControlStateNormal];
                [strongSelf.sendMsgButton setTitleColor:[UIColor colorWithWhite:221/255.0 alpha:1.0] forState:UIControlStateNormal];
            }
        }];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}

@end
