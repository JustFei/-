//
//  LCTwoCategoryContentView.m
//  LC
//
//  Created by JustBill on 16/5/20.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import "LCTwoCategoryContentView.h"
#import "LCTwoCategoryCollectionViewCell.h"
#import "LCTwoCategoryModel.h"

@interface LCTwoCategoryContentView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>


@end

@implementation LCTwoCategoryContentView



- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //这里减去的73是标签头的高度，在LCTwoContentView里面设置的，如果需要更改从那里修改
    self.twoCategoryCollectionView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 73);
    
}

#pragma mark - UICollectionViewDataSource
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //如果是第0个的话，就不做操作，第一个的话就传第一个url
    if (indexPath.row == 0) {
        
    }else if (indexPath.row == 1) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"selectCollectionCell1" object:kTwoUrl];
    }
    else{
        //这里涉及cell的点击效果
        LCTwoCategoryModel *model = _modelArr[indexPath.row - 2];
        //思路：这里可以注册一个通知中心，然后将model传进去。
        [[NSNotificationCenter defaultCenter] postNotificationName:@"selectCollectionCell2" object:model];
    }
}

//返回段数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//返回每段的个数，（不需要返回每行的个数，因为collectionView会根据你的layout来自动调整每行有几个Cell）
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (!self.modelArr.count) {
        return 2;
    }
    return self.modelArr.count + 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LCTwoCategoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectioncell" forIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        NSLog(@"%ld",indexPath.row);
        cell.imgView.image = [UIImage imageNamed:@"spec_favour_bg"];
        cell.titleLabel.text = @"我的收藏";
        //cell.iconImgView.image = [UIImage imageNamed:@"spec_favour_icon"];
        
        return cell;
    }else if (indexPath.row == 1) {
        NSLog(@"%ld",indexPath.row);
        cell.imgView.image = [UIImage imageNamed:@"spec_all_bg"];
        cell.titleLabel.text = @"所有杂志";
        //cell.iconImgView.image = [UIImage imageNamed:@"spec_all_icon"];
        
        return cell;
    }
    
    LCTwoCategoryModel *model = self.modelArr[indexPath.row - 2 ];
    
    cell.model = model;
    
    return cell;
}

#pragma mark - setter
- (void)setModelArr:(NSArray *)modelArr
{
    _modelArr = modelArr;
    
    [self.twoCategoryCollectionView reloadData];
}

#pragma mark - lazy
- (UICollectionView *)twoCategoryCollectionView
{
    if (!_twoCategoryCollectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //cell之间最小左右距离
        layout.minimumInteritemSpacing = 18;
        
        //cell之间最小上下距离
        layout.minimumLineSpacing = 18;
        
        //设置滚动方向
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        layout.sectionInset = UIEdgeInsetsMake(18, 18, 18, 18);
        
        CGFloat itemWidth = (self.frame.size.width - 54) / 2;
        
        layout.itemSize = CGSizeMake(itemWidth ,itemWidth * 190 / 260 );
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor colorWithRed:218.0 / 255.0 green:224.0 / 255.0 blue:230.0 / 255.0 alpha:1];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        
        
        [self addSubview:collectionView];
        //注册
        [collectionView registerNib:[UINib nibWithNibName:@"LCTwoCategoryCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"collectioncell"];
        _twoCategoryCollectionView = collectionView;
    }
    
    return _twoCategoryCollectionView;
}

#pragma mark - dealloc
- (void)dealloc
{
    //移除当前控制器对象所有的通知中心
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
