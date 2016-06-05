//
//  LCGoodsInfo.h
//  LC
//
//  Created by JustBill on 16/5/31.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCGoodsInfoModel.h"

typedef void(^ShowShopInfo)();
typedef void(^ShowGuideInfo)();

@interface LCGoodsInfo : UIView
@property (weak, nonatomic) IBOutlet UIScrollView *headScrollView;
@property (weak, nonatomic) IBOutlet UILabel *brandNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (weak, nonatomic) IBOutlet UILabel *likeContentLabel;
@property (weak, nonatomic) IBOutlet UILabel *skuInfoLabel;
@property (weak, nonatomic) IBOutlet UIImageView *brandHeadImg;
@property (weak, nonatomic) IBOutlet UILabel *brandInfoLabel;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIButton *shopInfoBtn;
@property (weak, nonatomic) IBOutlet UIButton *guideInfoBtn;

@property (nonatomic ,strong)LCGoodsInfoModel *dataModel;

- (void)setShowShopInfo:(ShowShopInfo)callback;
- (void)setShowGuideInfo:(ShowGuideInfo)callback;

@end
