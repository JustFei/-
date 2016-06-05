//
//  LCBrandShowModel.m
//  LC
//
//  Created by JustBill on 16/5/28.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import "LCBrandShowModel.h"

@implementation LCBrandShowModel

+ (instancetype)modelWithDictionary:(NSDictionary *)dict
{
    LCBrandShowModel *model = [[LCBrandShowModel alloc] init];
    
    model.goods_id = dict[@"goods_id"];
    model.goods_image = dict[@"goods_image"];
    model.goods_name = dict[@"goods_name"];
    model.like_count = dict[@"like_count"];
    model.price = dict[@"price"];
    model.goods_url = dict[@"goods_url"];
    
    return model;
}


@end
