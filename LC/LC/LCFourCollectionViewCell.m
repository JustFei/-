//
//  LCFourCollectionViewCell.m
//  LC
//
//  Created by JustBill on 16/5/24.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import "LCFourCollectionViewCell.h"

@implementation LCFourCollectionViewCell

- (void)setModel:(LCFourModel *)model
{
    _model = model;
    [_imgView sd_setImageWithURL:[NSURL URLWithString:model.user_image]];
    _nameLabel.text = model.user_name;
    _descriptLabel.text = model.user_desc;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
