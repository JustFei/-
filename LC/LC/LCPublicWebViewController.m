//
//  LCPublicWebViewController.m
//  LC
//
//  Created by JustBill on 16/5/18.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import "LCPublicWebViewController.h"
#import "LCPublicWebContentView.h"

@interface LCPublicWebViewController ()

@property (nonatomic ,weak)LCPublicWebContentView *webView;

@end

@implementation LCPublicWebViewController

- (void)setModel:(LCPublicWebModel *)model
{
    _model = model;
    self.webView.model = model;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    
//    self.title = _titleText;
    
    self.webView.backgroundColor = [UIColor colorWithRed:26.0/255.0 green:26.0/255.0 blue:26.0/255.0 alpha:1];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - lazy
- (LCPublicWebContentView *)webView
{
    if (!_webView) {
        LCPublicWebContentView *web = [[LCPublicWebContentView alloc] init];
        web.frame = self.view.frame;
        [self.view addSubview:web];
        
        _webView = web;
    }
    
    return _webView;
}

@end
