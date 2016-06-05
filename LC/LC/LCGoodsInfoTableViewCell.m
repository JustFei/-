//
//  LCGoodsInfoTableViewCell.m
//  LC
//
//  Created by JustBill on 16/6/1.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import "LCGoodsInfoTableViewCell.h"

@implementation LCGoodsInfoTableViewCell

- (void)setModel:(LCGoodsInfoModel *)model
{
    _model = model;
    _goods_descLabel.text = model.goods_desc;
    _brandNameLabel.text = model.brand_name;
    _brand_descLabel.text = model.brand_desc;
    _rec_reasonLabel.text = model.rec_reason;
    _lcHeadImgView.image = [UIImage imageNamed:@"liangcang_recommend_logo"];
    _lcHeadImgView.layer.cornerRadius = _lcHeadImgView.frame.size.width / 2;
    _lcHeadImgView.layer.masksToBounds = YES;
    
    [self sizetifit:_goods_descLabel];
    [self sizetifit:_brand_descLabel];
    [self sizetifit:_rec_reasonLabel];
    
}

- (void)sizetifit:(UILabel *)label
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:label.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:10.0f];//调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [label.text length])];
    label.attributedText = attributedString;
    [label sizeToFit];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
