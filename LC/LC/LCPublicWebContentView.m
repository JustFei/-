//
//  LCPublicWebContentView.m
//  LC
//
//  Created by JustBill on 16/5/18.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import "LCPublicWebContentView.h"
#import "LCShareListView.h"


@interface LCPublicWebContentView ()<UIGestureRecognizerDelegate>
{
    NSString *_contentUrl ;
    NSString *_imageUrl;
}

@property (nonatomic ,weak) UIView *navigationBarView;

@property (nonatomic ,weak) UILabel *naviTitleLabel;

@property (nonatomic ,weak) UIWebView *webView;

@property (nonatomic ,weak) LCShareListView *shareListView;

@end

@implementation LCPublicWebContentView

- (void)setModel:(LCPublicWebModel *)model
{
    _model = model;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:model.webUrl]]];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.webView.frame = CGRectMake(0, 64, self.frame.size.width, self.frame.size.height );
    
    self.navigationBarView.frame = CGRectMake(0, 0, self.frame.size.width, 64);
    
    CGFloat center = self.frame.size.width / 2;
    self.naviTitleLabel.frame = CGRectMake(center - 40, 20, 80, 44);
    
    self.shareListView.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, 90);
    self.shareListView.model = self.model;
}

#pragma mark - lazy
- (UIView *)navigationBarView
{
    if (!_navigationBarView) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor colorWithRed:26.0 / 255.0 green:26.0 / 255.0 blue:26.0 / 255.0 alpha:1];
        
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        leftBtn.frame = CGRectMake(20, 35, 8, 15);
        [leftBtn setImage:[UIImage imageNamed:@"btn_nav_back_default"] forState:UIControlStateNormal];
        [leftBtn addTarget:self action:@selector(backBtn) forControlEvents:UIControlEventTouchUpInside];
        leftBtn.backgroundColor = [UIColor clearColor];
        
        UIButton *rightLikeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightLikeBtn.frame = CGRectMake(self.frame.size.width - 70, 27, 30, 30);
        [rightLikeBtn setImage:[UIImage imageNamed:@"spec_favour_icon"] forState:UIControlStateNormal];
        [rightLikeBtn setImage:[UIImage imageNamed:@"btn_cell_favorite"] forState:UIControlStateSelected];
        rightLikeBtn.backgroundColor = [UIColor clearColor];
        [rightLikeBtn addTarget:self action:@selector(likeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *rightShareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightShareBtn.frame = CGRectMake(self.frame.size.width - 40, 27, 30, 30);
        [rightShareBtn setImage:[UIImage imageNamed:@"btn_ware_forward_h"] forState:UIControlStateNormal];
        rightShareBtn.backgroundColor = [UIColor clearColor];
        [rightShareBtn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [view addSubview:leftBtn];
        //[view addSubview:rightLikeBtn];
        [view addSubview:rightShareBtn];
        [self addSubview:view];
        _navigationBarView = view;
    }
    
    return _navigationBarView;
}

- (UILabel *)naviTitleLabel
{
    if (!_naviTitleLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"良仓杂志";
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:13];
        
        [self.navigationBarView addSubview:label];
        _naviTitleLabel = label;
    }
    
    return _naviTitleLabel;
}

- (UIWebView *)webView
{
    if (!_webView) {
        UIWebView *web = [[UIWebView alloc] initWithFrame:self.bounds];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenShareListView)];
        tap.delegate = self;
        
        
        [web addGestureRecognizer:tap];
        
        [self addSubview:web];
        _webView = web;
    }
    
    return _webView;
}

// 允许多个手势并发
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (void)hiddenShareListView
{
    [UIView animateWithDuration:0.2 animations:^{
        self.shareListView.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, 90);
    }];
}

- (LCShareListView *)shareListView
{
    if (!_shareListView) {
        LCShareListView *view = [[NSBundle mainBundle] loadNibNamed:@"LCShareListView" owner:nil options:nil][0];
        
        [self addSubview:view];
        _shareListView = view;
    }
    
    return _shareListView;
}

#pragma mark - navigationbar按钮点击事件
- (void)backBtn
{
    //获取视图所在的控制器
    UIViewController *vc = [self viewController];
    
    [vc.navigationController popViewControllerAnimated:YES];
}

- (UIViewController *)viewController
{
    for (UIView* next = [self superview]; next; next = next.superview)
    {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (void)likeBtnClick:(UIButton *)likeBtn
{
    likeBtn.selected = !likeBtn.selected;
}

- (void)shareBtnClick:(UIButton *)shareBtn
{
    
    [UIView animateWithDuration:0.1 animations:^{
        self.shareListView.frame = CGRectMake(0, self.frame.size.height - 90, self.frame.size.width, 90);
    }];
    
}


@end
