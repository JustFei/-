//
//  LCThreeModel.m
//  LC
//
//  Created by JustBill on 16/5/24.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import "LCThreeModel.h"

@implementation LCThreeModel

+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary
{
    
    LCThreeModel *model = [[LCThreeModel alloc] init];
    
    model.goods_image = dictionary[@"goods_image"];
    model.goods_url = dictionary[@"goods_url"];
    
    return model;
}

@end
