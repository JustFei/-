//
//  LCTwoContentView.h
//  LC
//
//  Created by JustBill on 16/5/19.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCTwoModel.h"
#import "LCinfosModel.h"
#import "YCSegmentView.h"

//隐藏tabBar的回调
typedef void(^LCTwoContentViewHideTabBarCallBack)(void);

//显示tabBar的回调
typedef void(^LCTwoContentViewShowTabBarCallBack)(void);

//点击cell的回调
typedef void(^LCTwoContentViewTableViewCellSelectCallBack)(NSIndexPath *index);

@interface LCTwoContentView : UIView

@property (nonatomic ,strong)LCTwoModel *model;

@property (nonatomic ,weak)YCSegmentView *upView;

@property (nonatomic ,weak)UIView *navigationbarView;

@property (nonatomic ,weak)UITableView *twoTableView;

@property (nonatomic ,weak)UILabel *naviTitleLabel;

- (void)showAllView;

- (void)setLCTwoContentViewTableViewCellSelectCallBack:(LCTwoContentViewTableViewCellSelectCallBack )callback;


- (void)setLCTwoContentViewHideTabBarCallBack: (LCTwoContentViewHideTabBarCallBack)callback;

- (void)setLCTwoContentViewShowTabBarCallBack: (LCTwoContentViewShowTabBarCallBack)callback;
@end
