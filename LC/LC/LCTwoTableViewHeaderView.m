//
//  LCTwoTableViewHeaderView.m
//  LC
//
//  Created by JustBill on 16/5/19.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import "LCTwoTableViewHeaderView.h"

@implementation LCTwoTableViewHeaderView

- (void)awakeFromNib
{
    self.contentView.backgroundColor = [UIColor colorWithRed:34.0/255.0 green:36.0/255.0 blue:38.0/255.0 alpha:1];
}

- (void)setDateStr:(NSString *)dateStr
{
    _dateStr = dateStr;
    
    _dateLabel.text = dateStr;
    _dateLabel.font = [UIFont fontWithName:@"gotham_book" size:5];
}


@end
