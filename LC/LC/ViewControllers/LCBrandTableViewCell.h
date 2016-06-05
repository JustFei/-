//
//  LCBrandTableViewCell.h
//  LC
//
//  Created by JustBill on 16/5/17.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCBrandModel.h"

@interface LCBrandTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@property (nonatomic ,strong) LCBrandModel *model;

@end
