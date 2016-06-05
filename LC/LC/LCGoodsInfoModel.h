//
//  LCGoodsInfoModel.h
//  LC
//
//  Created by JustBill on 16/5/31.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCGoodsInfoModel : NSObject

@property (nonatomic ,copy)NSString *goods_image;

@property (nonatomic ,copy)NSString *goods_name;

@property (nonatomic ,copy)NSString *goods_desc;

@property (nonatomic ,copy)NSString *price;

@property (nonatomic ,copy)NSString *like_count;

@property (nonatomic ,copy)NSString *rec_reason;

//brand_info里面的品牌信息
@property (nonatomic ,copy)NSNumber *brand_id;

@property (nonatomic ,copy)NSString *brand_name;

@property (nonatomic ,copy)NSString *brand_desc;

@property (nonatomic ,copy)NSString *brand_logo;
/////////////////////
//attrList里面的信息
@property (nonatomic ,copy)NSString *type_name;

@property (nonatomic ,strong)NSMutableArray *attrList;

//good_guide里面的信息
@property (nonatomic ,copy)NSString *title;
@property (nonatomic ,copy)NSString *content;

//images_item图片展示信息
@property (nonatomic ,strong)NSMutableArray *images_item;

//sku_inv里面的信息
@property (nonatomic ,strong)NSMutableArray *sku_inv;

@property (nonatomic ,assign)BOOL shopInfoBtnSelect;
@property (nonatomic ,assign)BOOL guideInfoBtnSelect;

+ (instancetype)modelWithBaseDictionary:(NSDictionary *)dict;

@end
