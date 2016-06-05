//
//  LCFourModel.m
//  LC
//
//  Created by JustBill on 16/5/24.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import "LCFourModel.h"

@implementation LCFourModel

+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary
{
    LCFourModel *model = [[LCFourModel alloc] init];
    
    model.user_id = dictionary[@"user_id"];
    model.user_name = dictionary[@"user_name"];
    model.is_daren = dictionary[@"is_daren"];
    model.user_image = dictionary[@"user_image"];
    model.user_desc = dictionary[@"user_desc"];
    
    return model;
}

@end
