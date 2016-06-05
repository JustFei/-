//
//  LCGoodsInfoTableViewCell.h
//  LC
//
//  Created by JustBill on 16/6/1.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCGoodsInfoModel.h"

@interface LCGoodsInfoTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *goods_descLabel;
@property (weak, nonatomic) IBOutlet UILabel *brandNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *brand_descLabel;
@property (weak, nonatomic) IBOutlet UIImageView *lcHeadImgView;
@property (weak, nonatomic) IBOutlet UILabel *rec_reasonLabel;

@property (nonatomic ,strong) LCGoodsInfoModel *model;
@end
