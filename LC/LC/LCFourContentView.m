//
//  LCFourContentView.m
//  LC
//
//  Created by JustBill on 16/5/24.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import "LCFourContentView.h"
#import "LCFourCollectionViewCell.h"
#import "LCFourModel.h"

@interface LCFourContentView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    LCFourContentStratRefreshControlCallBack _lcFourContentStratRefreshControlCallBack;
    LCFourContentLoadingMoerCallBack _lcFourContentLoadingMoerCallBack;
}

//@property (nonatomic ,weak)UIView *navigationbarView;
//
//@property (nonatomic ,weak)UILabel *naviTitleLabel;

@property (nonatomic ,weak)UICollectionView *fourCollectionView;

@end

@implementation LCFourContentView

- (void)layoutSubviews
{
    [super layoutSubviews];
    
//    self.navigationbarView.frame = CGRectMake(0, 0, self.frame.size.width, 64);
//    
//    self.naviTitleLabel.frame = CGRectMake(0, 20, self.frame.size.width, 44);
    
    self.fourCollectionView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 49);
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.modelArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LCFourCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"fourcollectioncell" forIndexPath:indexPath];
    LCFourModel *model = self.modelArr[indexPath.row];
    
    cell.model = model;
    
    return cell;
}

#pragma mark - setter
- (void)setModelArr:(NSArray *)modelArr
{
    _modelArr = modelArr;
    
    [self.fourCollectionView reloadData];
}

- (void)setLCFourContentStratRefreshControlCallBack:(LCFourContentStratRefreshControlCallBack)callback
{
    _lcFourContentStratRefreshControlCallBack = callback;
}

- (void)setLCFourContentLoadingMoerCallBack:(LCFourContentLoadingMoerCallBack)callback
{
    _lcFourContentLoadingMoerCallBack = callback;
}

#pragma mark - other
- (void)stopRefresh
{
    if ([self.fourCollectionView.mj_header isRefreshing]) {
        [self.fourCollectionView.mj_header endRefreshing];
    }
    
    if ([self.fourCollectionView.mj_footer isRefreshing]) {
        [self.fourCollectionView.mj_footer endRefreshing];
    }
}

//#pragma mark - lazy
////自定义navigationbar
//- (UIView *)navigationbarView
//{
//    if (!_navigationbarView) {
//        UIView *view = [[UIView alloc] init];
//        view.backgroundColor = [UIColor blackColor];
//        
//        [self addSubview:view];
//        _navigationbarView = view;
//    }
//    return _navigationbarView;
//}
//
//- (UILabel *)naviTitleLabel
//{
//    if (!_naviTitleLabel) {
//        UILabel *label = [[UILabel alloc] init];
//        label.backgroundColor = [UIColor clearColor];
//        label.text = @"达人";
//        label.textAlignment = NSTextAlignmentCenter;
//        label.textColor = [UIColor whiteColor];
//        
//        [self.navigationbarView addSubview:label];
//        _naviTitleLabel = label;
//    }
//    
//    return _naviTitleLabel;
//}

- (UICollectionView *)fourCollectionView
{
    if (!_fourCollectionView) {
        
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //cell之间最小左右距离
        layout.minimumInteritemSpacing = 9;
        
        //cell之间最小上下距离
        layout.minimumLineSpacing = 9;
        
        //设置滚动方向
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        
        CGFloat itemWidth = (self.frame.size.width - 40) / 3;
        
        layout.itemSize = CGSizeMake(itemWidth ,itemWidth * 132 / 95 );
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor colorWithRed:26.0 / 255.0 green:26.0 / 255.0 blue:26.0 / 255.0 alpha:1];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        
        [self addSubview:collectionView];
        
        [collectionView registerNib:[UINib nibWithNibName:@"LCFourCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"fourcollectioncell"];
        
        
        //设置下拉刷新
        collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            //刷新回调
            if (_lcFourContentStratRefreshControlCallBack) {
                _lcFourContentStratRefreshControlCallBack();
            }
        }];
        
        //设置下拉加载更多
        collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            //上拉加载更多
            if (_lcFourContentLoadingMoerCallBack) {
                _lcFourContentLoadingMoerCallBack();
            }
        }];
        
        
        _fourCollectionView = collectionView;
    }
    
    return _fourCollectionView;
}

@end
