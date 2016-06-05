//
//  LCGoodsInfoModel.m
//  LC
//
//  Created by JustBill on 16/5/31.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import "LCGoodsInfoModel.h"

@implementation LCGoodsInfoModel

+ (instancetype)modelWithBaseDictionary:(NSDictionary *)dict
{
    LCGoodsInfoModel *model = [[LCGoodsInfoModel alloc] init];
    
    model.goods_image = dict[@"goods_image"];
    model.goods_name = dict[@"goods_name"];
    model.goods_desc = dict[@"goods_desc"];
    model.price = dict[@"price"];
    model.like_count = dict[@"like_count"];
    model.rec_reason = dict[@"rec_reason"];
    
    model.attrList = [NSMutableArray array];
    model.images_item = [NSMutableArray array];
    model.sku_inv = [NSMutableArray array];
    
    return model;
}

@end
