//
//  LCGiftContentView.m
//  LC
//
//  Created by JustBill on 16/5/24.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import "LCGiftContentView.h"

@implementation LCGiftContentView

- (IBAction)buttonClickAction:(UIButton *)sender {
    NSString *tag = [NSString stringWithFormat:@"%ld",sender.tag];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"giftContentViewPushPublicShopShowView" object:tag];
}



@end
