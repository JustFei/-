//
//  LCHomePageViewController.h
//  LC
//
//  Created by JustBill on 16/5/17.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HomePageShopShowCallBack)(NSString *);

@interface LCHomePageViewController : UIViewController

- (void)setHomePageShopShowCallBack:(HomePageShopShowCallBack)callback;

@end
