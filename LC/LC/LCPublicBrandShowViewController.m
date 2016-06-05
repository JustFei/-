//
//  LCPublicBrandShowViewController.m
//  LC
//
//  Created by JustBill on 16/5/27.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import "LCPublicBrandShowViewController.h"
#import "LCBrandShowContentView.h"
#import "LCBrandModel.h"
#import "LCBrandShowModel.h"


@interface LCPublicBrandShowViewController ()

@property (nonatomic ,weak)LCBrandShowContentView *brandShowContentView;

@property (nonatomic ,strong)NSMutableArray *dataModel;

@end

@implementation LCPublicBrandShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:26.0/255.0 green:26.0/255.0 blue:26.0/255.0 alpha:1];
    
    self.brandShowContentView.backgroundColor = [UIColor colorWithRed:26.0 / 255.0 green:26.0 / 255.0 blue:26.0 / 255.0 alpha:1];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 5, 7, 14);
    [backBtn setImage:[UIImage imageNamed:@"btn_nav_back_default"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    self.navigationItem.leftBarButtonItem = backItem;
    
    NSString *url = [NSString stringWithFormat:kBrandShowUrl,self.iD];
    
    [self requestDataFromNetWorking:url];
    
}

//请求数据
- (void)requestDataFromNetWorking: (NSString *)url
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //1.数据模型封装
        [self handleResponseObjectData:responseObject];
        
        //2.刷新界面
        self.brandShowContentView.modelArr = self.dataModel;
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark - 封装数据模型
- (void)handleResponseObjectData:(id)responseObject
{
    [self.dataModel removeAllObjects];
    
    NSDictionary *data = responseObject[@"data"];
    NSArray *itemsArr = data[@"items"];
    
    for (NSDictionary *dict in itemsArr) {
        
        LCBrandShowModel *model = [LCBrandShowModel modelWithDictionary:dict];
        
        NSDictionary *brand_info = dict[@"brand_info"];
        model.brand_name = brand_info[@"brand_name"];
        model.brand_logo = brand_info[@"brand_logo"];
        model.brand_desc = brand_info[@"brand_desc"];
        
        [self.dataModel addObject:model];
    }
    NSLog(@"%ld",self.dataModel.count);
}



- (void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - lazy
- (LCBrandShowContentView *)brandShowContentView
{
    if (!_brandShowContentView) {
        LCBrandShowContentView *view = [[LCBrandShowContentView alloc] initWithFrame:self.view.bounds];
        
        [self.view addSubview:view];
        _brandShowContentView = view;
    }
    
    return _brandShowContentView;
}

- (NSMutableArray *)dataModel
{
    if (!_dataModel) {
        _dataModel = [NSMutableArray array];
    }
    return _dataModel;
}

@end
