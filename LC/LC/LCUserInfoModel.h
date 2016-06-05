//
//  LCUserInfoModel.h
//  LC
//
//  Created by JustBill on 16/6/3.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCUserInfoModel : NSObject

@property (nonatomic ,copy)NSString *username;

@property (nonatomic ,copy)NSString *usid;

@property (nonatomic ,copy)NSString *accessToken;

@property (nonatomic ,copy)NSString *iconUrl;

@property (nonatomic ,copy)NSString *unionId;

//这下面的三个返回的信息并不是字符串，貌似是字典
//@property (nonatomic ,copy)NSString *thirdPlatformUserProfile;

//@property (nonatomic ,copy)NSString *thirdPlatformResponse;

//@property (nonatomic ,copy)NSString *message;

@end
