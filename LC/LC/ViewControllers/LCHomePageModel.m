//
//  LCHomePageModel.m
//  LC
//
//  Created by JustBill on 16/5/19.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import "LCHomePageModel.h"

@implementation LCHomePageModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _slideArr = [NSMutableArray array];
        _listArr = [NSMutableArray array];
    }
    return self;
}

@end
