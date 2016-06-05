//
//  LCHomePageContentView.m
//  LC
//
//  Created by JustBill on 16/5/18.
//  Copyright © 2016年 邢谢飞. All rights reserved.
//

#import "LCHomePageContentView.h"
#import "LCHomePageModel.h"
#import "LCHomePageSlideModel.h"
#import "LCHomePageListModel.h"
#import "LCPublicWebModel.h"

@interface LCHomePageContentView ()<UIScrollViewDelegate>
{
    HomePageContentViewButtonClickCallBack _homePageContentViewButtonClickCallBack;
}
@property (nonatomic ,strong)UIPageControl *page;

@end

@implementation LCHomePageContentView

#pragma mark - setter方法
- (void)setPageModel:(LCHomePageModel *)pageModel
{
    _pageModel = pageModel;
    _headScrollView.showsHorizontalScrollIndicator = FALSE;
    
    NSArray *slideArr = pageModel.slideArr;
    NSArray *listArr = pageModel.listArr;
    
    //配置page的属性
    _page = [[UIPageControl alloc] initWithFrame:CGRectMake(0, _headScrollView.frame.size.height - 20, _headScrollView.frame.size.width, 20)];
    _page.numberOfPages = slideArr.count;
    _page.backgroundColor = [UIColor clearColor];
    //未走的颜色
    _page.pageIndicatorTintColor = [UIColor grayColor];
    
    //当前page的颜色
    _page.currentPageIndicatorTintColor = [UIColor whiteColor];
    
    [_page addTarget:self action:@selector(imageMove) forControlEvents:UIControlEventValueChanged];
    
    [self.homePageScrollView addSubview:_page];
    
    [self setButtonImage:listArr];
    
    [self setScrollViewImage:slideArr];
    
}

- (void)setHomePageContentViewButtonClickCallBack:(HomePageContentViewButtonClickCallBack)callback
{
    _homePageContentViewButtonClickCallBack = callback;
}

#pragma mark -pageControl的点击事件
//pageControl
- (void)imageMove
{
    [_headScrollView setContentOffset:CGPointMake((_page.currentPage + 1) * self.frame.size.width, 0) animated:YES];
}

#pragma mark - 设置定时器
- (void)setNSTimer:(NSInteger)pageCount
{
    [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(offset) userInfo:nil repeats:YES];
}
//定时器的偏移事件
- (void)offset
{
    [_headScrollView setContentOffset:CGPointMake(_headScrollView.contentOffset.x + _headScrollView.frame.size.width, 0) animated:YES];
}

#pragma mark - 通过数据源设置图片
#pragma mark -设置scrollView的图片
- (void)setScrollViewImage:(NSArray *)slideArr
{
    NSInteger pageCount = slideArr.count + 2;
    _headScrollView.contentSize = CGSizeMake(pageCount * self.frame.size.width, 0);
    _headScrollView.delegate = self;
    for (int i = 0; i < pageCount; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        //第一张图的时候,i = 0
        if (i == 0) {
            btn.frame = CGRectMake(0, 0, self.frame.size.width, _headScrollView.frame.size.height);
            LCHomePageSlideModel *model = slideArr[slideArr.count - 1];
            [btn sd_setBackgroundImageWithURL:[NSURL URLWithString:model.pic_url] forState:UIControlStateNormal];
        } else
            //第七张图的时候 i = 6;
            if (i == (pageCount - 1)) {
                btn.frame = CGRectMake(i  * self.frame.size.width, 0, self.frame.size.width, _headScrollView.frame.size.height);
                LCHomePageSlideModel *model = slideArr[0];
                [btn sd_setImageWithURL:[NSURL URLWithString:model.pic_url] forState:UIControlStateNormal];
            }else
            {
                //2-6张图的时候 i = 1-5
                btn.frame = CGRectMake(i * self.frame.size.width, 0, self.frame.size.width, _headScrollView.frame.size.height);
                LCHomePageSlideModel *model = slideArr[i - 1];
                [btn sd_setImageWithURL:[NSURL URLWithString:model.pic_url] forState:UIControlStateNormal];
                btn.tag = 100 + i;
                [btn addTarget:self action:@selector(scrollViewButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            }
        
        [_headScrollView addSubview:btn];
    }
    _headScrollView.contentOffset = CGPointMake(self.headScrollView.frame.size.width, 0);
    [self setNSTimer:pageCount];
}

#pragma mark -设置button的图片
- (void)setButtonImage: (NSArray *)listArr
{
    for (int i = 0 ; i < listArr.count; i ++) {
        
        LCHomePageListModel *model = listArr[i];
        NSString *url = model.pic_url;
        NSLog(@"%@",model.topic_url);
        
        UIButton *myButton1 = (UIButton *)[self viewWithTag:i + 1];
        [myButton1 sd_setBackgroundImageWithURL:[NSURL URLWithString:url] forState:UIControlStateNormal];
    }
}
#pragma mark - 点击事件
//scrollView点击事件
- (void)scrollViewButtonClick:(UIButton *)sender {
    
    if (_pageModel) {
        [self clickButtonPushController:sender.tag];
    }
}

//剩下的button的点击事件
- (IBAction)buttonAction:(UIButton *)sender {
    
    if (_pageModel) {
        [self clickButtonPushController:sender.tag];
    }
}

//点击btn触发的方法
- (void)clickButtonPushController:(NSInteger)index;
{
    
    if (index > 100) {
        NSArray *slideArr = _pageModel.slideArr;
        LCHomePageSlideModel *model = slideArr[index - 101];
        NSString *url = model.topic_url;
        if ([url isEqualToString:@""] ) {
            //判断topic_url是否有值，这里执行无值得操作：跳转到商品列表页面
            if (_homePageContentViewButtonClickCallBack) {
                _homePageContentViewButtonClickCallBack(model.content_id);
            }
        }else {
            //这里执行topic_url有值得操作
            LCPublicWebModel *webModel = [[LCPublicWebModel alloc] init];
            webModel.webUrl = model.topic_url;
            webModel.imageUrl = model.pic_url;
            webModel.title = model.topic_name;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"homePageContentViewPushPublicWebView" object:webModel];
        }
    }else{
    
    NSArray *listArr = _pageModel.listArr;
    LCHomePageListModel *model = listArr[index - 1];
    NSString *url = model.topic_url;
    if ([url isEqualToString:@""] ) {
        //判断topic_url是否有值，这里执行无值得操作：跳转到商品列表页面
        if (_homePageContentViewButtonClickCallBack) {
            //NSString *goodUrl = [NSString stringWithFormat:kGoodsUrl,model.content_id];
            _homePageContentViewButtonClickCallBack(model.content_id);
        }
    }else {
        //这里执行topic_url有值得操作
        LCPublicWebModel *webModel = [[LCPublicWebModel alloc] init];
        webModel.webUrl = model.topic_url;
        webModel.imageUrl = model.pic_url;
        webModel.title = model.topic_name;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"homePageContentViewPushPublicWebView" object:webModel];
    }
    }
}

#pragma mark - UIScrollViewDelegate
//手动滑动图片时触发
//图片停止移动时调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    NSArray *slideArr = self.pageModel.slideArr;
    NSInteger pageCount = slideArr.count + 2;
    
    NSInteger index = scrollView.contentOffset.x / _headScrollView.frame.size.width;
    
    //index == 0显示的第四张图片
    if (index == 0) {
        [_headScrollView setContentOffset:CGPointMake(_headScrollView.frame.size.width * (pageCount - 2), 0) animated:NO];
        _page.currentPage = pageCount - 1;
    }
    
    //index == 5显示的是第一张图片
    else if(index == pageCount - 1)
    {
        [_headScrollView setContentOffset:CGPointMake(_headScrollView.frame.size.width, 0) animated:NO];
        _page.currentPage = 0;
    }
    else
    {
        _page.currentPage = index - 1;
    }
}

//动画结束后调用
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSArray *slideArr = self.pageModel.slideArr;
    NSInteger pageCount = slideArr.count + 2;
    
    NSInteger index = scrollView.contentOffset.x / _headScrollView.frame.size.width;
    if (index < pageCount - 1) {
        //因为开始有第0张图片
        _page.currentPage = index - 1;
    }
    else
    {
        //第五张图片的时候显示第一张图片 _scrollView x坐标回到第一张图片的坐标
        [_headScrollView setContentOffset:CGPointMake(_headScrollView.frame.size.width, 0) animated:NO];
        _page.currentPage = 0;
    }
}

#pragma mark - dealloc
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
