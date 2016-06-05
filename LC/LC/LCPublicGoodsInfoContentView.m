//
//  LCPublicGoodsInfoContentView.m
//  LC
//
//  Created by JustBill on 16/5/31.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import "LCPublicGoodsInfoContentView.h"
#import "LCGoodsInfo.h"
#import "LCGoodsInfoTableViewCell.h"
#import "LCGuideShouldKnowCell.h"

@interface LCPublicGoodsInfoContentView ()<UITableViewDelegate,UITableViewDataSource>

/*
@property (nonatomic ,weak)UIScrollView *goodsInfoScrollView;

@property (nonatomic ,weak)LCGuideInfo *guideInfoView;
*/

@property (nonatomic ,weak)UITableView *goodsInfoTableView;

@property (nonatomic ,weak)LCGoodsInfo *goodInfoView;

@end

@implementation LCPublicGoodsInfoContentView

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.goodsInfoTableView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 49);
}

- (void)setDataModel:(LCGoodsInfoModel *)dataModel
{
    _dataModel = dataModel;
    
    self.goodInfoView = [[NSBundle mainBundle] loadNibNamed:@"LCGoodsInfo" owner:nil options:nil][0];
    self.goodInfoView.dataModel = dataModel;
    dataModel.shopInfoBtnSelect = YES;
    dataModel.guideInfoBtnSelect = NO;
    self.goodInfoView.shopInfoBtn.selected = YES;
    self.goodInfoView.guideInfoBtn.selected = NO;
    
    [self.goodInfoView setShowShopInfo:^{
        [self.goodsInfoTableView reloadData];
    }];
    
    [self.goodInfoView setShowGuideInfo:^{
        [self.goodsInfoTableView reloadData];
    }];
    
    self.goodsInfoTableView.tableHeaderView = _goodInfoView;
    CGRect headerCgrect = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width + 280);
    self.goodsInfoTableView.tableHeaderView.frame = headerCgrect;

    [self.goodsInfoTableView reloadData];
}

#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!_dataModel) {
        return 0;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataModel.shopInfoBtnSelect) {
        LCGoodsInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"goodsInfoTableViewCell"];
        cell.model = self.dataModel;
        return cell;
    }
    if (self.dataModel.guideInfoBtnSelect) {
        LCGuideShouldKnowCell *cell = [tableView dequeueReusableCellWithIdentifier:@"guideShouldKnowCell"];
        cell.guideInfoStr = self.dataModel.content;
        return cell;
    }
    
    return nil;
}

#pragma mark - lazy
- (UITableView *)goodsInfoTableView
{
    if (!_goodsInfoTableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.estimatedRowHeight = 500;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.backgroundColor = [UIColor colorWithRed:30.0 / 255.0 green:33.0 / 255.0 blue:37.0 / 255.0 alpha:1];
        
        [self addSubview:tableView];
        [tableView registerNib:[UINib nibWithNibName:@"LCGoodsInfoTableViewCell" bundle:nil] forCellReuseIdentifier:@"goodsInfoTableViewCell"];
        [tableView registerNib:[UINib nibWithNibName:@"LCGuideShouldKnowCell" bundle:nil] forCellReuseIdentifier:@"guideShouldKnowCell"];
        _goodsInfoTableView = tableView;
    }
    
    return _goodsInfoTableView;
}

@end
