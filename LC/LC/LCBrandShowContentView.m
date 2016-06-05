//
//  LCBrandShowContentView.m
//  LC
//
//  Created by JustBill on 16/5/27.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import "LCBrandShowContentView.h"
#import "LCShopShowCollectionViewCell.h"
#import "LCBrandShowModel.h"
#import "LCPublicGoodsInfoViewController.h"

@interface LCBrandShowContentView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic ,weak) UICollectionView *brandCollectionView;

@property (nonatomic ,weak) UIImageView *brandShowHead;

@property (nonatomic ,weak) UIImageView *brandHeadImage;

@property (nonatomic ,weak) UILabel *brandNameLabel;

@property (nonatomic ,weak) UIButton *storyBtn;

@property (nonatomic ,weak) UIButton *productBtn;

@property (nonatomic ,weak) UIView *descriptionView;

@property (nonatomic ,weak) UILabel *descriptionLabel;

@end

@implementation LCBrandShowContentView

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.brandShowHead.frame = CGRectMake(0, 0, self.frame.size.width, 126);
    
    self.storyBtn.frame = CGRectMake(0, 126, self.frame.size.width / 2, 30);
    
    self.productBtn.frame = CGRectMake(self.frame.size.width / 2, 126, self.frame.size.width / 2, 30);
    
    self.descriptionView.frame = CGRectMake(0, 156, self.frame.size.width, self.frame.size.height - 156 - 64);
    
    self.descriptionLabel.frame = CGRectMake(10, 10, self.frame.size.width - 20, self.descriptionView.frame.size.height - 20);
    
    self.brandCollectionView.frame = CGRectMake(0, 156, self.frame.size.width, self.frame.size.height - 156 - 64 - 49);
    
    self.storyBtn.selected = NO;
    self.productBtn.selected = YES;
}

#pragma mark - setter
- (void)setModelArr:(NSArray *)modelArr
{
    _modelArr = modelArr;
    
    //设置brandHead头像
    CGFloat center = self.frame.size.width / 2;
    self.brandHeadImage.frame = CGRectMake(center - 33, 15, 66, 66);
    self.brandHeadImage.layer.masksToBounds = YES;
    self.brandHeadImage.layer.cornerRadius = self.brandHeadImage.bounds.size.width / 2;
    LCBrandShowModel *model = modelArr.firstObject;
    [self.brandHeadImage sd_setImageWithURL:[NSURL URLWithString:model.brand_logo]];
    
    //设置brandNameLabel的名字
    self.brandNameLabel.frame = CGRectMake(30, 85, self.frame.size.width - 60, 40);
    self.brandNameLabel.text = model.brand_name;
    
    //这里设置行间距
    NSString *labelText = [NSString stringWithFormat:@"%@\n \n \n \n \n \n \n \n \n \n",model.brand_desc];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:8];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    [self.descriptionLabel setAttributedText:attributedString];
    [self.descriptionLabel sizeToFit];
    
    [self.brandCollectionView reloadData];
}

#pragma mark - UICollectionViewDataSource
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    LCBrandShowModel *model = self.modelArr[indexPath.row];
    LCPublicGoodsInfoViewController *goodInfoVC = [[LCPublicGoodsInfoViewController alloc] initWithUrl:model.goods_id];
    
    UIViewController *vc = [self viewController];
    [vc.navigationController pushViewController:goodInfoVC animated:YES];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.modelArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LCShopShowCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"brandCollectionViewCell" forIndexPath:indexPath];
    
    cell.model = self.modelArr[indexPath.row];
    
    return cell;
}

#pragma mark - lazy
- (UIView *)brandShowHead
{
    if (!_brandShowHead) {
        UIImageView *view = [[UIImageView alloc] init];
        view.image = [UIImage imageNamed:@"brand_bg"];
        
        [self addSubview:view];
        _brandShowHead = view;
    }
    
    return _brandShowHead;
}

- (UIImageView *)brandHeadImage
{
    if (!_brandHeadImage) {
        UIImageView *view = [[UIImageView alloc] init];
        view.backgroundColor = [UIColor clearColor];
        
        [self addSubview:view];
        _brandHeadImage = view;
    }
    
    return _brandHeadImage;
}

- (UILabel *)brandNameLabel
{
    if (!_brandNameLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:18];
        label.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:label];
        _brandNameLabel = label;
    }
    
    return _brandNameLabel;
}

- (UIButton *)storyBtn
{
    if (!_storyBtn) {
        UIButton *storyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [storyBtn setTitle:@"品牌故事" forState:UIControlStateNormal];
        [storyBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        storyBtn.backgroundColor = [UIColor colorWithRed:48.0 / 255.0 green:56.0 / 255.0 blue:64.0 / 255.0 alpha:1];
        [storyBtn setBackgroundImage:[UIImage imageNamed:@"白色背景"] forState:UIControlStateSelected];
        storyBtn.tag = 1;
        [storyBtn addTarget:self action:@selector(storyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:storyBtn];
        _storyBtn = storyBtn;
    }
    
    return _storyBtn;
}
        
- (UIButton *)productBtn
{
    if (!_productBtn) {
        UIButton *productBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [productBtn setTitle:@"品牌产品" forState:UIControlStateNormal];
        [productBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        productBtn.backgroundColor = [UIColor colorWithRed:48.0 / 255.0 green:56.0 / 255.0 blue:64.0 / 255.0 alpha:1];
        [productBtn setBackgroundImage:[UIImage imageNamed:@"白色背景"] forState:UIControlStateSelected];
        productBtn.tag = 2;
        [productBtn addTarget:self action:@selector(productBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:productBtn];
        _productBtn = productBtn;
    }
    
    return _productBtn;
}

- (UIView *)descriptionView
{
    if (!_descriptionView) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor clearColor];
        
        [self addSubview:view];
        _descriptionView = view;
    }
    
    return _descriptionView;
}

- (UILabel *)descriptionLabel
{
    if (!_descriptionLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:12];
        label.numberOfLines = 0;
        
        [self.descriptionView addSubview:label];
        _descriptionLabel = label;
    }
    
    return _descriptionLabel;
}

- (UICollectionView *)brandCollectionView
{
    if (!_brandCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        layout.minimumLineSpacing = 10;
        
        layout.minimumInteritemSpacing = 10;
        
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        
        CGFloat width = (self.frame.size.width - 30 ) / 2 ;
        layout.itemSize = CGSizeMake(width, width * 215 / 145);
        
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        UICollectionView *view = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        view.backgroundColor = [UIColor colorWithRed:26.0 / 255.0 green:26.0 / 255.0 blue:26.0 / 255.0 alpha:1];
        view.delegate = self;
        view.dataSource = self;
        
        [self addSubview:view];
        [view registerNib:[UINib nibWithNibName:@"LCShopShowCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"brandCollectionViewCell"];
        _brandCollectionView = view;
    }
    
    return _brandCollectionView;
}

#pragma mark - 按钮点击事件
- (void)storyBtnClick:(UIButton *)sender
{
    if (sender.selected) {
        
    }else {
        UIButton *productBtn = [self viewWithTag:2];
        productBtn.selected = NO;
        
        sender.selected = !sender.selected;
        //将品牌故事页面放到最前面
        self.brandCollectionView.hidden = YES;
        self.descriptionView.hidden = NO;
    }
    
}

- (void)productBtnClick:(UIButton *)sender
{
    if (sender.selected) {
        
    }else {
        UIButton *storyBtn = [self viewWithTag:1];
        storyBtn.selected = NO;
        
        sender.selected = !sender.selected;
        //将品牌产品放到最前面
        self.descriptionView.hidden = YES;
        self.brandCollectionView.hidden = NO;
    }
    
}

#pragma mark - 获取父视图控制器
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
