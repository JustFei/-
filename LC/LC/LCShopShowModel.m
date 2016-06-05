//
//  LCShopShowModel.m
//  LC
//
//  Created by JustBill on 16/5/26.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import "LCShopShowModel.h"

@implementation LCShopShowModel

+ (instancetype)modelWithDictionary:(NSDictionary *)dict
{
    LCShopShowModel *model = [[LCShopShowModel alloc] init];
    
    model.goods_id = dict[@"goods_id"];
    model.goods_image = dict[@"goods_image"];
    model.goods_name = dict[@"goods_name"];
    model.owner_id = dict[@"owner_id"];
    model.like_count = dict[@"like_count"];
    model.price = dict[@"price"];
    model.sale_by = dict[@"sale_by"];
    model.comment_count = dict[@"comment_count"];
    model.goods_url = dict[@"goods_url"];
    
    return model;
}

@end
