//
//  LCTwoCategoryModel.m
//  LC
//
//  Created by JustBill on 16/5/21.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import "LCTwoCategoryModel.h"

@implementation LCTwoCategoryModel

+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary
{
    
    LCTwoCategoryModel *model = [[LCTwoCategoryModel alloc] init];
    
    model.cat_id = dictionary[@"cat_id"];
    model.cat_name = dictionary[@"cat_name"];
    model.thumb = dictionary[@"thumb"];
    
    return model;
}

@end
