//
//  LCSubjectViewController.m
//  LC
//
//  Created by JustBill on 16/5/17.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import "LCSubjectViewController.h"
#import "LCSubjectContentView.h"
#import "AFNetworking.h"
#import "LCSubjectModel.h"


#define kSubjectUrl @"http://api.iliangcang.com/i/appshopmaga?app_key=iphone&build=170&osVersion=93&v=2.5.0"

@interface LCSubjectViewController ()
{
    SubjectCallBack _subjectCallBack;
}
@property (nonatomic ,weak)LCSubjectContentView *SCView;

//数据源
@property (nonatomic ,strong)NSMutableArray *dataArr;

@end

@implementation LCSubjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.SCView.backgroundColor = [UIColor colorWithRed:30.0/255.0 green:30.0/255.0 blue:30.0/255.0 alpha:1];
    
    [self requestDataFromNetWorking];
    
}

- (void)requestDataFromNetWorking
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager GET:kSubjectUrl parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [self handleResponseObjectData:responseObject];
        NSLog(@"---");
        //3.刷新界面
        self.SCView.dataArr = self.dataArr;
        
        //4.停止刷新
        [self.SCView stopRefresh];
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)handleResponseObjectData:(id)responseObject
{
    NSArray *data = responseObject[@"data"];
    for (NSDictionary *dict in data) {
        LCSubjectModel *model = [[LCSubjectModel alloc] init];
        model.imgUrl = dict[@"cover_img"];
        model.nameStr = dict[@"topic_name"];
        model.actionUrlStr = dict[@"topic_url"];
        
        [self.dataArr addObject:model];
    }
//    NSLog(@"%ld",self.dataArr.count);
    self.SCView.dataArr = self.dataArr;
}

#pragma mark - setter
- (void)setSubjectCallBack:(SubjectCallBack)callback
{
    _subjectCallBack = callback;
}

#pragma mark - lazy
- (LCSubjectContentView *)SCView
{
    if (!_SCView) {
        LCSubjectContentView *sc = [[LCSubjectContentView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 49)];
        
        [sc setLCSubjectContentStratRefreshControlCallBack:^{
            
            [self startRefresh];
            
        }];
        
        //通过回调，实现当前控制器跳转到SubjectSubViewController上
        [sc setSubjectCellSelectActionCallBack:^(NSInteger index) {
            
            LCSubjectModel *model = self.dataArr[index];
            LCPublicWebModel *webModel = [[LCPublicWebModel alloc] init];
            webModel.imageUrl = model.imgUrl;
            webModel.title = model.nameStr;
            webModel.webUrl = model.actionUrlStr;
            
            if (_subjectCallBack) {
                _subjectCallBack(webModel);
            }
            
        }];
        
        [self.view addSubview:sc];
        _SCView = sc;
    }
    return _SCView;
}

- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

#pragma mark - 刷新
- (void)startRefresh
{
    //重新请求
    [self requestDataFromNetWorking];
}

@end
