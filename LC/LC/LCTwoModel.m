//
//  LCTwoModel.m
//  LC
//
//  Created by JustBill on 16/5/19.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import "LCTwoModel.h"

@implementation LCTwoModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dicModel = [NSMutableArray array];
        _keys = [NSArray array];
    }
    return self;
}

- (void)removeAllObject
{
    _keys = nil;
    [_dicModel removeAllObjects];
}

@end
