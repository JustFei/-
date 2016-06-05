//
//  LCTwoAuthorContentView.m
//  LC
//
//  Created by JustBill on 16/5/21.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import "LCTwoAuthorContentView.h"
#import "LCTwoAuthorTableViewCell.h"
#import "LCTwoAuthorModel.h"


@interface LCTwoAuthorContentView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,weak)UITableView *twoAuthorTableView;

@end

@implementation LCTwoAuthorContentView

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.twoAuthorTableView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 73);
}

#pragma mark - setter
- (void)setModelArr:(NSArray *)modelArr
{
    _modelArr = modelArr;
    
    [self.twoAuthorTableView reloadData];
}

#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LCTwoAuthorModel *model = _modelArr[indexPath.row];
    //思路：这里可以注册一个通知中心，然后将model传进去。
    [[NSNotificationCenter defaultCenter] postNotificationName:@"selectTableCell1" object:model];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 74;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LCTwoAuthorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableviewcell"];
    
    LCTwoAuthorModel *model = self.modelArr[indexPath.row];
    
    cell.model = model;
    
    return cell;
}

#pragma mark - lazy
- (UITableView *)twoAuthorTableView
{
    if (!_twoAuthorTableView) {
        UITableView *view = [[UITableView alloc] init];
        view.backgroundColor = [UIColor colorWithRed:218.0/255.0 green:224.0/255.0 blue:230.0/255.0 alpha:1];
        view.delegate = self;
        view.dataSource = self;
        
        [self addSubview:view];
        
        [view registerNib:[UINib nibWithNibName:@"LCTwoAuthorTableViewCell" bundle:nil] forCellReuseIdentifier:@"tableviewcell"];
        
        _twoAuthorTableView = view;
    }
    
    return _twoAuthorTableView;
}

@end
