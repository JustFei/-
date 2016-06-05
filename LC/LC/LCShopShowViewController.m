//
//  LCShopShowViewController.m
//  LC
//
//  Created by JustBill on 16/5/26.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import "LCShopShowViewController.h"
#import "LCShopShowContentView.h"
#import "LCShopShowModel.h"

@interface LCShopShowViewController ()
{
    NSInteger _currentPage;
}
@property (nonatomic ,weak) LCShopShowContentView *shopShowContentView;

@property (nonatomic ,strong)NSMutableArray *modelArr;

@end

@implementation LCShopShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.shopShowContentView.backgroundColor = [UIColor blackColor];
    
    self.title = @"商店";
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 5, 7, 14);
    [backBtn setImage:[UIImage imageNamed:@"btn_nav_back_default"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    self.navigationItem.leftBarButtonItem = backItem;
    
    //UIBarButtonItem *rightCatBtn = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"btn_cart"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(catBtn)];
    
//    self.navigationItem.rightBarButtonItem = rightCatBtn;
}

- (void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)catBtn
{
    NSLog(@"这里是购物车");
}

#pragma mark - setter
- (void)setGoodurl:(NSString *)goodurl
{
    _goodurl = goodurl;
    //这里对url进行拼接
    _currentPage = 1;
    //这里第二次拼接url的时候出现url错误，应该是不能这样拼接
    NSString *url = [NSString stringWithFormat:kGoodsUrl,goodurl,_currentPage];
    [self requestDataFromNetWorking:url];
}

#pragma mark - 处理网络数据
- (void)requestDataFromNetWorking:(NSString *)goodurl
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager GET:goodurl parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //1.如果是刷新，就删除原有的所有数据
        if (_currentPage == 1) {
            [self.modelArr removeAllObjects];
        }
        
        //2.数据模型封装
        [self handleResponseObjectData:responseObject];
        
        //3.刷新界面
        self.shopShowContentView.modelArr = self.modelArr;
        
        //4.停止刷新
        [self.shopShowContentView stopRefresh];
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)handleResponseObjectData:(id)responseObject
{
    NSArray *data = responseObject[@"data"];
    
    for (NSDictionary *dic in data) {
        LCShopShowModel *model = [LCShopShowModel modelWithDictionary:dic];
        model.brand_name = dic[@"brand_info"][@"brand_name"];
        [self.modelArr addObject:model];
    }
}

#pragma mark - 刷新
- (void)startRefresh
{
    
    //1.page=1
    _currentPage = 1;
    
    //暂时先传第一个“全部”的url过来拼接
    NSString *url = [NSString stringWithFormat:kGoodsUrl,_goodurl,_currentPage];
    
    //2.重新请求
    [self requestDataFromNetWorking:url];
}

#pragma mark - 加载更多
- (void)loadMore
{
    //1.page++
    _currentPage++;
    
    //传入“全部”的url拼接
    NSString *url = [NSString stringWithFormat:kGoodsUrl,_goodurl,_currentPage];
    
    //2.重新请求
    [self requestDataFromNetWorking: url];
}

#pragma mark - lazy
- (NSMutableArray *)modelArr
{
    if (!_modelArr) {
        _modelArr = [NSMutableArray array];
    }
    return _modelArr;
}

- (LCShopShowContentView *)shopShowContentView
{
    if (!_shopShowContentView) {
        LCShopShowContentView *view = [[LCShopShowContentView alloc] initWithFrame:self.view.frame];
    
        //开始刷新,刷新回调
        [view setLCShopShowStratRefreshControlCallBack:^{
            
            [self startRefresh];
            
        }];
        //加载更多，加载回调
        [view setShopShowLoadingMoerCallBack:^{
            
            [self loadMore];
            
        }];
        
        [self.view addSubview:view];
        _shopShowContentView = view;
    }
    
    return _shopShowContentView;
}

@end
