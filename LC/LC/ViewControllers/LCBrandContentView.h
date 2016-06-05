//
//  LCBrandContentView.h
//  LC
//
//  Created by JustBill on 16/5/17.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import <UIKit/UIKit.h>

//下拉刷新回调
typedef void(^LCBrandContentStratRefreshControlCallBack)(void);

//上拉加载更多
typedef void(^LCBrandContentLoadingMoerCallBack)(void);

@interface LCBrandContentView : UIView

@property (nonatomic ,strong)NSArray *dataArr;

- (void)setLCBrandContentStratRefreshControlCallBack:(LCBrandContentStratRefreshControlCallBack)callback;

- (void)setLCBrandContentLoadingMoerCallBack:(LCBrandContentLoadingMoerCallBack)callback;

- (void)stopRefresh;

@end
