//
//  TwoViewController.m
//  LC
//
//  Created by JustBill on 16/5/17.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import "LCTwoViewController.h"
#import "LCTwoContentView.h"
#import "LCTwoModel.h"
#import "LCinfosModel.h"
#import "LCTwoCategoryModel.h"
#import "LCTwoAuthorModel.h"
#import "LCPublicWebViewController.h"
#import "LCPublicWebModel.h"

@interface LCTwoViewController ()
{
    BOOL _isHide;
}
//创建contentView
@property (nonatomic ,weak)LCTwoContentView *TCView;

//创建第一个Model
@property (nonatomic ,strong)LCTwoModel *dataModel;

@end

@implementation LCTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //关闭导航栏自动给tableview设置的偏移量。
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.TCView.backgroundColor = [UIColor colorWithRed:30.0/255.0 green:30.0/255.0 blue:30.0/255.0 alpha:1];
    
    [self requestDataFromNetWorking:kTwoUrl];
    
    //这两个是点击分类里面的collectionViewCell所做的操作
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notification1:) name:@"selectCollectionCell1" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notification2:) name:@"selectCollectionCell2" object:nil];
    
    //这个方法是点击“作者”里面的的tableViewCell的所做的操作
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notification3:) name:@"selectTableCell1" object:nil];
}

- (void)notification1:(NSNotification *)noti
{
    //这里传过来的是个url的string
    
    [self requestDataFromNetWorking: noti.object];
    
    self.TCView.naviTitleLabel.text = @"杂志";
    
    [self.TCView showAllView];
}

- (void)notification2:(NSNotification *)noti
{
    //这里传过来的是每个collectioncell上的Model
    LCTwoCategoryModel *model = noti.object;
    NSString *url = [NSString stringWithFormat:kTwoCategorySubUrl,model.cat_id];
    NSString *naviTitle = [NSString stringWithFormat:@"杂志 · %@",model.cat_name];
    
    [self requestDataFromNetWorking: url];
    
    self.TCView.naviTitleLabel.text = naviTitle;
    
    [self.TCView showAllView];
}

- (void)notification3:(NSNotification *)noti
{
    //这里传过来的是每个collectioncell上的Model
    LCTwoAuthorModel *model = noti.object;
    NSString *url = [NSString stringWithFormat:kTwoAuthorSubUrl,model.author_id];
    NSString *naviTitle = [NSString stringWithFormat:@"杂志 · %@",model.author_name];
    
    [self requestDataFromNetWorking: url];
    
    self.TCView.naviTitleLabel.text = naviTitle;
    
    [self.TCView showAllView];
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
        self.TCView.model = self.dataModel;
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark - 封装数据模型
- (void)handleResponseObjectData:(id)responseObject
{
    [self.dataModel removeAllObject];
    
    NSDictionary *data = responseObject[@"data"];
    NSArray *keysArr = data[@"keys"];
    self.dataModel.keys = keysArr;
    
    NSDictionary *dic = data[@"infos"];
    
    for (NSString *key in keysArr) {
        NSArray *day = dic[key];
        
        NSMutableArray *dayArr = [NSMutableArray array];
        
        for (NSDictionary *dayDic in day) {
            LCinfosModel *infosModel = [[LCinfosModel alloc] init];
            infosModel.topic_name = dayDic[@"topic_name"];
            infosModel.cover_img = dayDic[@"cover_img"];
            infosModel.author_name = dayDic[@"author_name"];
            infosModel.cat_name = dayDic[@"cat_name"];
            infosModel.topic_url = dayDic[@"topic_url"];
            infosModel.nav_title = dayDic[@"nav_title"];
            
            [dayArr addObject:infosModel];
        }
        
        [self.dataModel.dicModel addObject:dayArr];
    }
}

#pragma mark - lazy
- (LCTwoContentView *)TCView
{
    if (!_TCView) {
        LCTwoContentView *tc = [[LCTwoContentView alloc] initWithFrame:self.view.frame];
        
        //点击navgation隐藏tabBar
        [tc setLCTwoContentViewHideTabBarCallBack:^{
            
//      [self setHidesBottomBarWhenPushed:YES ]; 此方法在push的时候隐藏tabBar   
            [UIView animateWithDuration:0.1 animations:^{
                self.tabBarController.tabBar.hidden = YES ;
            }];
        }];
        
        //点击navigation显示tabBar
        [tc setLCTwoContentViewShowTabBarCallBack:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.tabBarController.tabBar.hidden = NO ;
            });
            
        }];
        
        [tc setLCTwoContentViewTableViewCellSelectCallBack:^(NSIndexPath *index) {
            
            //取第几组
            NSArray *sectionArray = _dataModel.dicModel;
            NSArray *rowArray = sectionArray[index.section];
            //取该组里面的第几个
            LCinfosModel *infosModel = [[LCinfosModel alloc] init];
            infosModel = rowArray[index.row];

            LCPublicWebModel *webModel = [[LCPublicWebModel alloc] init];
            webModel.title = infosModel.topic_name;
            webModel.imageUrl = infosModel.cover_img;
            webModel.webUrl = infosModel.topic_url;
            
            //push到公共的webView去
            LCPublicWebViewController *webView = [[LCPublicWebViewController alloc] init];
            webView.model = webModel;
            [webView setHidesBottomBarWhenPushed:YES];
//            webView.titleText = infosModel.topic_name;
            //[self.navigationController setNavigationBarHidden:NO animated:NO];
            
            [self.navigationController pushViewController:webView animated:YES];
        }];
        
        [self.view addSubview:tc];
        _TCView = tc;
    }
    return _TCView;
}

- (LCTwoModel *)dataModel
{
    if (!_dataModel) {
        _dataModel = [[LCTwoModel alloc] init];
        
    }
    return _dataModel;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    self.TCView.navigationbarView.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    
    self.TCView.navigationbarView.hidden = YES;
}


- (void)dealloc
{
    //移除当前控制器对象所有的通知中心
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
