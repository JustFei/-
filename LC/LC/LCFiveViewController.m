//
//  LCFiveViewController.m
//  LC
//
//  Created by JustBill on 16/5/17.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import "LCFiveViewController.h"
#import "LCRegistAndLoginView.h"

#define kScreenBounds [UIScreen mainScreen].bounds

@interface LCFiveViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backImgView;
@property (weak, nonatomic) IBOutlet UIImageView *userHeadImageView;
@property (weak, nonatomic) IBOutlet UIButton *registAndLoginButton;
@property (weak, nonatomic) IBOutlet UIView *dreamList;
@property (weak, nonatomic) IBOutlet UIView *message;
@property (weak, nonatomic) IBOutlet UIView *addressManage;
@property (weak, nonatomic) IBOutlet UIView *customerService;

@property (nonatomic ,weak) LCRegistAndLoginView *showRegistAndLoginView;

@end

@implementation LCFiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //设置头像
    [self setUserHeadImgView];
    
    //设置注册登录按钮
    [self setRegistAndLoginBtn];
    
    self.showRegistAndLoginView.backgroundColor = [UIColor blueColor];
    NSLog(@"%@",NSStringFromCGRect(self.showRegistAndLoginView.frame));
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self setNavigationBar];
    [self setBackImageView];
}

- (void)setUserHeadImgView
{
    _userHeadImageView.layer.cornerRadius = _userHeadImageView.frame.size.width / 2;
    _userHeadImageView.layer.borderWidth = 3.0f;
    _userHeadImageView.layer.borderColor = [[UIColor whiteColor] CGColor];
    _userHeadImageView.clipsToBounds = YES;
}

- (void)setRegistAndLoginBtn
{
    //设置按钮的样式以及边框的颜色
    _registAndLoginButton.layer.cornerRadius = 10;
    _registAndLoginButton.layer.borderWidth = 1.0f;
    _registAndLoginButton.layer.borderColor = [[UIColor whiteColor] CGColor];
    _registAndLoginButton.clipsToBounds = YES;
    
    //设置按钮的点击事件
    [_registAndLoginButton addTarget:self action:@selector(registAndLogIn) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setBackImageView
{
    _backImgView.image = [UIImage imageNamed:@"bgImage"];
    _backImgView.contentMode = UIViewContentModeScaleAspectFill;
    //[bgImgView setImageToBlur: [UIImage imageNamed:@"huoying.jpg"] blurRadius: completionBlock:nil];
    _backImgView.userInteractionEnabled = YES;
    /*
     毛玻璃的样式(枚举)
     UIBlurEffectStyleExtraLight,
     UIBlurEffectStyleLight,
     UIBlurEffectStyleDark
     */
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = CGRectMake(0, 0, 1000, 1000);
    [_backImgView addSubview:effectView];
}

- (void)setNavigationBar
{
    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    settingBtn.frame = CGRectMake(0, 5, 20, 20);
    [settingBtn setImage:[UIImage imageNamed:@"设置按钮"] forState:UIControlStateNormal];
    [settingBtn addTarget:self action:@selector(setting) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *settingItem = [[UIBarButtonItem alloc] initWithCustomView:settingBtn];
    
    self.navigationItem.rightBarButtonItem = settingItem;
    
    self.navigationController.navigationBar.translucent = YES;
    UIColor *color = [UIColor clearColor];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, 64);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
    //取出navigationbar 下面的线
    self.navigationController.navigationBar.clipsToBounds = YES;
}

- (void)setting
{
    NSLog(@"这里是设置");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 点击事件
- (void)registAndLogIn
{
    //self.tabBarController.tabBar.hidden = YES;
    [UIView animateWithDuration:0.2 animations:^{
        [self.tabBarController.view bringSubviewToFront:self.showRegistAndLoginView];
        self.showRegistAndLoginView.frame = CGRectMake(0, 0, kScreenBounds.size.width, kScreenBounds.size.height);
    }];
    NSLog(@"%@",NSStringFromCGRect(self.showRegistAndLoginView.frame));
}

#pragma mark - lazy
- (LCRegistAndLoginView *)showRegistAndLoginView
{
    if (!_showRegistAndLoginView) {
        LCRegistAndLoginView *view = [[NSBundle mainBundle] loadNibNamed:@"LCRegistAndLoginView" owner:nil options:nil][0];
        view.frame = CGRectMake(0, kScreenBounds.size.height, kScreenBounds.size.width, kScreenBounds.size.height);
        [view setSinaUserInfoCallBack:^(LCUserInfoModel *model) {
            [self.userHeadImageView sd_setImageWithURL:[NSURL URLWithString:model.iconUrl]];
            [self.registAndLoginButton setTitle:model.username forState:UIControlStateNormal];
            self.registAndLoginButton.enabled = NO;
        }];
        
        [view setQQUserInfoCallBack:^(LCUserInfoModel *model) {
            [self.userHeadImageView sd_setImageWithURL:[NSURL URLWithString:model.iconUrl]];
            [self.registAndLoginButton setTitle:model.username forState:UIControlStateNormal];
            self.registAndLoginButton.enabled = NO;
        }];
        
        
        
        [self.tabBarController.view addSubview:view];
        _showRegistAndLoginView = view;
    }
    
    return _showRegistAndLoginView;
}

@end
