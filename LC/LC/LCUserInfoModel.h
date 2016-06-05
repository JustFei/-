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

//@property (nonatomic ,copy)NSString *thirdPlatformUserProfile;

//@property (nonatomic ,copy)NSString *thirdPlatformResponse;

//@property (nonatomic ,copy)NSString *message;

@end
