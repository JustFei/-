//
//  LCPublicWebContentView.h
//  LC
//
//  Created by JustBill on 16/5/18.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCPublicWebModel.h"

@interface LCPublicWebContentView : UIView

//- (instancetype)initWithWebUrl:(NSString *)webUrl imageUrl:(NSString *)imageUrl;

@property (nonatomic ,strong) LCPublicWebModel *model;

@end
