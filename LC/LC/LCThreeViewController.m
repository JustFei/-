//
//  LCThreeViewController.m
//  LC
//
//  Created by JustBill on 16/5/17.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import "LCThreeViewController.h"
#import "LCThreeContentView.h"
#import "LCThreeModel.h"

@interface LCThreeViewController ()
{
    NSInteger _currentPage;
}
@property (nonatomic ,weak)LCThreeContentView *threeContentView;

/**
 *  数据源
 */
@property (nonatomic, strong) NSMutableArray *modelArr;

@end

@implementation LCThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //搜索和更多的按钮暂时没有实现
    UIBarButtonItem *leftBackBtn = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"btn_nav_search"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(search)];
    
    self.navigationItem.leftBarButtonItem = leftBackBtn;
    
    UIBarButtonItem *rightCatBtn = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"btn_nav_option"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(more)];
    
    self.navigationItem.rightBarButtonItem = rightCatBtn;
    
    self.threeContentView.backgroundColor = [UIColor colorWithRed:35.0 / 255.0 green:38.0 / 255.0 blue:41.0 / 255.0 alpha:1];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _currentPage = 1;
    
    [self requestDataFromNetWorking:[NSString stringWithFormat:kThreeUrl,_currentPage]];
    
}

- (void)search
{
    NSLog(@"这里是搜索");
}

- (void)more
{
    NSLog(@"这里是更多");
}

#pragma mark - 请求数据
//请求数据
- (void)requestDataFromNetWorking:(NSString *)url;
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //1.如果是刷新，就删除原有的所有数据
        if (_currentPage == 1) {
            [self.modelArr removeAllObjects];
        }
        
        //2.数据模型封装
        [self handleResponseObjectData:responseObject];
        
        //3.刷新界面
        self.threeContentView.modelArr = self.modelArr;
        
        //4.停止刷新
        [self.threeContentView stopRefresh];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark - 封装数据模型
- (void)handleResponseObjectData:(id)responseObject
{
    NSArray *dataArr = responseObject[@"data"];
    
    //这里是原来的数据解析，如果现在的有问题，请换回来
    for (NSDictionary *data in dataArr) {
        
        LCThreeModel *model = [LCThreeModel modelWithDictionary:data];
        [self.modelArr addObject:model];
    }
    NSLog(@"%ld",self.modelArr.count);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 刷新
- (void)startRefresh
{
    
    //1.page=1
    _currentPage = 1;
    
    //暂时先传第一个“全部”的url过来拼接
    NSString *url = [NSString stringWithFormat:kThreeUrl,_currentPage];
    
    //2.重新请求
    [self requestDataFromNetWorking:url];
}

#pragma mark - 加载更多
- (void)loadMore
{
    //1.page++
    _currentPage++;
    
    //传入“全部”的url拼接
    NSString *url = [NSString stringWithFormat:kThreeUrl,_currentPage];
    
    //2.重新请求
    [self requestDataFromNetWorking: url];
}

#pragma mark - lazy
- (LCThreeContentView *)threeContentView
{
    if (!_threeContentView) {
        LCThreeContentView *view = [[LCThreeContentView alloc] initWithFrame:self.view.bounds];
        
        //开始刷新,刷新回调
        [view setLCThreeContentStratRefreshControlCallBack:^{
            
            [self startRefresh];
            
        }];
        //加载更多，加载回调
        [view setLCThreeContentLoadingMoerCallBack:^{
            
            [self loadMore];
            
        }];
        
        [self.view addSubview:view];
        _threeContentView = view;
    }
    
    return _threeContentView;
}

- (NSMutableArray *)modelArr
{
    if (!_modelArr) {
        _modelArr = [NSMutableArray array];
    }
    return _modelArr;
}

@end
