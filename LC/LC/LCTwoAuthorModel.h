//
//  LCTwoAuthorModel.h
//  LC
//
//  Created by JustBill on 16/5/21.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCTwoAuthorModel : NSObject

@property (nonatomic ,copy)NSString *author_id;
@property (nonatomic ,copy)NSString *author_name;
@property (nonatomic ,copy)NSString *thumb;
@property (nonatomic ,copy)NSString *note;


+ (instancetype)modelWithDictionary: (NSDictionary *)dictionary;

@end
