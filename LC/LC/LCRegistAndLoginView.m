//
//  LCRegistAndLoginView.m
//  LC
//
//  Created by JustBill on 16/6/2.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import "LCRegistAndLoginView.h"
#import "UMSocial.h"
#import "LCUserInfoModel.h"

#define kScreenBounds [UIScreen mainScreen].bounds

@interface LCRegistAndLoginView ()
{
    SinaUserInfoCallBcak _sinaUserInfoCallBcak;
    QQUserInfoCallBack _qqUserInfoCallBack;
}
@end

@implementation LCRegistAndLoginView

- (void)setSinaUserInfoCallBack:(SinaUserInfoCallBcak)callback
{
    _sinaUserInfoCallBcak = callback;
}

- (void)setQQUserInfoCallBack:(QQUserInfoCallBack)callback
{
    _qqUserInfoCallBack = callback;
}


- (IBAction)backToMeButtonClick:(UIButton *)sender {
    
    [UIView animateWithDuration:0.2 animations:^{
        self.frame = CGRectMake(0, kScreenBounds.size.height, kScreenBounds.size.width, kScreenBounds.size.height);
    }];    
}
/*
- (IBAction)registButtonClick:(UIButton *)sender {
}
- (IBAction)loginButtonClick:(UIButton *)sender {
}
*/
- (IBAction)qqButtonClick:(UIButton *)sender {
    
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
    
    snsPlatform.loginClickHandler([self viewController],[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        //          获取微博用户名、uid、token等
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            NSDictionary *dict = [UMSocialAccountManager socialAccountDictionary];
            //NSLog(@"%@",dict);
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:snsPlatform.platformName];
            NSLog(@"\nusername = %@,\n usid = %@,\n token = %@ iconUrl = %@,\n unionId = %@,\n thirdPlatformUserProfile = %@,\n thirdPlatformResponse = %@ \n, message = %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL, snsAccount.unionId, response.thirdPlatformUserProfile, response.thirdPlatformResponse, response.message);
            
            LCUserInfoModel *model = [[LCUserInfoModel alloc] init];
            model.username = snsAccount.userName;
            model.usid = snsAccount.usid;
            model.accessToken = snsAccount.accessToken;
            model.iconUrl = snsAccount.iconURL;
            model.unionId = snsAccount.unionId;
//            model.thirdPlatformUserProfile = response.thirdPlatformUserProfile;
//            model.thirdPlatformResponse = response.thirdPlatformResponse;
            //model.message = response.message;
            
            if (_qqUserInfoCallBack) {
                _qqUserInfoCallBack(model);
            }
            
        }});
    
    //这里可以将登陆视图收起，但是没有动画
    [UIView animateWithDuration:0.2 animations:^{
        self.frame = CGRectMake(0, kScreenBounds.size.height, kScreenBounds.size.width, kScreenBounds.size.height);
    }];
    
}

//新浪微博的登录按钮
- (IBAction)sinaButtonClick:(UIButton *)sender {
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
    
    snsPlatform.loginClickHandler([self viewController],[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        //获取微博用户名、uid、token等
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            NSDictionary *dict = [UMSocialAccountManager socialAccountDictionary];
            //snsAccount里面就包含了新浪微博用户的nusername；usid；token；iconUrl；unionId；thirdPlatformUserProfile；thirdPlatformResponse；message;
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:snsPlatform.platformName];
            NSLog(@"\nusername = %@,\n usid = %@,\n token = %@ iconUrl = %@,\n unionId = %@,\n thirdPlatformUserProfile = %@,\n thirdPlatformResponse = %@ \n, message = %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL, snsAccount.unionId, response.thirdPlatformUserProfile, response.thirdPlatformResponse, response.message);
            
            //将得到的用户信息存储到数据库，然后给我的账户信息页添加上数据
            LCUserInfoModel *model = [[LCUserInfoModel alloc] init];
            model.username = snsAccount.userName;
            model.usid = snsAccount.usid;
            model.accessToken = snsAccount.accessToken;
            model.iconUrl = snsAccount.iconURL;
            model.unionId = snsAccount.unionId;
            //model.thirdPlatformUserProfile = response.thirdPlatformUserProfile;
            //model.thirdPlatformResponse = response.thirdPlatformResponse;
            //model.message = response.message;
            
            if (_sinaUserInfoCallBcak) {
                _sinaUserInfoCallBcak(model);
            }
            
            //这里可以将登陆视图收起，但是没有动画
            [UIView animateWithDuration:0.2 animations:^{
                self.frame = CGRectMake(0, kScreenBounds.size.height, kScreenBounds.size.width, kScreenBounds.size.height);
            }];
            
        }});
    
    
}
/*
- (IBAction)doubanButtonClick:(UIButton *)sender {
}
- (IBAction)weixinButtonClick:(UIButton *)sender {
}
 */


//一直遍历视图的父视图,找他的响应者.如果响应者是视图控制器,则返回它.
- (UITabBarController *)viewController
{
    for (UIView* next = [self superview]; next; next = next.superview)
    {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
            return (UITabBarController *)nextResponder;
        }
    }
    return nil;
}


@end
