//
//  LCGiftViewController.m
//  LC
//
//  Created by JustBill on 16/5/17.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import "LCGiftViewController.h"
#import "LCGiftContentView.h"

@interface LCGiftViewController ()

@property (nonatomic ,weak)UIView *giftContentView;

@end

@implementation LCGiftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _giftContentView = [[NSBundle mainBundle] loadNibNamed:@"LCGiftContentView" owner:nil options:nil][0];
    _giftContentView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64);
    
    [self.view addSubview:_giftContentView];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - lazy
//- (LCGiftContentView *)giftContentView
//{
//    if (!_giftContentView) {
//        _giftContentView = [[NSBundle mainBundle] loadNibNamed:@"LCGiftContentView" owner:nil options:nil][0];
//        _giftContentView.frame = self.view.frame;
//        
//        [self.view addSubview:_giftContentView];
//    }
//    
//    return _giftContentView;
//}

@end
