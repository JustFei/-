//
//  LCAttrListModel.m
//  LC
//
//  Created by JustBill on 16/5/31.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import "LCAttrListModel.h"

@implementation LCAttrListModel

+ (instancetype)modelWithDictionary:(NSDictionary *)dict
{
    LCAttrListModel *model = [[LCAttrListModel alloc] init];
    
    model.attr_id = dict[@"attr_id"];
    model.attr_name = dict[@"attr_name"];
    model.img_path = dict[@"img_path"];
    
    return model;
}

@end
