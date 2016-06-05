//
//  LCShopShowModel.h
//  LC
//
//  Created by JustBill on 16/5/26.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCShopShowModel : NSObject

//商品的id，通过这个获得商品的详细信息
@property (nonatomic ,copy)NSString *goods_id;

//图片的url
@property (nonatomic ,copy)NSString *goods_image;

//title
@property (nonatomic ,copy)NSString *goods_name;
@property (nonatomic ,copy)NSString *owner_id;

//喜欢的个数
@property (nonatomic ,copy)NSString *like_count;

//价格
@property (nonatomic ,copy)NSString *price;
@property (nonatomic ,copy)NSString *sale_by;
@property (nonatomic ,copy)NSString *comment_count;

//商品链接
@property (nonatomic ,copy)NSString *goods_url;

@property (nonatomic ,copy)NSString *brand_name;

+ (instancetype)modelWithDictionary:(NSDictionary *)dict;

@end
