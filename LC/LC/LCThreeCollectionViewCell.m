//
//  LCThreeCollectionViewCell.m
//  LC
//
//  Created by JustBill on 16/5/24.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import "LCThreeCollectionViewCell.h"

@implementation LCThreeCollectionViewCell

- (void)setModel:(LCThreeModel *)model
{
    _model = model;
    [_threeImgView sd_setImageWithURL:[NSURL URLWithString:model.goods_image]];
    _threeImgView.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
