//
//  YCSegmentItemsContentView.m
//  YCSegment
//
//  Created by LakesMac on 16/4/13.
//  Copyright © 2016年 Erica. All rights reserved.
//

#import "YCSegmentItemsContentView.h"

@interface YCSegmentItemsContentView ()
{
    CGFloat _buttonWidthSUM;
    YCSegmentViewTitleItem *_currentItem;
    UIColor *_backgroundColor;
}
@property (nonatomic,strong) UIView *buttonContentView;
@property (nonatomic,strong) UIView *line;

@property (nonatomic,strong) NSMutableArray *buttonsArray;
@property (nonatomic,strong) NSMutableArray *buttonWidths;
@property (nonatomic,strong) NSArray *items;

@end

@implementation YCSegmentItemsContentView

- (void)dealloc {
    
}

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray<NSString *> *)titles underColor:(UIColor *)backgroundColor {
    if (self = [super initWithFrame:frame]) {
        _backgroundColor = backgroundColor;
        self.items = [titles copy];
        [self setupAllButtons];
    }
    return self;
}

- (void)setupAllButtons {
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.buttonContentView = [[UIView alloc] initWithFrame:CGRectZero];
    //设置标签上的button的背景颜色
    self.buttonContentView.backgroundColor = _backgroundColor;
    [self addSubview:self.buttonContentView];
    self.line = [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:self.line];
    
    for (NSString *title in self.items) {
        //这里设置所有的标题
        YCSegmentViewTitleItem *item = [[YCSegmentViewTitleItem alloc] initWithFrame:(CGRectZero) title:title];
        
        //根据字体长度来调整
        CGFloat width = [YCSegmentViewTitleItem calcuWidth:title];
        [self.buttonsArray addObject:item];
        
        //给每个item添加点击事件
        [item addTarget:self action:@selector(buttonAction:)];
        [self.buttonWidths addObject:[NSNumber numberWithDouble:width]];
        _buttonWidthSUM += width;
        [self.buttonContentView addSubview:item];
        
        //设置当前item是哪一个
        if (_currentItem == nil) {
            _currentItem = item;
            item.highlight = YES;
            item.font = [UIFont systemFontOfSize:15];
        }
    }
}

- (void)layoutSubviews {
    
    //这里是标签页的背景颜色，如果外界想调用设置，需要写一个接口public出去
    self.backgroundColor = [UIColor colorWithRed:28.0/255.0 green:28.0/255.0 blue:28.0/255.0 alpha:1];
    
    CGFloat height = self.bounds.size.height;
    CGFloat width  = self.bounds.size.width;
    
    //上面的buttonContentView创建的时候给的frame是CGRectZero，这里给他真正赋值
    self.buttonContentView.frame = CGRectMake(0, 0, width, height - 2);
    
    //这里判断每个item之间的距离，如果大于self.bounds.size.width，就设为0；不然的话就设置为比item多一个的平均间隙。
    CGFloat spacing = 0;
    if (_buttonWidthSUM >= width) {
        spacing = 0;
    } else {
        spacing = (width - _buttonWidthSUM) / (_buttonWidths.count + 1);
    }
    for (int x = 0; x < self.buttonsArray.count; x++) {
        YCSegmentViewTitleItem *item = self.buttonsArray[x];
        CGFloat buttonWidth = [self.buttonWidths[x] doubleValue];
        if (x == 0) {
            item.frame = CGRectMake(spacing, 0, buttonWidth, _buttonContentView.bounds.size.height);
        } else {
            YCSegmentViewTitleItem *lastItem = self.buttonsArray[x - 1];
            item.frame = CGRectMake(spacing + lastItem.frame.origin.x + lastItem.frame.size.width, 0, buttonWidth, _buttonContentView.bounds.size.height);
        }
    }
    //设置line的frame,高度为2
    self.line.frame = CGRectMake(_currentItem.frame.origin.x, self.buttonContentView.bounds.size.height, _currentItem.bounds.size.width , 2);
}

- (void)buttonAction:(YCSegmentViewTitleItem *)sender {
    NSInteger index = [self.buttonsArray indexOfObject:sender];
    [self setPage:index];
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectedButtonAtIndex:)]) {
        [self.delegate didSelectedButtonAtIndex:index];
    }
}

- (void)setPage:(NSInteger)page {
    if (_page == page) {
        return;
    }
    _page = page;
    [self moveToPage:page];
}

- (void)moveToPage:(NSInteger)page {
    if (page > self.buttonsArray.count) {
        return;
    }
#warning 这里在点击item变成高亮前，会点亮每个item
    //将点击后所有的item的font变回原样，关掉所有item的高亮
    YCSegmentViewTitleItem *item = self.buttonsArray[page];
    _currentItem.highlight = NO;
    _currentItem.font = [UIFont systemFontOfSize:12];
    
    //将点击的item的font变大，开启点击的item的高亮
    _currentItem = item;
    _currentItem.highlight = YES;
    _currentItem.font = [UIFont systemFontOfSize:15];
    
    [UIView animateWithDuration:0.2 animations:^{
        CGRect buttonFrame = item.frame;
        CGRect lineFrame = self.line.frame;
        lineFrame.origin.x = buttonFrame.origin.x;
        lineFrame.size.width = buttonFrame.size.width;
        self.line.frame = lineFrame;
    } completion:^(BOOL finished) {
        if (finished) {
        }
    }];
    
}

- (void)setNormalColor:(UIColor *)normalColor {
    if (_normalColor == normalColor) {
        return;
    }
    _normalColor = normalColor;
    for (YCSegmentViewTitleItem *item in self.buttonsArray) {
        item.normalColor = normalColor;
    }
}
- (void)setHighlightColor:(UIColor *)highlightColor {
    if (_highlightColor == highlightColor) {
        return;
    }
    _highlightColor = highlightColor;
    //设置line的背景颜色
    self.line.backgroundColor = highlightColor;
    for (YCSegmentViewTitleItem *item in self.buttonsArray) {
        item.highlightColor = highlightColor;
    }
}

- (void)setFont:(UIFont *)font {
    if (_font == font) {
        return;
    }
    for (YCSegmentViewTitleItem *item in self.buttonsArray) {
        item.font = font;
    }
}

- (NSMutableArray *)buttonsArray{
    if (!_buttonsArray) {
        _buttonsArray = [NSMutableArray array];
    }
    return _buttonsArray;
}
- (NSMutableArray *)buttonWidths{
    if (!_buttonWidths) {
        _buttonWidths = [NSMutableArray array];
    }
    return _buttonWidths;
}
@end
