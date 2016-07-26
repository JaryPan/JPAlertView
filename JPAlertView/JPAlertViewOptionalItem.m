//
//  JPAlertViewOptionalItem.m
//  JPAlertView
//
//  Created by ovopark_iOS on 16/6/20.
//  Copyright © 2016年 JaryPan. All rights reserved.
//

#pragma mark - ******** 处理 target - action 警告  ********
#define JPAlertViewOptionalItemSuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

#import "JPAlertViewOptionalItem.h"

@interface JPAlertViewOptionalItem ()
{
    NSString *normalTitle;
    NSString *selectedTitle;
    NSString *disabledTitle;
    
    UIColor *normalTitleColor;
    UIColor *selectedTitleColor;
    UIColor *disabledTitleColor;
    
    UILabel *markLabel;
    UILabel *titleLabel;
    UIButton *button;
}

@property (weak, nonatomic) id target;
@property (assign, nonatomic) SEL action;

@end

@implementation JPAlertViewOptionalItem

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 初始化一些属性
        self.clipsToBounds = YES;
        self.tintColor = [UIColor colorWithRed:0.0 green:122.0/255.0 blue:255.0/255.0 alpha:1.0];
        self.titleFont = [UIFont systemFontOfSize:14];
        self.titleColor = [UIColor blackColor];
        // 添加子控件
        [self addSubviews];
    }
    return self;
}


#pragma mark -添加子控件
- (void)addSubviews
{
    // 标志lable
    markLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.frame.size.height/2 - 8, 16, 16)];
    markLabel.backgroundColor = [UIColor clearColor];
    markLabel.layer.borderColor = self.tintColor.CGColor;
    markLabel.layer.borderWidth = 1.5;
    markLabel.layer.masksToBounds = YES;
    markLabel.layer.cornerRadius = 4;
    markLabel.textAlignment = NSTextAlignmentCenter;
    markLabel.textColor = [UIColor whiteColor];
    markLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:markLabel];
    
    // 文本框
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(markLabel.frame) + 5, 0, self.frame.size.width - CGRectGetMaxX(markLabel.frame) - 15, self.frame.size.height)];
    titleLabel.font = self.titleFont;
    titleLabel.textColor = self.titleColor;
    [self addSubview:titleLabel];
    
    // 按钮
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor clearColor];
    button.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self addSubview:button];
}


#pragma mark - 添加目标和动作
- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    self.target = target;
    self.action = action;
    
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:controlEvents];
}
#pragma mark - buttonAction
- (void)buttonAction:(UIButton *)sender
{
    self.selected = !self.isSelected;
    
    if (self.target && self.action) {
        JPAlertViewOptionalItemSuppressPerformSelectorLeakWarning([self.target performSelector:self.action withObject:self]);
    }
}


#pragma mark - setTintColor
- (void)setTintColor:(UIColor *)tintColor
{
    if (_tintColor != tintColor) {
        _tintColor = tintColor;
    }
    
    markLabel.layer.borderColor = tintColor.CGColor;
    if (self.selected) {
        markLabel.backgroundColor = tintColor;
    } else {
        markLabel.backgroundColor = [UIColor clearColor];
    }
}
#pragma mark - setTitle
- (void)setTitle:(NSString *)title
{
    if (_title != title) {
        _title = title;
    }
    
    titleLabel.text = title;
}
#pragma mark - setTitleFont
- (void)setTitleFont:(UIFont *)titleFont
{
    if (_titleFont != titleFont) {
        _titleFont = titleFont;
    }
    
    titleLabel.font = titleFont;
}
#pragma mark - setTitleColor
- (void)setTitleColor:(UIColor *)titleColor
{
    if (_titleColor != titleColor) {
        _titleColor = titleColor;
    }
    
    titleLabel.textColor = titleColor;
}
#pragma mark - setTextAlignment
- (void)setTextAlignment:(NSTextAlignment)textAlignment
{
    _textAlignment = textAlignment;
    
    titleLabel.textAlignment = textAlignment;
}

#pragma mark - setEnabled
- (void)setEnabled:(BOOL)enabled
{
    _enabled = enabled;
    
    self.userInteractionEnabled = enabled;
    
    if (enabled) {
        // 可交互
        if (self.isSelected) {
            markLabel.backgroundColor = self.tintColor;
            markLabel.layer.borderColor = self.tintColor.CGColor;
            markLabel.text = @"√";
            
            if (selectedTitle) {
                titleLabel.text = selectedTitle;
            } else {
                titleLabel.text = self.title;
            }
            
            if (selectedTitleColor) {
                titleLabel.textColor = selectedTitleColor;
            } else {
                titleLabel.textColor = self.titleColor;
            }
        } else {
            markLabel.backgroundColor = [UIColor clearColor];
            markLabel.layer.borderColor = self.tintColor.CGColor;
            markLabel.text = nil;
            
            if (normalTitle) {
                titleLabel.text = normalTitle;
            } else {
                titleLabel.text = self.title;
            }
            
            if (normalTitleColor) {
                titleLabel.textColor = normalTitleColor;
            } else {
                titleLabel.textColor = self.titleColor;
            }
        }
    } else {
        // 不可交互
        markLabel.backgroundColor = [UIColor clearColor];
        markLabel.layer.borderColor = [UIColor colorWithWhite:230.0/255.0 alpha:1.0].CGColor;
        markLabel.text = nil;
        
        if (disabledTitle) {
            titleLabel.text = disabledTitle;
        } else {
            titleLabel.text = self.title;
        }
        
        if (disabledTitleColor) {
            titleLabel.textColor = disabledTitleColor;
        } else {
            titleLabel.textColor = self.titleColor;
        }
    }
}
#pragma mark - setSelected
- (void)setSelected:(BOOL)selected
{
    _selected = selected;
    
    if (selected) {
        // 选中
        markLabel.backgroundColor = self.tintColor;
        markLabel.layer.borderColor = self.tintColor.CGColor;
        markLabel.text = @"√";
        
        if (selectedTitle) {
            titleLabel.text = selectedTitle;
        } else {
            titleLabel.text = self.title;
        }
        
        if (selectedTitleColor) {
            titleLabel.textColor = selectedTitleColor;
        } else {
            titleLabel.textColor = self.titleColor;
        }
    } else {
        // 未选中
        markLabel.backgroundColor = [UIColor clearColor];
        markLabel.layer.borderColor = self.tintColor.CGColor;
        markLabel.text = nil;
        
        if (normalTitle) {
            titleLabel.text = normalTitle;
        } else {
            titleLabel.text = self.title;
        }
        
        if (normalTitleColor) {
            titleLabel.textColor = normalTitleColor;
        } else {
            titleLabel.textColor = self.titleColor;
        }
    }
}


#pragma mark - setTitle:forState:
- (void)setTitle:(NSString *)title forState:(JPAlertViewOptionalItemControlState)state
{
    switch (state) {
        case JPAlertViewOptionalItemControlStateNormal:
            normalTitle = title;
            self.title = title;
            if (self.isEnabled && !self.isSelected) {
                titleLabel.text = title;
            }
            break;
            
        case JPAlertViewOptionalItemControlStateSelected:
            selectedTitle = title;
            if (self.isEnabled && self.isSelected) {
                titleLabel.text = title;
            }
            break;
            
        case JPAlertViewOptionalItemControlStateDisabled:
            disabledTitle = title;
            if (!self.isEnabled) {
                titleLabel.text = title;
            }
            break;
            
        default:
            break;
    }
}

#pragma mark - setTitleColor:forState:
- (void)setTitleColor:(UIColor *)titleColor forState:(JPAlertViewOptionalItemControlState)state
{
    switch (state) {
        case JPAlertViewOptionalItemControlStateNormal:
            normalTitleColor = titleColor;
            self.titleColor = titleColor;
            if (self.isEnabled && !self.isSelected) {
                titleLabel.textColor = titleColor;
            }
            break;
            
        case JPAlertViewOptionalItemControlStateSelected:
            selectedTitleColor = titleColor;
            if (self.isEnabled && self.isSelected) {
                titleLabel.textColor = titleColor;
            }
            break;
            
        case JPAlertViewOptionalItemControlStateDisabled:
            disabledTitleColor = titleColor;
            if (!self.isEnabled) {
                titleLabel.textColor = titleColor;
            }
            break;
            
        default:
            break;
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
