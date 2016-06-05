//
//  LCAttrListModel.h
//  LC
//
//  Created by JustBill on 16/5/31.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCAttrListModel : NSObject

@property (nonatomic ,copy)NSString *attr_id;

@property (nonatomic ,copy)NSString *attr_name;

@property (nonatomic ,copy)NSString *img_path;

+ (instancetype)modelWithDictionary:(NSDictionary *)dict;

@end
