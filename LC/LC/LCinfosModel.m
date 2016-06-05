//
//  LCinfosModel.m
//  LC
//
//  Created by JustBill on 16/5/19.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import "LCinfosModel.h"

@implementation LCinfosModel

- (NSString *)description
{
    return [NSString stringWithFormat:@"1.%@,2.%@,3.%@,4.%@,5.%@", _topic_url,_cat_name,_cover_img,_topic_name,_author_name];
}

@end
