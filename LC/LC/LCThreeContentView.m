//
//  LCThreeContentView.m
//  LC
//
//  Created by JustBill on 16/5/24.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import "LCThreeContentView.h"
#import "LCThreeCollectionViewCell.h"
#import "LCThreeModel.h"


@interface LCThreeContentView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    LCThreeContentStratRefreshControlCallBack _lcThreeContentStratRefreshControlCallBack;
    LCThreeContentLoadingMoerCallBack _lcThreeContentLoadingMoerCallBack;
}

//@property (nonatomic ,weak)UIView *navigationbarView;

//@property (nonatomic ,weak)UILabel *naviTitleLabel;

@property (nonatomic ,weak)UICollectionView *threeCollectionView;

@end

@implementation LCThreeContentView

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.threeCollectionView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 49 );
}

#pragma mark - UICollectionViewDataSource
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.modelArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LCThreeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"threecollectioncell" forIndexPath:indexPath];
    LCThreeModel *model = self.modelArr[indexPath.row];
    
    cell.model = model;
    
    return cell;
}

#pragma mark - setter
- (void)setModelArr:(NSArray *)modelArr
{
    _modelArr = modelArr;
    
    [self.threeCollectionView reloadData];
}

- (void)setLCThreeContentStratRefreshControlCallBack:(LCThreeContentStratRefreshControlCallBack)callback
{
    _lcThreeContentStratRefreshControlCallBack = callback;
}

- (void)setLCThreeContentLoadingMoerCallBack:(LCThreeContentLoadingMoerCallBack)callback
{
    _lcThreeContentLoadingMoerCallBack = callback;
}

#pragma mark - other
- (void)stopRefresh
{
    if ([self.threeCollectionView.mj_header isRefreshing]) {
        [self.threeCollectionView.mj_header endRefreshing];
    }
    
    if ([self.threeCollectionView.mj_footer isRefreshing]) {
        [self.threeCollectionView.mj_footer endRefreshing];
    }
}

#pragma mark - lazy
//自定义navigationbar
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

//- (UILabel *)naviTitleLabel
//{
//    if (!_naviTitleLabel) {
//        UILabel *label = [[UILabel alloc] init];
//        label.backgroundColor = [UIColor clearColor];
//        label.text = @"分享";
//        label.textAlignment = NSTextAlignmentCenter;
//        label.textColor = [UIColor whiteColor];
//        
//        [self.navigationbarView addSubview:label];
//        _naviTitleLabel = label;
//    }
//    
//    return _naviTitleLabel;
//}

- (UICollectionView *)threeCollectionView
{
    if (!_threeCollectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //cell之间最小左右距离
        layout.minimumInteritemSpacing = 10;
        
        //cell之间最小上下距离
        layout.minimumLineSpacing = 10;
        
        //设置滚动方向
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        
        CGFloat itemWidth = (self.frame.size.width - 30) / 2;
        
        layout.itemSize = CGSizeMake(itemWidth ,itemWidth );
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor colorWithRed:26.0 / 255.0 green:26.0 / 255.0 blue:26.0 / 255.0 alpha:1];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        
        [self addSubview:collectionView];
        
        [collectionView registerNib:[UINib nibWithNibName:@"LCThreeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"threecollectioncell"];
        
        //设置下拉刷新
        collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            //刷新回调
            if (_lcThreeContentStratRefreshControlCallBack) {
                _lcThreeContentStratRefreshControlCallBack();
            }
        }];
        
        //设置下拉加载更多
        collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            //上拉加载更多
            if (_lcThreeContentLoadingMoerCallBack) {
                _lcThreeContentLoadingMoerCallBack();
            }
        }];
        
        _threeCollectionView = collectionView;
    }
    
    return _threeCollectionView;
}

@end
