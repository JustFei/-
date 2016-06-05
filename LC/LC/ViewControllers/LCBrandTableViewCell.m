//
//  LCBrandTableViewCell.m
//  LC
//
//  Created by JustBill on 16/5/17.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import "LCBrandTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation LCBrandTableViewCell

-(void)setModel:(LCBrandModel *)model
{
    [_imgView sd_setImageWithURL:[NSURL URLWithString:model.url]];
    _descriptionLabel.text = model.name;
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
