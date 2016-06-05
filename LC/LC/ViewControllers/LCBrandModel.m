//
//  LCBrandModel.m
//  LC
//
//  Created by JustBill on 16/5/17.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import "LCBrandModel.h"

@implementation LCBrandModel

+ (instancetype)modelWithDictionary:(NSDictionary *)dic
{
    LCBrandModel *model = [[LCBrandModel alloc] init];
    
    model.Description = dic[@"description"];
    model.name = dic[@"name"];
    model.Id = dic[@"id"];
    
    return model;
}

@end
