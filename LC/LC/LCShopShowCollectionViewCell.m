//
//  LCShopShowCollectionViewCell.m
//  LC
//
//  Created by JustBill on 16/5/26.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import "LCShopShowCollectionViewCell.h"

@implementation LCShopShowCollectionViewCell

#pragma mark - setter
- (void)setModel:(LCShopShowModel *)model
{
    _model = model;
    
    [_imgView sd_setImageWithURL:[NSURL URLWithString:model.goods_image]];
    _titleLabel.text = model.goods_name;
    _nameLabel.text = model.brand_name;
    _priceLabel.text = [NSString stringWithFormat:@"￥%@",model.price];
    _likeLabel.text = model.like_count;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
