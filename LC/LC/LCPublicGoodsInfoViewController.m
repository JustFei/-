//
//  LCPublicGoodsInfoViewController.m
//  LC
//
//  Created by JustBill on 16/5/31.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import "LCPublicGoodsInfoViewController.h"
#import "LCPublicGoodsInfoContentView.h"
#import "LCGoodsInfoModel.h"
#import "LCAttrListModel.h"
#import "LCSku_invModel.h"

@interface LCPublicGoodsInfoViewController ()
{
    LCGoodsInfoModel *_model;
}

@property (nonatomic ,weak) LCPublicGoodsInfoContentView *goodsInfoContentView;

@end

@implementation LCPublicGoodsInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.goodsInfoContentView.backgroundColor = [UIColor blueColor];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 5, 7, 14);
    [backBtn setImage:[UIImage imageNamed:@"btn_nav_back_default"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    self.navigationItem.leftBarButtonItem = backItem;
    
    [self setNavigationBarType];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.clipsToBounds = NO;
    self.navigationController.navigationBar.translucent = NO;
}

- (void)setNavigationBarType
{
    self.navigationController.navigationBar.translucent = YES;
    UIColor *color = [UIColor clearColor];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, 64);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
    //取出navigationbar 下面的线
    self.navigationController.navigationBar.clipsToBounds = YES;
}


- (instancetype)initWithUrl:(NSString *)goodId
{
    self = [super init];
    if (self) {
        NSString *url = [NSString stringWithFormat:kGoodsIforUrl,goodId];
        NSLog(@"%@",goodId);
        [self requestDataFromNetWorking:url];
    }
    return self;
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
        self.goodsInfoContentView.dataModel = _model;
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark - 封装数据模型
- (void)handleResponseObjectData:(id)responseObject
{
    _model = nil;
    
    //取出data字典
    NSDictionary *data = responseObject[@"data"];
    
    //取出items字典
    NSDictionary *items = data[@"items"];
    
    //封装第一部分数据（商品名称价格等信息）
    _model = [LCGoodsInfoModel modelWithBaseDictionary:items];
    
    //封装第二部分数据,brand_id;brand_name;brand_desc;brand_logo;（品牌信息）
    NSDictionary *brand_info = items[@"brand_info"];
    _model.brand_id = brand_info[@"brand_id"];
    _model.brand_name = brand_info[@"brand_name"];
    _model.brand_desc = brand_info[@"brand_desc"];
    _model.brand_logo = brand_info[@"brand_logo"];
    
    //封装第三部分数据,type_name;attrList;(尺寸颜色数量)
    NSArray *sku_info = items[@"sku_info"];
    NSDictionary *dict = sku_info.firstObject;
    
    _model.type_name = dict[@"type_name"];
    
    NSArray *attrList = dict[@"attrList"];
    for (NSDictionary *dic in attrList) {
        LCAttrListModel *attrListModel = [LCAttrListModel modelWithDictionary:dic];
        
        [_model.attrList addObject:attrListModel];
    }
    
    //封装第四部分数据,title;content;（购物须知）
    NSDictionary *good_guide = items[@"good_guide"];
    _model.title = good_guide[@"title"];
    _model.content = good_guide[@"content"];
    
    //封装第五部分数据，images_item；(滚动视图图片数据)
    NSArray *images_item = items[@"images_item"];
    for (NSString *imgUrl in images_item) {
        [_model.images_item addObject:imgUrl];
    }
    
    //封装第六部分数据
    NSArray *sku_inv = items[@"sku_inv"];
    for (NSDictionary *sku_invDic in sku_inv) {
        LCSku_invModel *sku_invModel = [LCSku_invModel modelWithDictionary:sku_invDic];
        [_model.sku_inv addObject:sku_invModel];
    }
    //model封装完毕，传值直接传model；
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - lazy
- (LCPublicGoodsInfoContentView *)goodsInfoContentView
{
    if (!_goodsInfoContentView) {
        LCPublicGoodsInfoContentView *view = [[LCPublicGoodsInfoContentView alloc] initWithFrame:self.view.frame];
        NSLog(@"contentView = %@",NSStringFromCGRect(self.view.frame));
        
        [self.view addSubview:view];
        _goodsInfoContentView = view;
    }
    
    return _goodsInfoContentView;
}


- (void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
