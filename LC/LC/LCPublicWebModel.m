//
//  LCPublicWebModel.m
//  LC
//
//  Created by JustBill on 16/6/3.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import "LCPublicWebModel.h"

@implementation LCPublicWebModel

- (NSString *)description
{
    return [NSString stringWithFormat:@"imageUrl = %@ , webUrl = %@ , title = %@", _imageUrl,_webUrl,_title];
}

@end
