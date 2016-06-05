//
//  LCGoodsInfo.m
//  LC
//
//  Created by JustBill on 16/5/31.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import "LCGoodsInfo.h"
#import "LCPublicBrandShowViewController.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@interface LCGoodsInfo ()<UIScrollViewDelegate>
{
    ShowShopInfo  _showShopInfo;
    ShowGuideInfo _showGuideInfo;
}
@end

@implementation LCGoodsInfo

#pragma mark - setter
- (void)setDataModel:(LCGoodsInfoModel *)dataModel
{
    _dataModel = dataModel;
    
    _brandNameLabel.text = dataModel.brand_name;
    _goodNameLabel.text = dataModel.goods_name;
    _priceLabel.text = [NSString stringWithFormat:@"￥%@",dataModel.price];
    _likeContentLabel.text = dataModel.like_count;
    _brandInfoLabel.text = dataModel.brand_name;
    [_brandHeadImg sd_setImageWithURL:[NSURL URLWithString:dataModel.brand_logo]];
    
    [self addTapGes];
    
    [self creatScrollView:dataModel.images_item];
}

#pragma mark -setblock
- (void)setShowShopInfo:(ShowShopInfo)callback
{
    _showShopInfo = callback;
}

- (void)setShowGuideInfo:(ShowGuideInfo)callback
{
    _showGuideInfo = callback;
}

#pragma mark - other
- (void)addTapGes
{
    UITapGestureRecognizer *brandInfoLabelTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToBrandShowController)];
    
    _brandInfoLabel.userInteractionEnabled = YES;
    [_brandInfoLabel addGestureRecognizer:brandInfoLabelTap];
    
    UITapGestureRecognizer *skuInfoLabelTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(upSelectView)];
    
    _skuInfoLabel.userInteractionEnabled = YES;
    [_skuInfoLabel addGestureRecognizer:skuInfoLabelTap];
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

- (void)creatScrollView:(NSArray *)sliderArr
{
    //设置page
    _pageControl.numberOfPages = sliderArr.count;
    _pageControl.backgroundColor = [UIColor clearColor];
    //未走的颜色
    _pageControl.pageIndicatorTintColor = [UIColor grayColor];
    
    //当前page的颜色
    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    
    [_pageControl addTarget:self action:@selector(imageMove) forControlEvents:UIControlEventValueChanged];
    
    NSInteger pageCount = sliderArr.count + 2;
    _headScrollView.contentSize = CGSizeMake(pageCount * kScreenWidth , 0);
    
    _headScrollView.delegate = self;
    for (int i = 0; i < pageCount; i ++) {
        UIImageView *img = [[UIImageView alloc] init];
        img.contentMode = UIViewContentModeScaleAspectFit;
        
        //第一张图的时候,i = 0
        if (i == 0) {
            img.frame = CGRectMake(0, 0, kScreenWidth, kScreenWidth);
            [img sd_setImageWithURL:[NSURL URLWithString:sliderArr[sliderArr.count - 1]]];
        } else
            //第七张图的时候 i = 6;
            if (i == (pageCount - 1)) {
                img.frame = CGRectMake(i  * kScreenWidth, 0, kScreenWidth, kScreenWidth);
                [img sd_setImageWithURL:[NSURL URLWithString:sliderArr[0]]];
            }else
            {
                //2-6张图的时候 i = 1-5
                img.frame = CGRectMake(i * kScreenWidth, 0, kScreenWidth, kScreenWidth);
                
                [img sd_setImageWithURL:[NSURL URLWithString:sliderArr[i - 1]]];
            }
        [_headScrollView addSubview:img];
    }
    _headScrollView.contentOffset = CGPointMake(kScreenWidth, 0);
}

#pragma mark - UIScrollViewDelegate
//手动滑动图片时触发
//图片停止移动时调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    NSArray *slideArr = _dataModel.images_item;
    NSInteger pageCount = slideArr.count + 2;
    
    NSInteger index = scrollView.contentOffset.x / kScreenWidth;
    
    //index == 0显示的第四张图片
    if (index == 0) {
        [_headScrollView setContentOffset:CGPointMake(kScreenWidth * (pageCount - 2), 0) animated:NO];
        _pageControl.currentPage = pageCount - 1;
    }
    
    //index == 5显示的是第一张图片
    else if(index == pageCount - 1)
    {
        [_headScrollView setContentOffset:CGPointMake(kScreenWidth, 0) animated:NO];
        _pageControl.currentPage = 0;
    }
    else
    {
        _pageControl.currentPage = index - 1;
    }
}

#pragma mark - 点击事件
//pageControl
- (void)imageMove
{
    [_headScrollView setContentOffset:CGPointMake((_pageControl.currentPage + 1) * kScreenWidth, 0) animated:YES];
}

//商品详情按钮点击
- (IBAction)shopInfoButtonClick:(UIButton *)sender {
    
    if (sender.selected) {
        
    }else {
        UIButton *guideBtn = [self viewWithTag:2];
        guideBtn.selected = NO;
        
        sender.selected = !sender.selected;
        _dataModel.shopInfoBtnSelect = YES;
        _dataModel.guideInfoBtnSelect = NO;
        
        if (_showShopInfo) {
            _showShopInfo();
        }
    }
    
}

//购物须知按钮点击
- (IBAction)guideShouldKnowButtonClick:(UIButton *)sender {
    
    if (sender.selected) {
        
    }else {
        UIButton *shopBtn = [self viewWithTag:1];
        shopBtn.selected = NO;
        
        sender.selected = !sender.selected;
        _dataModel.shopInfoBtnSelect = NO;
        _dataModel.guideInfoBtnSelect = YES;
        
        if (_showGuideInfo) {
            _showGuideInfo();
        }
    }
    
}

//品牌名字label点击
- (void)pushToBrandShowController
{
    LCPublicBrandShowViewController *vc = [[LCPublicBrandShowViewController alloc] init];
    vc.iD = self.dataModel.brand_id;
    
    UIViewController *selfVc = [self viewController];
    [selfVc.navigationController pushViewController:vc animated:YES];
}

- (IBAction)likeButtonClick:(UIButton *)sender
{
    if (_likeBtn.selected) {
        _likeContentLabel.text = [NSString stringWithFormat:@"%ld",(_likeContentLabel.text.integerValue - 1)];
    }else {
        _likeContentLabel.text = [NSString stringWithFormat:@"%ld",(_likeContentLabel.text.integerValue + 1)];
    }
    
#warning 这里设置保存该商品id到心愿单数据库
    _likeBtn.selected = !_likeBtn.selected;
}

//选择尺码颜色数量label点击
- (void)upSelectView
{
    
}

@end
