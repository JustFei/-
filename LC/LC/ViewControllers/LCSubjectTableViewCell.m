//
//  LCSubjectTableViewCell.m
//  LC
//
//  Created by JustBill on 16/5/18.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import "LCSubjectTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation LCSubjectTableViewCell

#pragma mark - setter
- (void)setModel:(LCSubjectModel *)model
{
    //这里设置cell图片加载的等待图片
    [_imgView sd_setImageWithURL:[NSURL URLWithString:model.imgUrl] placeholderImage:nil];
    _topicNameLabel.text = model.nameStr;
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
