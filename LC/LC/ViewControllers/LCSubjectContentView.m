//
//  LCSubjectContentView.m
//  LC
//
//  Created by JustBill on 16/5/18.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import "LCSubjectContentView.h"
#import "LCSubjectTableViewCell.h"
#import "LCSubjectModel.h"
#import "MJRefresh.h"

@interface LCSubjectContentView ()<UITableViewDelegate,UITableViewDataSource>
{
    SubjectCellSelectActionCallBack _subjectCellSelectActionCallBack;
    LCSubjectContentStratRefreshControlCallBack _lcSubjectContentStratRefreshControlCallBack;
}

@property (nonatomic ,weak)UITableView *subjectTableView;

@end

@implementation LCSubjectContentView

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.subjectTableView.frame = self.frame;
}

#pragma mark - setter
- (void)setSubjectCellSelectActionCallBack:(SubjectCellSelectActionCallBack)callback
{
    _subjectCellSelectActionCallBack = callback;
}

- (void)setLCSubjectContentStratRefreshControlCallBack:(LCSubjectContentStratRefreshControlCallBack)callback
{
    _lcSubjectContentStratRefreshControlCallBack = callback;
}

- (void)setDataArr:(NSArray *)dataArr
{
    _dataArr =dataArr;
    
    [self.subjectTableView reloadData];
}

#pragma mark - other
- (void)stopRefresh
{
    if ([self.subjectTableView.mj_header isRefreshing]) {
        [self.subjectTableView.mj_header endRefreshing];
    }
}

#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_subjectCellSelectActionCallBack) {
        _subjectCellSelectActionCallBack(indexPath.row);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 179;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LCSubjectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.accessoryType = UITableViewCellAccessoryNone;
    LCSubjectModel *model = _dataArr[indexPath.row];
    cell.model = model;
    
    return cell;
}

#pragma mark - lazy
- (UITableView *)subjectTableView
{
    if (!_subjectTableView) {
        UITableView *tbView = [[UITableView alloc] init];
        tbView.backgroundColor = [UIColor colorWithRed:30.0/255.0 green:30.0/255.0 blue:30.0/255.0 alpha:1];
        tbView.separatorStyle = UIAccessibilityTraitNone;
        tbView.delegate = self;
        tbView.dataSource = self;
        
        [self addSubview:tbView];
        [tbView registerNib:[UINib nibWithNibName:@"LCSubjectTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        
        //设置下拉刷新
        tbView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            //刷新回调
            if (_lcSubjectContentStratRefreshControlCallBack) {
                _lcSubjectContentStratRefreshControlCallBack();
            }
        }];
        
        _subjectTableView = tbView;
    }
    
    return _subjectTableView;
}

@end
