//
//  LCThreeModel.h
//  LC
//
//  Created by JustBill on 16/5/24.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCThreeModel : NSObject

@property (nonatomic ,copy)NSString *goods_image;
@property (nonatomic ,copy)NSString *goods_url;

+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary;

@end
