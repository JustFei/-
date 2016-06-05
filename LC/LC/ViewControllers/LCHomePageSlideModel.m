//
//  LCHomePageSlideModel.m
//  LC
//
//  Created by JustBill on 16/5/25.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import "LCHomePageSlideModel.h"

@implementation LCHomePageSlideModel

+ (instancetype)modelWithDictionary:(NSDictionary *)dict
{
    LCHomePageSlideModel *model = [[LCHomePageSlideModel alloc] init];
    
    model.slide_id = dict[@"slide_id"];
    model.content_type = dict[@"content_type"];
    model.content_id = dict[@"content_id"];
    model.pic_url = dict[@"pic_url"];
    model.order_num = dict[@"order_num"];
    model.topic_name = dict[@"topic_name"];
    model.topic_url = dict[@"topic_url"];
    
    return model;
}

@end
