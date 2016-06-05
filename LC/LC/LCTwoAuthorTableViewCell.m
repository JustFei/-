//
//  LCTwoAuthorTableViewCell.m
//  LC
//
//  Created by JustBill on 16/5/21.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import "LCTwoAuthorTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation LCTwoAuthorTableViewCell

#pragma mark - setter
- (void)setModel:(LCTwoAuthorModel *)model
{
    _model = model;
    
    [self.headImgView sd_setImageWithURL:[NSURL URLWithString:model.thumb]];
    self.nameLabel.text = model.author_name;
    self.descriptionLabel.text = model.note;
    
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
