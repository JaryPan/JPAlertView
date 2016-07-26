//
//  JPAlertViewButtonView.m
//  JPAlertView
//
//  Created by ovopark_iOS on 16/6/21.
//  Copyright © 2016年 JaryPan. All rights reserved.
//

#define kJPAlertViewButtonHeight 40

#import "JPAlertViewButtonView.h"

@interface JPAlertViewButtonView ()

@property (copy, nonatomic) NSString *cancelButtonTitle;
@property (strong, nonatomic) NSMutableArray<NSString *> *otherButtonTitles;

@end

@implementation JPAlertViewButtonView

#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = YES;
        self.tintColor = [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
        
        self.cancelButtonTitle = cancelButtonTitle;
        self.otherButtonTitles = [NSMutableArray array];
        [self.otherButtonTitles addObjectsFromArray:otherButtonTitles];
        
        // 添加子控件
        [self addSubviews];
    }
    return self;
}

#pragma mark - 添加子控件
- (void)addSubviews
{
    CGFloat contentHeight = 0;
    
    if (self.cancelButtonTitle) {
        // 有取消按钮
        
        if (self.otherButtonTitles.count == 0) {
            // 只有取消按钮
            JPAlertViewButton *cancelbutton = [[JPAlertViewButton alloc] initWithFrame:CGRectMake(0, 0.5, self.frame.size.width, kJPAlertViewButtonHeight) title:self.cancelButtonTitle tag:10000 + 0];
            cancelbutton.titleFont = [UIFont boldSystemFontOfSize:17];
            [cancelbutton addTarget:self action:@selector(alertViewButtonAction:)];
            [self addSubview:cancelbutton];
            
            contentHeight = 0.5 + kJPAlertViewButtonHeight;
        } else if (self.otherButtonTitles.count == 1) {
            // 有一个取消按钮和一个其他按钮
            JPAlertViewButton *cancelbutton = [[JPAlertViewButton alloc] initWithFrame:CGRectMake(0, 0.5, self.frame.size.width/2 - 0.25, kJPAlertViewButtonHeight) title:self.cancelButtonTitle tag:10000 + 0];
            cancelbutton.titleFont = [UIFont boldSystemFontOfSize:17];
            [cancelbutton addTarget:self action:@selector(alertViewButtonAction:)];
            [self addSubview:cancelbutton];
            
            JPAlertViewButton *otherButton = [[JPAlertViewButton alloc] initWithFrame:CGRectMake(self.frame.size.width/2 + 0.25, 0.5, self.frame.size.width/2 - 0.25, kJPAlertViewButtonHeight) title:self.otherButtonTitles[0] tag:10000 + 1];
            [otherButton addTarget:self action:@selector(alertViewButtonAction:)];
            [self addSubview:otherButton];
            
            contentHeight = 0.5 + kJPAlertViewButtonHeight;
        } else {
            // 有一个取消按钮和多个其他按钮
            // 先添加其他按钮
            for (NSInteger i = 0; i < self.otherButtonTitles.count; i++) {
                JPAlertViewButton *otherButton = [[JPAlertViewButton alloc] initWithFrame:CGRectMake(0, 0.5 + (kJPAlertViewButtonHeight + 0.5) * i, self.frame.size.width, kJPAlertViewButtonHeight) title:self.otherButtonTitles[i] tag:10000 + 1 + i];
                [otherButton addTarget:self action:@selector(alertViewButtonAction:)];
                [self addSubview:otherButton];
            }
            // 再添加取消按钮
            JPAlertViewButton *cancelbutton = [[JPAlertViewButton alloc] initWithFrame:CGRectMake(0, 0.5 + (kJPAlertViewButtonHeight + 0.5) * self.otherButtonTitles.count, self.frame.size.width, kJPAlertViewButtonHeight) title:self.cancelButtonTitle tag:10000 + 0];
            cancelbutton.titleFont = [UIFont boldSystemFontOfSize:17];
            [cancelbutton addTarget:self action:@selector(alertViewButtonAction:)];
            [self addSubview:cancelbutton];
            
            contentHeight = (0.5 + kJPAlertViewButtonHeight) * (self.otherButtonTitles.count + 1);
        }
    } else {
        // 没有取消按钮
        
        if (self.otherButtonTitles.count == 0) {
            // 没有任何按钮
            
        } else if (self.otherButtonTitles.count == 2) {
            // 有2个其他按钮
            JPAlertViewButton *otherButton1 = [[JPAlertViewButton alloc] initWithFrame:CGRectMake(0, 0.5, self.frame.size.width/2 - 0.25, kJPAlertViewButtonHeight) title:self.otherButtonTitles[0] tag:10000 + 0];
            [otherButton1 addTarget:self action:@selector(alertViewButtonAction:)];
            [self addSubview:otherButton1];
            
            JPAlertViewButton *otherButton2 = [[JPAlertViewButton alloc] initWithFrame:CGRectMake(self.frame.size.width/2 + 0.25, 0.5, self.frame.size.width/2 - 0.25, kJPAlertViewButtonHeight) title:self.otherButtonTitles[1] tag:10000 + 1];
            [otherButton2 addTarget:self action:@selector(alertViewButtonAction:)];
            [self addSubview:otherButton2];
            
            contentHeight = 0.5 + kJPAlertViewButtonHeight;
        } else {
            // 有一个或三个以上其他按钮
            for (NSInteger i = 0; i < self.otherButtonTitles.count; i++) {
                JPAlertViewButton *otherButton = [[JPAlertViewButton alloc] initWithFrame:CGRectMake(0, 0.5 + (kJPAlertViewButtonHeight + 0.5) * i, self.frame.size.width, kJPAlertViewButtonHeight) title:self.otherButtonTitles[i] tag:10000 + i];
                [otherButton addTarget:self action:@selector(alertViewButtonAction:)];
                [self addSubview:otherButton];
            }
            
            contentHeight = (0.5 + kJPAlertViewButtonHeight) * self.otherButtonTitles.count;
        }
    }
    
    // 更新位置
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, contentHeight);
}


#pragma mark - 按钮的点击方法
- (void)alertViewButtonAction:(JPAlertViewButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(alertViewButtonView:clickedButtonAtIndex:)]) {
        [self.delegate alertViewButtonView:self clickedButtonAtIndex:sender.tag - 10000];
    }
}


#pragma mark - setTintColor
- (void)setTintColor:(UIColor *)tintColor
{
    if (_tintColor != tintColor) {
        _tintColor = tintColor;
    }
    
    for (JPAlertViewButton *button in [self subviews]) {
        if ([button isKindOfClass:[JPAlertViewButton class]] && button.tag >= 10000) {
            button.titleColor = tintColor;
        }
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
