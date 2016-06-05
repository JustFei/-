//
//  LCRegistAndLoginView.h
//  LC
//
//  Created by JustBill on 16/6/2.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCUserInfoModel.h"

typedef void(^SinaUserInfoCallBcak)(LCUserInfoModel *);
typedef void(^QQUserInfoCallBack)(LCUserInfoModel *);

@interface LCRegistAndLoginView : UIView

- (void)setSinaUserInfoCallBack:(SinaUserInfoCallBcak )callback;
- (void)setQQUserInfoCallBack:(QQUserInfoCallBack )callback;

@end
