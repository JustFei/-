//
//  LCBrandModel.h
//  LC
//
//  Created by JustBill on 16/5/17.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCBrandModel : NSObject

@property (nonatomic ,copy)NSString *url;

@property (nonatomic ,copy)NSString *Description;

@property (nonatomic ,copy)NSString *name;

@property (nonatomic ,copy)NSNumber *Id;

+ (instancetype)modelWithDictionary:(NSDictionary *)dic;

@end
