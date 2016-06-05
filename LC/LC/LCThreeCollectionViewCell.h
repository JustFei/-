//
//  LCThreeCollectionViewCell.h
//  LC
//
//  Created by JustBill on 16/5/24.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCThreeModel.h"

@interface LCThreeCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *threeImgView;

@property (nonatomic ,strong)LCThreeModel *model;

@end
