//
//  LCTwoContentView.m
//  LC
//
//  Created by JustBill on 16/5/19.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import "LCTwoContentView.h"
#import "LCTwoTableViewCell.h"
#import "LCTwoTableViewHeaderView.h"
#import "LCTwoCategoryViewController.h"
#import "LCTwoAuthorViewController.h"

@interface LCTwoContentView ()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL _isDownSlide;
    NSArray *_dataArrSection;
    NSArray *_dataArrRow;
    LCTwoContentViewTableViewCellSelectCallBack _lcTwoContentViewTableViewCellSelectCallBack;
    LCTwoContentViewHideTabBarCallBack _lcTwoContentViewHideTabBarCallBack;
    LCTwoContentViewShowTabBarCallBack _lcTwoContentViewShowTabBarCallBack;
    BOOL _isHide ;
}

@property (nonatomic ,strong)LCinfosModel *dateModel;

@property (nonatomic ,weak)UILabel *naviDateLabel;

@property (nonatomic ,weak) UIImageView *bottomBtn;

@end

@implementation LCTwoContentView

#pragma mark - frame
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.upView.frame = CGRectMake(0, 64 - self.frame.size.height, self.frame.size.width, self.frame.size.height - 64  );
    self.navigationbarView.frame = CGRectMake(0, 0, self.frame.size.width, 64);
    
    CGFloat center = self.frame.size.width / 2;
    
    self.naviTitleLabel.frame = CGRectMake(center - 100, 20, 200, 44);
    
    self.naviDateLabel.frame = CGRectMake(10, 25, 60, 39);
    
    self.bottomBtn.frame = CGRectMake(self.frame.size.width - 50, 34, 16, 12);
    
    self.twoTableView.frame = CGRectMake(0, 64, self.frame.size.width, self.frame.size.height - 64 - 49);
    _isHide = YES;
}

#pragma mark -- UITableViewDelegate,UITableViewDataSource

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_lcTwoContentViewTableViewCellSelectCallBack) {
        _lcTwoContentViewTableViewCellSelectCallBack(indexPath);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    LCTwoTableViewHeaderView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerView"];
    
        NSString *str = _model.keys[section];
        //这里系统提示需要设置headView的contentView的backgroundColor；我设置了却并没有什么用;
        //headView.contentView.backgroundColor = [UIColor redColor];
        
        //分割字符串取得月日
        NSString *dateStr = [str substringFromIndex:5];
        headView.dateStr = dateStr;
    
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.frame.size.width * 358 / 640;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _model.keys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //取出每一段的model
    _dataArrSection = _model.dicModel[section];
    return _dataArrSection.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LCTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    //将每个cell的model取出来，set给cell
    _dataArrRow = _model.dicModel[indexPath.section];
    _dateModel = _dataArrRow[indexPath.row];

    cell.model = _dateModel;
    
    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

//这里取得当前tableView的可见cell，然后获取第一个cell，得到第一个cell的section，修改label
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSArray *array = self.twoTableView.visibleCells;
    
    UITableViewCell *cell = [array firstObject];
    
    NSIndexPath *indexPath = [self.twoTableView indexPathForCell:cell];
    
    NSString *str = _model.keys[indexPath.section];
    //分割字符串取得月日
    NSString *dateStr = [str substringFromIndex:5];
    
    self.naviDateLabel.text = dateStr;
}

#pragma mark - setter
- (void)setModel:(LCTwoModel *)model
{
    _model = model;
    
    NSString *str = _model.keys.firstObject;
    //分割字符串取得月日
    NSString *dateStr = [str substringFromIndex:5];
    
    self.naviDateLabel.text = dateStr;
    
    [self.twoTableView reloadData];
}

- (void)setLCTwoContentViewTableViewCellSelectCallBack:(LCTwoContentViewTableViewCellSelectCallBack )callback
{
    _lcTwoContentViewTableViewCellSelectCallBack = callback;
}

- (void)setLCTwoContentViewHideTabBarCallBack:(LCTwoContentViewHideTabBarCallBack)callback
{
    _lcTwoContentViewHideTabBarCallBack = callback;
}

- (void)setLCTwoContentViewShowTabBarCallBack:(LCTwoContentViewShowTabBarCallBack)callback
{
    _lcTwoContentViewShowTabBarCallBack = callback;
}

#pragma mark - lazy
- (UITableView *)twoTableView
{
    if (!_twoTableView) {
        UITableView *tb = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        tb.delegate = self;
        tb.dataSource = self;
        tb.backgroundColor = [UIColor colorWithRed:26.0/255.0 green:26.0/255.0 blue:26.0/255.0 alpha:1];

        
        [self addSubview:tb];
        [tb registerNib:[UINib nibWithNibName:@"LCTwoTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        [tb registerNib:[UINib nibWithNibName:@"LCTwoTableViewHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"headerView"];
        
        //去掉多余的先
        tb.tableFooterView.hidden = YES;
        
        //去掉tb的线
        tb.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _twoTableView = tb;
    }
    return _twoTableView;
}

- (LCinfosModel *)dateModel
{
    if (!_dateModel) {
        _dateModel = [[LCinfosModel alloc] init];
    }
    return _dateModel;
}

- (YCSegmentView *)upView
{
    if (!_upView) {
        LCTwoCategoryViewController *categoryView = [[LCTwoCategoryViewController alloc] init];
        categoryView.title = @"分类";
        
        LCTwoAuthorViewController *authorView = [[LCTwoAuthorViewController alloc] init];
        authorView.title = @"作者";
        
        //这里设置了分类和作者两个viewController并添加到了这个view上
        YCSegmentView *up = [[YCSegmentView alloc] initWithFrame:CGRectZero titleHeight:73 viewControllers: @[categoryView,authorView] underColor:[UIColor whiteColor]];
        
        [self addSubview:up];
        _upView = up;
    }
    return _upView;
}

//自定义navigationbar
- (UIView *)navigationbarView
{
    if (!_navigationbarView) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor colorWithRed:26.0/255.0 green:26.0/255.0 blue:26.0/255.0 alpha:1];
        UITapGestureRecognizer *downUpView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(downUpView)];
        [view addGestureRecognizer:downUpView];
        
        UIViewController *vc = [self viewController];
        
        [vc.tabBarController.view addSubview:view];
        _navigationbarView = view;
    }
    return _navigationbarView;
}

- (UIImageView *)bottomBtn
{
    if (!_bottomBtn) {
        UIImageView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icn_accessory_down"]];
        
        [self.navigationbarView addSubview:view];
        _bottomBtn = view;
    }
    
    return _bottomBtn;
}

//一直遍历视图的父视图,找他的响应者.如果响应者是视图控制器,则返回它.
- (UIViewController *)viewController
{
    for (UIView* next = [self superview]; next; next = next.superview)
    {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (UILabel *)naviTitleLabel
{
    if (!_naviTitleLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"杂志";
        label.font = [UIFont systemFontOfSize:11];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        
        [self.navigationbarView addSubview:label];
        _naviTitleLabel = label;
    }
    
    return _naviTitleLabel;
}

- (UILabel *)naviDateLabel
{
    if (!_naviDateLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont fontWithName:@"gotham_book" size:9];
        label.textColor = [UIColor colorWithRed:116.0 /255.0 green:158.0 / 255.0 blue:200.0 / 255.0 alpha:1];
        
        [self.navigationbarView addSubview:label];
        _naviDateLabel = label;
    }
    
    return _naviDateLabel;
}



#pragma mark - 点击事件

//点击隐藏/显示上方的视图
- (void)downUpView
{
    if (_isHide) {
        [UIView animateWithDuration:0.5 animations:^{
            
            //隐藏naviDateLabel
            self.naviDateLabel.hidden = YES;
            
            //将upView移到屏幕上显示
            self.upView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 64 );
            
            //将navigationVie移到最下面显示
            self.navigationbarView.frame = CGRectMake(0, self.frame.size.height - 64, self.frame.size.width, 64);
            
            self.bottomBtn.transform = CGAffineTransformMakeRotation(M_PI);
            
            //将TableView移出屏幕隐藏
            self.twoTableView.frame = CGRectMake(0, self.frame.size.height , self.frame.size.width, self.frame.size.height - 64 - 49);
            
            //隐藏当前的tabBar
            if (_lcTwoContentViewHideTabBarCallBack) {
                _lcTwoContentViewHideTabBarCallBack();
            }
            
        } completion:^(BOOL finished) {
            nil;
        }];
        _isHide = !_isHide;
    }else
    {
        [self showAllView];
    }
    
}

- (void)showAllView
{
    [UIView animateWithDuration:0.5 animations:^{
        self.upView.frame = CGRectMake(0, 64 - self.frame.size.height, self.frame.size.width, self.frame.size.height - 64);
        self.navigationbarView.frame = CGRectMake(0, 0, self.frame.size.width, 64);
        self.twoTableView.frame = CGRectMake(0, 64, self.frame.size.width, self.frame.size.height - 64 - 49);
        
        self.bottomBtn.transform = CGAffineTransformMakeRotation(2 * M_PI);
        
        //显示naviDateLabel
        self.naviDateLabel.hidden = NO;
        
        //显示当前的tabBar
        if (_lcTwoContentViewShowTabBarCallBack) {
            _lcTwoContentViewShowTabBarCallBack();
        }
        
        
    } completion:^(BOOL finished) {
        nil;
    }];
    _isHide = !_isHide;
}

@end
