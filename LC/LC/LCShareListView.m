//
//  LCShareListView.m
//  LC
//
//  Created by JustBill on 16/6/3.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import "LCShareListView.h"
#import "UMSocial.h"
#import "UMSocialData.h"
#import "UMSocialDataService.h"
#import "UMSocialSnsPlatformManager.h"

@implementation LCShareListView

- (void)setModel:(LCPublicWebModel *)model
{
    _model = model;
    NSLog(@"%@",model);
}

//qq分享
- (IBAction)qqShareButtonClick:(UIButton *)sender {
    
    UIViewController *vc = [self viewController];
    
    //这里是QQ分享
    //这里是分享后点开的web链接
        [UMSocialData defaultData].extConfig.qqData.url = _model.webUrl;
        //这里是分享后的标题
        [UMSocialData defaultData].extConfig.qqData.title = [NSString stringWithFormat:@"%@👉：",_model.title];
        //这里是分享后显示的图片
        UMSocialUrlResource *urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:
                                            _model.imageUrl];
    
        [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQQ] content:[NSString stringWithFormat:@"%@👉：%@",_model.title,_model.webUrl] image:nil location:nil urlResource:urlResource presentedController:vc completion:^(UMSocialResponseEntity *shareResponse){
            if (shareResponse.responseCode == UMSResponseCodeSuccess) {
                NSLog(@"分享成功！");
            }
        }];
    self.frame = CGRectMake(0, vc.view.frame.size.height, vc.view.frame.size.width, 90);
}

//sina微博
- (IBAction)sinaWeiboShareButtonClick:(UIButton *)sender {
    
    UIViewController *vc = [self viewController];
    NSLog(@"%@",vc.class);
     //这里是sina的分享
     //直接发送到对应的平台,仅支持分享到一个平台，可以传入文字、图片、地理位置、url资源。图片、地理位置和url资源可以设为nil。
     //需要自定义面板样式的开发者需要自己绘制UI，在对应的分享按钮中调用此接口
     //分享的title
     [UMSocialData defaultData].extConfig.title = @"DJ良品";
     //分享的图片
     UMSocialUrlResource *urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:
     _model.imageUrl];
     
     //content:分享的文字,这里由于新浪微博不支持直接分享web链接，所以是能将web类型的链接拼接到分享的文字后面，在微博上回显示一个可供点击的链接。
     //image:分享的图片
     //location:分享地理位置
     //URLResource:分享链接
     [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToSina] content:[NSString stringWithFormat:@"%@👉：%@",_model.title,_model.webUrl] image:nil location:nil urlResource:urlResource presentedController:vc completion:^(UMSocialResponseEntity *shareResponse){
     if (shareResponse.responseCode == UMSResponseCodeSuccess) {
     NSLog(@"分享成功！");
     }
     }];
    
     self.frame = CGRectMake(0, vc.view.frame.size.height, vc.view.frame.size.width, 90);
    
}
/*
- (IBAction)doubanShareButtonClick:(UIButton *)sender {
}
- (IBAction)wechatShareButtonClick:(UIButton *)sender {
}
 */

- (UIViewController *)viewController
{
    for (UIView* next = [self superview]; next; next = next.superview)
    {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

@end
