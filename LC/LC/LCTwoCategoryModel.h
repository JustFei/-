//
//  LCTwoCategoryModel.h
//  LC
//
//  Created by JustBill on 16/5/21.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCTwoCategoryModel : NSObject

@property (nonatomic ,copy)NSString *cat_id;
@property (nonatomic ,copy)NSString *cat_name;
@property (nonatomic ,copy)NSString *thumb;
//@property (nonatomic ,assign)BOOL isShowIcon;

+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary;

@end
