//
//  LCBrandShowModel.h
//  LC
//
//  Created by JustBill on 16/5/28.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCBrandShowModel : NSObject

//商品的id，通过这个来获取商品的详细信息
@property (nonatomic ,copy)NSString *goods_id;

@property (nonatomic ,copy)NSString *goods_image;

@property (nonatomic ,copy)NSString *goods_name;

@property (nonatomic ,copy)NSString *like_count;

@property (nonatomic ,copy)NSString *price;

@property (nonatomic ,copy)NSString *goods_url;

//brand_info
@property (nonatomic ,copy)NSString *brand_name;

@property (nonatomic ,copy)NSString *brand_logo;

@property (nonatomic ,copy)NSString *brand_desc;

+ (instancetype)modelWithDictionary:(NSDictionary *)dict;

@end
