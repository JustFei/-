//
//  LCTwoTableViewCell.h
//  LC
//
//  Created by JustBill on 16/5/19.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCinfosModel.h"

@interface LCTwoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *topic_nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorAndCatLabel;

@property (nonatomic ,strong) LCinfosModel *model;

@end
