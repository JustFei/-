//
//  LCHomePageViewController.m
//  LC
//
//  Created by JustBill on 16/5/17.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import "LCHomePageViewController.h"
#import "LCHomePageContentView.h"
#import "LCHomePageModel.h"
#import "LCHomePageSlideModel.h"
#import "LCHomePageListModel.h"

@interface LCHomePageViewController ()
{
    HomePageShopShowCallBack _homePageShopShowCallBack;
}
@property (nonatomic ,weak)LCHomePageContentView *lcHomePageContentView;

//数据源
@property (nonatomic ,strong)LCHomePageModel *pageModel;

@end

@implementation LCHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.lcHomePageContentView.backgroundColor = [UIColor colorWithRed:30.0/255.0 green:30.0/255.0 blue:30.0/255.0 alpha:1];
    
    [self requestDataFromNetWorking];
}

- (void)requestDataFromNetWorking
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager GET:[NSString stringWithFormat:kHomePageUrl] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //2.数据模型封装
        [self handleResponseObjectData:responseObject];
        
        //3.刷新界面
        self.lcHomePageContentView.pageModel = self.pageModel;
        
        //4.停止刷新
        //[self.BCView stopRefresh];
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)setHomePageShopShowCallBack:(HomePageShopShowCallBack)callback
{
    _homePageShopShowCallBack = callback;
}

#pragma mark - 数据模型
- (void)handleResponseObjectData:(id)responseObject
{
    NSDictionary *slide = responseObject[@"slide"];
    NSArray *data = slide[@"data"];
    
    //处理slide的数据
    for (NSDictionary *dic in data) {
        //里面slide的Model
        LCHomePageSlideModel *slideModel = [LCHomePageSlideModel modelWithDictionary:dic];
        [self.pageModel.slideArr addObject:slideModel];
    }
    NSLog(@"%ld",self.pageModel.slideArr.count);
    
    //处理list的数据
    NSDictionary *list = responseObject[@"list"];
    NSArray *listArr = list[@"list"];
    
    for (int i = 0; i < listArr.count; i ++) {
        if (i == 0) {
            //处理list第一组的数据
            NSDictionary *listDic0 = listArr[0];
            
            NSDictionary *oneDic = listDic0[@"one"];
            //里面List的Model
            LCHomePageListModel *model = [LCHomePageListModel modelWithDictionary:oneDic];
            [self.pageModel.listArr addObject:model];
            
            NSDictionary *twoDic = listDic0[@"two"];
            model = [LCHomePageListModel modelWithDictionary:twoDic];
            [self.pageModel.listArr addObject:model];
            
            NSDictionary *threeDic = listDic0[@"three"];
            model = [LCHomePageListModel modelWithDictionary:threeDic];
            [self.pageModel.listArr addObject:model];
            
            NSDictionary *fourDic = listDic0[@"four"];
            model = [LCHomePageListModel modelWithDictionary:fourDic];
            [self.pageModel.listArr addObject:model];
            
        }
        if (i == 1) {
            //处理list第二组的数据
            NSDictionary *listDic1 = listArr[1];
            
            NSDictionary *oneDic = listDic1[@"one"];
            LCHomePageListModel *model = [LCHomePageListModel modelWithDictionary:oneDic];
            [self.pageModel.listArr addObject:model];
        }
        
        if (i == 2) {
            //处理list第三组的数据
            NSDictionary *listDic2 = listArr[2];
            
            NSDictionary *oneDic = listDic2[@"one"];
            LCHomePageListModel *model = [LCHomePageListModel modelWithDictionary:oneDic];
            [self.pageModel.listArr addObject:model];
            
            NSDictionary *twoDic = listDic2[@"two"];
            model = [LCHomePageListModel modelWithDictionary:twoDic];
            [self.pageModel.listArr addObject:model];
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (LCHomePageContentView *)lcHomePageContentView
{
    if (!_lcHomePageContentView) {
        LCHomePageContentView *view = [[NSBundle mainBundle] loadNibNamed:@"LCHomePageContentView" owner:nil options:nil][0];
        
        //还需跳转到上一层的controller。
        [view setHomePageContentViewButtonClickCallBack:^(NSString *url) {
            if (_homePageShopShowCallBack) {
                _homePageShopShowCallBack(url);
            }
        }];

        view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64);
        
        [self.view addSubview:view];
        _lcHomePageContentView = view;
    }
    
    return _lcHomePageContentView;
}

- (LCHomePageModel *)pageModel
{
    if (!_pageModel) {
        _pageModel = [[LCHomePageModel alloc] init];
    }
    return _pageModel;
}

@end
