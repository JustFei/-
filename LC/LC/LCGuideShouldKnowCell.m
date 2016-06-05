//
//  LCGuideShouldKnowCell.m
//  LC
//
//  Created by JustBill on 16/6/1.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import "LCGuideShouldKnowCell.h"

@implementation LCGuideShouldKnowCell

- (void)setGuideInfoStr:(NSString *)guideInfoStr
{
    _guideInfoStr = guideInfoStr;
    
    _guideInfoLabel.text = guideInfoStr;
    [self sizetifit:_guideInfoLabel];
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
