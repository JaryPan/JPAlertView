//
//  JPAlertViewOptionalItem.h
//  JPAlertView
//
//  Created by ovopark_iOS on 16/6/20.
//  Copyright © 2016年 JaryPan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, JPAlertViewOptionalItemControlState) {
    JPAlertViewOptionalItemControlStateNormal,
    JPAlertViewOptionalItemControlStateSelected,
    JPAlertViewOptionalItemControlStateDisabled,
};

@interface JPAlertViewOptionalItem : UIView

// 添加目标和动作
- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;


@property (strong, nonatomic) UIColor *tintColor;


// default is nil for any state
@property (copy, nonatomic) NSString *title;

// default is system font 14 plain
@property (strong, nonatomic) UIFont *titleFont;

// default is blackColor for any state
@property (strong, nonatomic) UIColor *titleColor;

// default is NSTextAlignmentLeft
@property(nonatomic) NSTextAlignment textAlignment;


- (void)setTitle:(NSString *)title forState:(JPAlertViewOptionalItemControlState)state;

- (void)setTitleColor:(UIColor *)titleColor forState:(JPAlertViewOptionalItemControlState)state;


// default is YES
@property(nonatomic, getter=isEnabled) BOOL enabled;

// default is NO
@property(nonatomic, getter=isSelected) BOOL selected;


@end
