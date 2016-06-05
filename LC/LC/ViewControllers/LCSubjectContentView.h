//
//  LCSubjectContentView.h
//  LC
//
//  Created by JustBill on 16/5/18.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import <UIKit/UIKit.h>

//下拉刷新回调
typedef void(^LCSubjectContentStratRefreshControlCallBack)(void);

//传点击的cell的index给Controller
typedef void(^SubjectCellSelectActionCallBack)(NSInteger index);

@interface LCSubjectContentView : UIView

@property (nonatomic ,strong)NSArray *dataArr;

- (void)setSubjectCellSelectActionCallBack:(SubjectCellSelectActionCallBack)callback;

- (void)setLCSubjectContentStratRefreshControlCallBack:(LCSubjectContentStratRefreshControlCallBack)callback;

- (void)stopRefresh;

@end
