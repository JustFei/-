//
//  LCTwoCategoryViewController.h
//  LC
//
//  Created by JustBill on 16/5/20.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TwoCategoryControllerCellClickCallBack)(NSInteger);

@interface LCTwoCategoryViewController : UIViewController

- (void)setTwoCategoryControllerCellClickCallBack: (TwoCategoryControllerCellClickCallBack)callback;

@end
