//
//  LCTwoTableViewCell.m
//  LC
//
//  Created by JustBill on 16/5/19.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import "LCTwoTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation LCTwoTableViewCell

#pragma mark - setter
- (void)setModel:(LCinfosModel *)model
{
    _model = model;
    [_imgView sd_setImageWithURL:[NSURL URLWithString:model.cover_img] placeholderImage:nil];
    _topic_nameLabel.text = model.topic_name;
    _authorAndCatLabel.text = [NSString stringWithFormat:@"#%@  ·  作者：%@",model.cat_name, model.author_name];
    
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
