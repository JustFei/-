//
//  LCTwoAuthorViewController.m
//  LC
//
//  Created by JustBill on 16/5/20.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import "LCTwoAuthorViewController.h"
#import "LCTwoAuthorContentView.h"
#import "AFNetworking.h"
#import "LCTwoAuthorModel.h"

#define kTwoAuthorUrl @"http://app.iliangcang.com/topic/listauthor?app_key=iphone&build=170&osVersion=93&v=2.5.0"

@interface LCTwoAuthorViewController ()

@property (nonatomic ,weak)LCTwoAuthorContentView *TACView;

@property (nonatomic ,strong)NSMutableArray *modelArr;

@end

@implementation LCTwoAuthorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.TACView.backgroundColor = [UIColor redColor];
    
    [self requestDataFromNetworking];
    
}

//处理网络请求
- (void)requestDataFromNetworking
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager GET:kTwoAuthorUrl parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //处理数据
        [self handleResponseObjectData:responseObject];
        
        //刷新
        self.TACView.modelArr = self.modelArr;
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }];
}

//处理封装数据
- (void)handleResponseObjectData: (id)responseObject
{
    NSArray *dataArr =  responseObject[@"data"];
    
    for (NSDictionary *data in dataArr) {
        LCTwoAuthorModel *model = [LCTwoAuthorModel modelWithDictionary:data];
        
        [self.modelArr addObject:model];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - lazy
- (LCTwoAuthorContentView *)TACView
{
    if (!_TACView) {
        LCTwoAuthorContentView *view = [[LCTwoAuthorContentView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64)];
        
        [self.view addSubview:view];
        _TACView = view;
    }
    
    return _TACView;
}

- (NSMutableArray *)modelArr
{
    if (!_modelArr) {
        _modelArr = [NSMutableArray array];
    }
    
    return _modelArr;
}

@end
