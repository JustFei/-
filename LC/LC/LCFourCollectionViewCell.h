//
//  LCFourCollectionViewCell.h
//  LC
//
//  Created by JustBill on 16/5/24.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCFourModel.h"

@interface LCFourCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptLabel;

@property (nonatomic ,strong)LCFourModel *model;

@end
