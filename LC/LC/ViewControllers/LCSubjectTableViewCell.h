//
//  LCSubjectTableViewCell.h
//  LC
//
//  Created by JustBill on 16/5/18.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCSubjectModel.h"

@interface LCSubjectTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *topicNameLabel;

@property (nonatomic ,strong)LCSubjectModel *model;

@end
