//
//  LCTwoAuthorTableViewCell.h
//  LC
//
//  Created by JustBill on 16/5/21.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCTwoAuthorModel.h"

@interface LCTwoAuthorTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@property (nonatomic ,strong) LCTwoAuthorModel *model;

@end
