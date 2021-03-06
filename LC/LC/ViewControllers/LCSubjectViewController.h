//
//  LCSubjectViewController.h
//  LC
//
//  Created by JustBill on 16/5/17.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCPublicWebModel.h"

typedef void(^SubjectCallBack)(LCPublicWebModel *model);

@interface LCSubjectViewController : UIViewController

- (void)setSubjectCallBack:(SubjectCallBack) callback;

@end
