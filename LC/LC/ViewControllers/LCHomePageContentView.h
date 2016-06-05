//
//  LCHomePageContentView.h
//  LC
//
//  Created by JustBill on 16/5/18.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCHomePageModel.h"

typedef void(^HomePageContentViewButtonClickCallBack)(NSString *);

@interface LCHomePageContentView : UIView

@property (weak, nonatomic) IBOutlet UIScrollView *homePageScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *headScrollView;
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;
@property (weak, nonatomic) IBOutlet UIButton *button5;
@property (weak, nonatomic) IBOutlet UIButton *button6;
@property (weak, nonatomic) IBOutlet UIButton *button7;

@property (nonatomic ,strong)LCHomePageModel *pageModel;

- (void)setHomePageContentViewButtonClickCallBack:(HomePageContentViewButtonClickCallBack)callback;

@end
