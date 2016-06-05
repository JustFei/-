//
//  LCSku_invModel.h
//  LC
//
//  Created by JustBill on 16/5/31.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCSku_invModel : NSObject

@property (nonatomic ,copy)NSString *attr_keys;

@property (nonatomic ,copy)NSString *price;

@property (nonatomic ,copy)NSString *discount_price;

@property (nonatomic ,copy)NSString *amount;

+ (instancetype)modelWithDictionary:(NSDictionary *)dict;

@end
