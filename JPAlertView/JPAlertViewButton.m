//
//  JPAlertViewButton.m
//  JPAlertView
//
//  Created by ovopark_iOS on 16/6/21.
//  Copyright © 2016年 JaryPan. All rights reserved.
//

#pragma mark - ******** 处理 target - action 警告  ********
#define JPAlertViewButtonSuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

#import "JPAlertViewButton.h"

@interface JPAlertViewButton ()

@property (weak, nonatomic) id target;
@property (assign, nonatomic) SEL action;

@property (strong, nonatomic) UIVisualEffectView *visualEffectView;

@property (strong, nonatomic) UIButton *button;

@end

@implementation JPAlertViewButton

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title tag:(NSInteger)tag
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = YES;
        self.title = title;
        self.tag = tag;

        // 添加子控件
        [self addSubviews];
    }
    return self;
}

#pragma mark - 添加子控件
- (void)addSubviews
{
    // 高斯模糊背景
    self.visualEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
    self.visualEffectView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self addSubview:self.visualEffectView];
    
    // 按钮
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.frame = self.visualEffectView.frame;
    [self.button setTitle:self.title forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:255.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    self.button.backgroundColor = [UIColor clearColor];
    [self addSubview:self.button];
    
    // 添加点击事件
    [self.button addTarget:self action:@selector(touchDown:) forControlEvents:UIControlEventTouchDown];
    [self.button addTarget:self action:@selector(touchCancel:) forControlEvents:UIControlEventTouchCancel];
    [self.button addTarget:self action:@selector(touchDragOutside:) forControlEvents:UIControlEventTouchDragOutside];
    [self.button addTarget:self action:@selector(touchUpOutside:) forControlEvents:UIControlEventTouchUpOutside];
    [self.button addTarget:self action:@selector(touchUpInside:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 添加目标、动作
- (void)addTarget:(id)target action:(SEL)action
{
    self.target = target;
    self.action = action;
}

#pragma mark - 按钮的点击方法
- (void)touchDown:(UIButton *)sender
{
    self.visualEffectView.alpha = 0.8;
}
- (void)touchCancel:(UIButton *)sender
{
    self.visualEffectView.alpha = 1.0;
}
- (void)touchDragOutside:(UIButton *)sender
{
    self.visualEffectView.alpha = 1.0;
}
- (void)touchUpOutside:(UIButton *)sender
{
    self.visualEffectView.alpha = 1.0;
}
- (void)touchUpInside:(UIButton *)sender
{
    self.visualEffectView.alpha = 1.0;
    
    if (self.target && self.action) {
        JPAlertViewButtonSuppressPerformSelectorLeakWarning([self.target performSelector:self.action withObject:self]);
    }
}


#pragma mark - setTitle
- (void)setTitle:(NSString *)title
{
    if (_title != title) {
        _title = title;
    }
    
    if (self.button) {
        [self.button setTitle:title forState:UIControlStateNormal];
    }
}

#pragma mark - setTitleFont
- (void)setTitleFont:(UIFont *)titleFont
{
    if (_titleFont != titleFont) {
        _titleFont = titleFont;
    }
    
    if (self.button) {
        self.button.titleLabel.font = titleFont;
    }
}

#pragma mark - setTitleColor
- (void)setTitleColor:(UIColor *)titleColor
{
    if (_titleColor != titleColor) {
        _titleColor = titleColor;
    }
    
    if (self.button) {
        [self.button setTitleColor:titleColor forState:UIControlStateNormal];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
