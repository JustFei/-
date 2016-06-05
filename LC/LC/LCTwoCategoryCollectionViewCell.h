//
//  LCTwoCategoryCollectionViewCell.h
//  LC
//
//  Created by JustBill on 16/5/20.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCTwoCategoryModel.h"

@interface LCTwoCategoryCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;

@property (nonatomic ,strong)LCTwoCategoryModel *model;

@end
