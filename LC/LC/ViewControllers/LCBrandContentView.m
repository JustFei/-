//
//  LCBrandContentView.m
//  LC
//
//  Created by JustBill on 16/5/17.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import "LCBrandContentView.h"
#import "LCBrandTableViewCell.h"
#import "LCBrandModel.h"
#import "MJRefresh.h"

@interface LCBrandContentView ()<UITableViewDelegate,UITableViewDataSource>
{
    LCBrandContentStratRefreshControlCallBack _lcBrandContentStratRefreshControlCallBack;
    LCBrandContentLoadingMoerCallBack _lcBrandContentLoadingMoerCallBack;
}


@property (weak, nonatomic) UITableView *BrandTableView;

@end

@implementation LCBrandContentView

#pragma mark - setter
- (void)setDataArr:(NSArray *)dataArr
{
    _dataArr = dataArr;
    
    [self.BrandTableView reloadData];
}

- (void)setLCBrandContentStratRefreshControlCallBack:(LCBrandContentStratRefreshControlCallBack)callback
{
    _lcBrandContentStratRefreshControlCallBack = callback;
}

- (void)setLCBrandContentLoadingMoerCallBack:(LCBrandContentLoadingMoerCallBack)callback
{
    _lcBrandContentLoadingMoerCallBack = callback;
}

#pragma mark - other
- (void)stopRefresh
{
    if ([self.BrandTableView.mj_header isRefreshing]) {
        [self.BrandTableView.mj_header endRefreshing];
    }
    
    if ([self.BrandTableView.mj_footer isRefreshing]) {
        [self.BrandTableView.mj_footer endRefreshing];
    }
}

#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LCBrandModel *model = _dataArr[indexPath.row];
    NSLog(@"id == %@ ; name = %@",model.Id,model.name);
    //通知发送model过去
    [[NSNotificationCenter defaultCenter] postNotificationName:@"brandCellSelectAction" object:_dataArr[indexPath.row]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 67;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LCBrandTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    //设置cell选中时的颜色以及状态，None为无状态
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //设置cell右侧的附加按钮的样式，此样式为一个向右的小箭头
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    LCBrandModel *model = _dataArr[indexPath.row];
    cell.model = model;
    return cell;
}

#pragma mark - 懒加载初始化
-(UITableView *)BrandTableView
{
    if (!_BrandTableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.bounds];
        tableView.backgroundColor = [UIColor colorWithRed:30.0/255.0 green:30.0/255.0 blue:30.0/255.0 alpha:1];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        tableView.separatorColor = [UIColor colorWithRed:43.0f/255.0f green:47.0f/255.0f blue:51.0f/255.0f alpha:1];
        
        [self addSubview:tableView];
        
        [tableView registerNib:[UINib nibWithNibName:@"LCBrandTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        
        //设置下拉刷新
        tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            //刷新回调
            if (_lcBrandContentStratRefreshControlCallBack) {
                _lcBrandContentStratRefreshControlCallBack();
            }
        }];
        
        //设置下拉加载更多
        tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            //上拉加载更多
            if (_lcBrandContentLoadingMoerCallBack) {
                _lcBrandContentLoadingMoerCallBack();
            }
        }];
        
        _BrandTableView = tableView;
    }
    return _BrandTableView;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
