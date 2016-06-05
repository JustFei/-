//
//  LCTwoAuthorModel.m
//  LC
//
//  Created by JustBill on 16/5/21.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import "LCTwoAuthorModel.h"

@implementation LCTwoAuthorModel

+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary
{
    LCTwoAuthorModel *model = [[LCTwoAuthorModel alloc] init];
    
    model.author_id = dictionary[@"author_id"];
    model.author_name = dictionary[@"author_name"];
    model.thumb = dictionary[@"thumb"];
    model.note = dictionary[@"note"];
    
    return model;
}

@end
