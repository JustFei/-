//
//  LCHomePageListModel.h
//  LC
//
//  Created by JustBill on 16/5/25.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCHomePageListModel : NSObject

@property (nonatomic ,copy) NSString *home_id;
@property (nonatomic ,copy) NSString *content_type;
@property (nonatomic ,copy) NSString *content_id;
@property (nonatomic ,copy) NSString *pic_url;
@property (nonatomic ,copy) NSString *pos;
@property (nonatomic ,copy) NSString *topic_name;
@property (nonatomic ,copy) NSString *topic_url;

+ (instancetype)modelWithDictionary: (NSDictionary *)dict;

@end
