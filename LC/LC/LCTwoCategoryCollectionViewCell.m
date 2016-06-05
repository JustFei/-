//
//  LCTwoCategoryCollectionViewCell.m
//  LC
//
//  Created by JustBill on 16/5/20.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import "LCTwoCategoryCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@implementation LCTwoCategoryCollectionViewCell

#pragma mark - setter
- (void)setModel:(LCTwoCategoryModel *)model
{
    _model = model;
    
    [_imgView sd_setImageWithURL:[NSURL URLWithString:model.thumb]];
    _titleLabel.text = model.cat_name;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
