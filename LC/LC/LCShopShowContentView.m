//
//  LCShopShowContentView.m
//  LC
//
//  Created by JustBill on 16/5/26.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import "LCShopShowContentView.h"
#import "LCShopShowCollectionViewCell.h"
#import "LCPublicGoodsInfoViewController.h"

@interface LCShopShowContentView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    LCShopShowStratRefreshControlCallBack _lcshopShowStratRefreshControlCallBack;
    LCShopShowLoadingMoerCallBack _lcshopShowLoadingMoerCallBack;
    BOOL _isOpen;
}

@property (nonatomic ,weak) UIView *priceChooseView;
@property (nonatomic ,weak) UICollectionView *shopShowCollectionView;

@end

@implementation LCShopShowContentView

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.shopShowCollectionView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 49);
    
    
    //这里是价格选择列表的打开和闭合
    //self.priceChooseView.frame = CGRectMake(0, 0, self.frame.size.width, 40);
}

#pragma mark - UICollectionViewDataSource
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    LCShopShowModel *model = _modelArr[indexPath.row];
    UIViewController *selfVc = [self viewController];
    
    //在这里执行push过程，并传参数过去
    LCPublicGoodsInfoViewController *vc = [[LCPublicGoodsInfoViewController alloc] initWithUrl:model.goods_id];
    [selfVc.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.modelArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LCShopShowCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"shopshowcollectioncell" forIndexPath:indexPath];
    
    cell.model = self.modelArr[indexPath.row];
    
    return cell;
}

#pragma mark - setter

- (void)setLCShopShowStratRefreshControlCallBack:(LCShopShowStratRefreshControlCallBack)callback
{
    _lcshopShowStratRefreshControlCallBack = callback;
}

- (void)setShopShowLoadingMoerCallBack:(LCShopShowLoadingMoerCallBack)callback
{
    _lcshopShowLoadingMoerCallBack = callback;
}

- (void)setModelArr:(NSArray *)modelArr
{
    _modelArr = modelArr;
    
    [self.shopShowCollectionView reloadData];
    
}

#pragma mark - other
- (void)stopRefresh
{
    if ([self.shopShowCollectionView.mj_header isRefreshing]) {
        [self.shopShowCollectionView.mj_header endRefreshing];
    }
    
    if ([self.shopShowCollectionView.mj_footer isRefreshing]) {
        [self.shopShowCollectionView.mj_footer endRefreshing];
    }
}

#pragma mark - lazy
//价格label标签，待会记得添加一个点击手势
- (UIView *)priceChooseView
{
    if (!_priceChooseView) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        
        for (int i = 0; i < 7; i ++) {
            UIButton *label = [[UIButton alloc] initWithFrame:CGRectMake(0, i * 40, self.frame.size.width, 40)];
//            label.textAlignment = NSTextAlignmentLeft;
            [label setTintColor: [UIColor blackColor]];
            label.backgroundColor = [UIColor redColor];
            label.titleLabel.font = [UIFont systemFontOfSize:13];
            label.titleLabel.textAlignment = NSTextAlignmentLeft;
            label.tag = 100 + i;
//            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector()];
            if (i == 0) {
                [label addTarget:self action:@selector(spreadPriceList) forControlEvents:UIControlEventTouchUpInside];
            }
            
            
            switch (i) {
                case 0:
                    [label setTitle:@"    价格筛选" forState:UIControlStateNormal];
                    break;
                case 1:
//                    label.text = @"    全部";
                    break;
                case 2:
//                    label.text = @"    0-200";
                    break;
                case 3:
//                    label.text = @"    201-500";
                    break;
                case 4:
//                    label.text = @"    501-1000";
                    break;
                case 5:
//                    label.text = @"    1001-3000";
                    break;
                case 6:
//                    label.text = @"    3000以上";
                    break;
                    
                default:
                    break;
            }
            [view addSubview:label];
        }
        
        [self addSubview:view];
        _priceChooseView = view;
    }
    
    return _priceChooseView;
}

- (void)spreadPriceList
{
    if (_isOpen) {
        [UIView animateWithDuration:0.5 animations:^{
            self.priceChooseView.frame = CGRectMake(0, 0, self.frame.size.width, 280);
        }];
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            self.priceChooseView.frame = CGRectMake(0, 0, self.frame.size.width, 40);
        }];
    }
    _isOpen = !_isOpen;
}


//collectionView的加载
- (UICollectionView *)shopShowCollectionView
{
    if (!_shopShowCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumInteritemSpacing = 10;
        layout.minimumLineSpacing = 10;
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        CGFloat width = (self.frame.size.width - 30) / 2;
        layout.itemSize = CGSizeMake(width, width * 215 / 145);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        UICollectionView *view = [[UICollectionView alloc] initWithFrame:CGRectZero  collectionViewLayout:layout];
        view.backgroundColor = [UIColor colorWithRed:35.0/255.0 green:38.0/255.0 blue:41.0/255.0 alpha:1];
        view.delegate = self;
        view.dataSource = self;
        
        [self addSubview:view];
        [view registerNib:[UINib nibWithNibName:@"LCShopShowCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"shopshowcollectioncell"];
        
        //设置下拉刷新
        view.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            //刷新回调
            if (_lcshopShowStratRefreshControlCallBack) {
                _lcshopShowStratRefreshControlCallBack();
            }
        }];
        
        //设置下拉加载更多
        view.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            //上拉加载更多
            if (_lcshopShowLoadingMoerCallBack) {
                _lcshopShowLoadingMoerCallBack();
            }
        }];
        
        _shopShowCollectionView = view;
    }
    
    return _shopShowCollectionView;
}

#pragma mark - 获取父视图的方法
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

@end
