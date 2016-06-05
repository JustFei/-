//
//  LCBrandViewController.m
//  LC
//
//  Created by JustBill on 16/5/17.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import "LCBrandViewController.h"
#import "LCBrandContentView.h"
#import "AFNetworking.h"
#import "LCBrandModel.h"

#define kBrandUrl @"http://iliangcang.com:8200/brand/list/2?app_key=iphone&build=170&offset=10&osVersion=93&start=%ld&v=2.5.0"

@interface LCBrandViewController ()
{
    NSInteger _currentPage;
}

@property (nonatomic ,weak)LCBrandContentView *BCView;

//数据源
@property (nonatomic ,strong)NSMutableArray *dataArr;

@end

@implementation LCBrandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor colorWithRed:30.0/255.0 green:30.0/255.0 blue:30.0/255.0 alpha:1];
    
    _currentPage = 0;
    
    [self requestDataFromNetWorking];
}

- (void)requestDataFromNetWorking
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:[NSString stringWithFormat:kBrandUrl,_currentPage*10] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //1.如果是刷新，就删除原有的所有数据
        if (_currentPage == 0) {
            [self.dataArr removeAllObjects];
        }
        
        //2.数据模型封装
        [self handleResponseObjectData:responseObject];
        
        //3.刷新界面
        self.BCView.dataArr = self.dataArr;
        
        //4.停止刷新
        [self.BCView stopRefresh];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"%@",error);
    }];
}

#pragma mark - 数据模型
- (void)handleResponseObjectData:(id)responseObject
{
    NSDictionary *data = responseObject[@"data"];
    NSArray *items = data[@"items"];
    
    for (NSDictionary *dict in items) {
        
        LCBrandModel *model = [LCBrandModel modelWithDictionary:dict];
        model.url = dict[@"logo"][@"url"];
        
        [self.dataArr addObject:model];
    }
}

#pragma mark - 刷新
- (void)startRefresh
{
    //1.page=0
    _currentPage = 0;
    
    //2.重新请求
    [self requestDataFromNetWorking];
}

#pragma mark - 加载更多
- (void)loadMore
{
    //1.page++
    _currentPage++;
    
    //2.重新请求
    [self requestDataFromNetWorking];
}

#pragma mark - lazy
-(LCBrandContentView *)BCView
{
    if (!_BCView) {
        LCBrandContentView *bc = [[LCBrandContentView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 49)];
        //开始刷新,刷新回调
        [bc setLCBrandContentStratRefreshControlCallBack:^{
            
            [self startRefresh];
            
        }];
        //加载更多，加载回调
        [bc setLCBrandContentLoadingMoerCallBack:^{
            
            [self loadMore];
            
        }];
        
        [self.view addSubview:bc];
        
        _BCView = bc;
    }
    
    return _BCView;
}

- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

@end
