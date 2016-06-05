//
//  LCFourModel.h
//  LC
//
//  Created by JustBill on 16/5/24.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCFourModel : NSObject

@property (nonatomic ,copy)NSString *user_id;
@property (nonatomic ,copy)NSString *user_name;
@property (nonatomic ,copy)NSString *is_daren;
@property (nonatomic ,copy)NSString *user_image;
@property (nonatomic ,copy)NSString *user_desc;

+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary;

@end
