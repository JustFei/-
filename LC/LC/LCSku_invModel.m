//
//  LCSku_invModel.m
//  LC
//
//  Created by JustBill on 16/5/31.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import "LCSku_invModel.h"

@implementation LCSku_invModel

+ (instancetype)modelWithDictionary:(NSDictionary *)dict
{
    LCSku_invModel *model = [[LCSku_invModel alloc] init];
    
    model.attr_keys = dict[@"attr_keys"];
    model.price = dict[@"price"];
    model.discount_price = dict[@"discount_price"];
    model.amount = dict[@"amount"];
    
    return model;
}

@end
