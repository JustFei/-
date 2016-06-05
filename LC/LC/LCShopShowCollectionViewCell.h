//
//  LCShopShowCollectionViewCell.h
//  LC
//
//  Created by JustBill on 16/5/26.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCShopShowModel.h"

@interface LCShopShowCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeLabel;

@property (nonatomic ,strong)LCShopShowModel *model;

@end
