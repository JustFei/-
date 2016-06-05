//
//  LCShopShowContentView.h
//  LC
//
//  Created by JustBill on 16/5/26.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import <UIKit/UIKit.h>

////这里是点击button回调push到商品列表页面
//typedef void(^ShopShowViewBackButtonClickCallBack)(void);

//下拉刷新回调
typedef void(^LCShopShowStratRefreshControlCallBack)(void);

//上拉加载更多
typedef void(^LCShopShowLoadingMoerCallBack)(void);

@interface LCShopShowContentView : UIView

@property (nonatomic ,strong)NSArray *modelArr;

//- (void)setShopShowViewBackButtonClickCallBack: (ShopShowViewBackButtonClickCallBack)callback;

- (void)setLCShopShowStratRefreshControlCallBack:(LCShopShowStratRefreshControlCallBack)callback;

- (void)setShopShowLoadingMoerCallBack:(LCShopShowLoadingMoerCallBack)callback;

- (void)stopRefresh;


@end
