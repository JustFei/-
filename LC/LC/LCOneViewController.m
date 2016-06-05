//
//  OneViewController.m
//  LC
//
//  Created by JustBill on 16/5/17.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import "LCOneViewController.h"
#import "LCMainContentView.h"
#import "YCSegmentView.h"
#import "LCBrandViewController.h"
#import "LCHomePageViewController.h"
#import "LCSubjectViewController.h"
#import "LCGiftViewController.h"
#import "LCPublicWebViewController.h"
#import "LCShopShowViewController.h"
#import "LCPublicBrandShowViewController.h"
#import  "LCBrandModel.h"


@interface LCOneViewController ()

//@property (nonatomic ,weak)LCCatalogueViewController *vc1;
//@property (nonatomic ,weak)LCBrandViewController *vc2;
//@property (nonatomic ,weak)LCHomePageViewController *vc3;
//@property (nonatomic ,weak)LCSubjectViewController *vc4;
//@property (nonatomic ,weak)LCGiftViewController *vc5;

//@property (nonatomic ,weak)YCSegmentView *YCview;



@property (nonatomic ,weak)UILabel *naviTitleLabel;

@end

@implementation LCOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIBarButtonItem *leftBackBtn = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"btn_nav_search"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(search)];
    
    self.navigationItem.leftBarButtonItem = leftBackBtn;
    
    UIBarButtonItem *rightCatBtn = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"btn_cart"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(catBtn)];
    
    self.navigationItem.rightBarButtonItem = rightCatBtn;
    
    [self createUI];
    
    [self receiveNotification];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = NO;
}

- (void)receiveNotification
{
    //push到webview的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushToWebView:) name:@"homePageContentViewPushPublicWebView" object:nil];
    
    //giftView push 到shopshowView
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushToShopShowView:) name:@"giftContentViewPushPublicShopShowView" object:nil];
    
    //brandContentView push到brandShowController
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushToBrandShowView:) name:@"brandCellSelectAction" object:nil];
    
}

- (void)createUI
{
    LCBrandViewController *vc1 = [[LCBrandViewController alloc] init];
    vc1.title = @"品牌";
    
    LCHomePageViewController *vc2 = [[LCHomePageViewController alloc] init];
    vc2.title = @"首页";
    
    [vc2 setHomePageShopShowCallBack:^(NSString *goodurl) {
        LCShopShowViewController *shopShowView = [[LCShopShowViewController alloc] init];
        //这里setModel
        shopShowView.goodurl = goodurl;
        [self.navigationController pushViewController:shopShowView animated:YES];
    }];
    
    LCSubjectViewController *vc3 = [[LCSubjectViewController alloc] init];
    vc3.title = @"专题";
    //在这里执行block调用
    [vc3 setSubjectCallBack:^(LCPublicWebModel *model) {
        LCPublicWebViewController *webView = [[LCPublicWebViewController alloc] init];
        webView.model = model;
        [webView setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:webView animated:YES];
    }];
    
    LCGiftViewController *vc4 = [[LCGiftViewController alloc] init];
    vc4.title = @"礼物";
    
    //设置view的frame
    YCSegmentView *YCview = [[YCSegmentView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 49) titleHeight:33 viewControllers:@[vc1,vc2,vc3,vc4] underColor:[UIColor colorWithRed:28.0/255.0 green:28.0/255.0 blue:28.0/255.0 alpha:1]];
    
//    设置view上的title的normal和Select状态下的颜色
    YCview.normalColor = [UIColor colorWithRed:114.0/255.0 green:114.0/255.0 blue:114.0/255.0 alpha:1];
    YCview.highlightColor = [UIColor whiteColor];
//    view.font = [UIFont systemFontOfSize:];
    
    [self.view addSubview:YCview];
}

#pragma mark - 通知中心事件管理

- (void)pushToWebView:(NSNotification *)noti
{
    //这里传url过去，但是现实不出网页。url是正确的
//    NSLog(@"noti==%@",noti.object);
    LCPublicWebViewController *webView = [[LCPublicWebViewController alloc] init];
    webView.model = noti.object;
    
    [webView setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:webView animated:YES];
}

- (void)pushToShopShowView:(NSNotification *)noti
{
    LCShopShowViewController *shopShowView = [[LCShopShowViewController alloc] init];
    //这里setModel
    shopShowView.goodurl = noti.object;
    [self.navigationController pushViewController:shopShowView animated:YES];
}

- (void)pushToBrandShowView:(NSNotification *)noti
{
    LCPublicBrandShowViewController *brandShowView = [[LCPublicBrandShowViewController alloc] init];
    LCBrandModel *model = noti.object;
    brandShowView.descriptioN = model.Description;
    brandShowView.iD = model.Id;
    
    [self.navigationController pushViewController:brandShowView animated:YES];
}


#pragma mark - navigationBarItems 点击事件
- (void)search
{
    NSLog(@"这里是搜索功能");
}

- (void)catBtn
{
    NSLog(@"这里是购物车");
}


#pragma mark - dealloc
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
