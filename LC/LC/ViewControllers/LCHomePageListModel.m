//
//  LCHomePageListModel.m
//  LC
//
//  Created by JustBill on 16/5/25.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import "LCHomePageListModel.h"

@implementation LCHomePageListModel

+ (instancetype)modelWithDictionary:(NSDictionary *)dict
{
    LCHomePageListModel *model = [[LCHomePageListModel alloc] init];
    
    model.home_id = dict[@"home_id"];
    model.content_type = dict[@"content_type"];
    model.content_id = dict[@"content_id"];
    model.pic_url = dict[@"pic_url"];
    model.pos = dict[@"pos"];
    model.topic_name = dict[@"topic_name"];
    model.topic_url = dict[@"topic_url"];
    
    return model;
}

@end
