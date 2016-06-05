//
//  AppDelegate.m
//  LC
//
//  Created by JustBill on 16/5/17.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import "AppDelegate.h"
#import "LCTabBarController.h"
#import "UMSocial.h"
#import "UMSocialSinaSSOHandler.h"
#import "UMSocialQQHandler.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor blackColor];
    [self.window makeKeyAndVisible];
    
    //设置友盟社会化组件appkey
    [UMSocialData setAppKey:@"575044c8e0f55a2c460015d5"];
    //设置微信AppId、appSecret，分享url
    //[UMSocialWechatHandler setWXAppId:@"wxd930ea5d5a258f4f" appSecret:@"db426a9829e4b49a0dcac7b4162da6b6" url:@"http://www.umeng.com/social"];
    //设置手机QQ 的AppId，Appkey，和分享URL，需要#import "UMSocialQQHandler.h"
    [UMSocialQQHandler setQQWithAppId:@"1105373777" appKey:@"mCrJCJsKEiAOVvSp" url:@"http://www.umeng.com/social"];
    //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。需要 #import "UMSocialSinaSSOHandler.h"
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"604424628"
                                              secret:@"914fc2494844313bd238d12412b4f3c7"
                                         RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
    self.window.rootViewController = [[LCTabBarController alloc] init];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        BOOL result = [UMSocialSnsService handleOpenURL:url];
        if (result == FALSE) {
            //调用其他SDK，例如支付宝SDK等
        }
    }
     
    
    return result;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
