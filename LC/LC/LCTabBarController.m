//
//  LCTabBarController.m
//  LC
//
//  Created by JustBill on 16/5/17.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import "LCTabBarController.h"

@interface LCTabBarController ()

@property(nonatomic)  UIEdgeInsets imageInsets;

@end

@implementation LCTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addChildViewControllers];
    
}

- (void)addChildViewControllers
{
    //设置tabbar的背景颜色
    self.tabBar.barTintColor = [UIColor colorWithRed:24.0/255.0 green:25.0/255.0 blue:27.0/255.0 alpha:0];
    //此处代码将tabBar的透明效果取消
    [UITabBar appearance].translucent = NO;
    
    //控制器名字
    NSArray *childControllerNames = @[@"LCOneViewController",@"LCTwoViewController",@"LCThreeViewController",@"LCFourViewController",@"LCFiveViewController"];
    
    NSArray *childControllerTitle = @[@"商店",@"杂志",@"分享",@"达人",@"我的账户"];
    
    //tabBar图片
    NSArray *tabBarNormalImageNames = @[@"tabbar_shop",@"tabbar_special",@"tabbar_perfectware",@"tabbar_activity",@"tabbar_person"];
    //选中时图片
    NSArray *tabBarSelectImageNames = @[@"tabbar_shop_h",@"tabbar_special_h",@"tabbar_perfectware_h",@"tabbar_activity_h",@"tabbar_person_h"];
    
    for (int index = 0; index<childControllerNames.count - 1; index ++) {
        //获取类名字符串
        NSString *className = childControllerNames[index];
        //创建对象
        UIViewController *viewController = [[NSClassFromString(className) alloc] init];
        
        //设置背景颜色
        viewController.view.backgroundColor = [UIColor colorWithRed:33.0/255.0 green:38.0/255.0 blue:41.0/255.0 alpha:1];
        //设置tabbar图片
        viewController.tabBarItem.image = [[UIImage imageNamed:tabBarNormalImageNames[index]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        viewController.tabBarItem.selectedImage = [[UIImage imageNamed:tabBarSelectImageNames[index]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        //设置item的偏移，达到图片适配item大小的目的
        [viewController.tabBarItem setImageInsets:UIEdgeInsetsMake(7, 0, -7, 0)];
        
        UINavigationController *navi = [[UINavigationController new] initWithRootViewController:viewController];
        navi.navigationBar.barTintColor = [UIColor colorWithRed:26.0/255.0 green:26.0/255.0 blue:26.0/255.0 alpha:1];
        [UINavigationBar appearance].translucent = NO;
        
        //设置title,以及颜色
        viewController.navigationItem.title = childControllerTitle[index];
//        if (index == 4) {
//            viewController.navigationItem.title = @"我的账户";
//        }
        viewController.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:11]};
        
        if (index == 1) {
            [viewController.navigationController setNavigationBarHidden:YES];
        }
        
        //添加到tabBarController上
        [self addChildViewController:navi];
    }
    
}

//- (void)push
//{
//    NSLog(@"---");
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
