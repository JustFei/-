//
//  LCFourContentView.h
//  LC
//
//  Created by JustBill on 16/5/24.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import <UIKit/UIKit.h>

//下拉刷新回调
typedef void(^LCFourContentStratRefreshControlCallBack)(void);

//上拉加载更多
typedef void(^LCFourContentLoadingMoerCallBack)(void);

@interface LCFourContentView : UIView

@property (nonatomic ,strong)NSArray *modelArr;

- (void)setLCFourContentStratRefreshControlCallBack:(LCFourContentStratRefreshControlCallBack)callback;

- (void)setLCFourContentLoadingMoerCallBack:(LCFourContentLoadingMoerCallBack)callback;

- (void)stopRefresh;

@end
