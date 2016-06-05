//
//  LCTwoCategoryViewController.m
//  LC
//
//  Created by JustBill on 16/5/20.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import "LCTwoCategoryViewController.h"
#import "LCTwoCategoryContentView.h"
#import "AFNetworking.h"
#import "LCTwoCategoryModel.h"

//杂志-分类的接口
//#define kTwoCategoryUrl @"http://app.iliangcang.com/topic/listcat?app_key=iphone&build=170&osVersion=93&v=2.5.0"

@interface LCTwoCategoryViewController ()
{
    TwoCategoryControllerCellClickCallBack _twoCategoryControllerCellClickCallBack;
}
@property (nonatomic ,weak)LCTwoCategoryContentView *TCCView;
/**
 *  数据源
 */
@property (nonatomic, strong) NSMutableArray *modelArr;

@end

@implementation LCTwoCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.TCCView.backgroundColor = [UIColor whiteColor];
    
    [self requestDataFromNetWorking];

}

//请求数据
- (void)requestDataFromNetWorking
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager GET:[NSString stringWithFormat:kTwoCategoryUrl] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //1.数据模型封装
        [self handleResponseObjectData:responseObject];
        
        //2.刷新界面
        self.TCCView.modelArr = self.modelArr;
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark - 封装数据模型
- (void)handleResponseObjectData:(id)responseObject
{
    NSArray *dataArr = responseObject[@"data"];
    
    //LCTwoCategoryModel *model = [[LCTwoCategoryModel alloc] init];
    
    /*
    for (int i = 0; dataArr.count; i++) {
        if (i == 0) {
            model.isShowIcon = YES;
        }else if (i == 2) {
            model.isShowIcon = YES;
        }
        
        model = [LCTwoCategoryModel modelWithDictionary:dataArr[i]];
        [self.modelArr addObject:model];
    }*/
    
    
     //这里是原来的数据解析，如果现在的有问题，请换回来
    for (NSDictionary *data in dataArr) {
     
        LCTwoCategoryModel *model = [LCTwoCategoryModel modelWithDictionary:data];
        [self.modelArr addObject:model];
    }
    
}

#pragma mark - setter
- (void)setTwoCategoryControllerCellClickCallBack:(TwoCategoryControllerCellClickCallBack)callback
{
    _twoCategoryControllerCellClickCallBack = callback;
}

#pragma mark - lazy
- (LCTwoCategoryContentView *)TCCView
{
    if (!_TCCView) {
        LCTwoCategoryContentView *view  = [[LCTwoCategoryContentView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64)];

        
        [self.view addSubview:view];
        _TCCView = view;
    }
    return _TCCView;
}

- (NSMutableArray *)modelArr
{
    if (!_modelArr) {
        _modelArr = [NSMutableArray array];
    }
    return _modelArr;
}

@end
