//
//  JPAlertView.h
//  JPAlertView
//
//  Created by ovopark_iOS on 16/6/20.
//  Copyright © 2016年 JaryPan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JPAlertViewTextView.h"
#import "JPAlertViewOptionalItemView.h"
#import "JPAlertViewButtonView.h"

@protocol JPAlertViewDelegate;

@interface JPAlertView : UIView

// 唯一的初始化方法
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id /*<JPAlertViewDelegate>*/)delegate optionalItems:(NSArray<NSString *> *)optionalItems cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

@property (weak, nonatomic) id<JPAlertViewDelegate>delegate;

@property (strong, nonatomic) UIColor *tintColor;

@property (copy, nonatomic) NSString *title;

@property (copy, nonatomic) NSString *message;

// used to transfer value for user
@property (strong, nonatomic) id userInfo;

// 显示弹框
- (void)show:(void(^)())completedHandler;
// 隐藏弹框
- (void)hide:(void(^)())completedHandler;

@end

@protocol JPAlertViewDelegate <NSObject>

@optional
// Called when a optionalItem is clicked and it turned out to be selected.
- (void)alertView:(JPAlertView *)alertView selectOptionalItemAtIndex:(NSInteger)itemIndex;

// Called when a optionalItem is clicked and it turned out to be deselected.
- (void)alertView:(JPAlertView *)alertView deselectOptionalItemAtIndex:(NSInteger)itemIndex;

// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)alertView:(JPAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

// before animation and showing view
- (BOOL)willPresentAlertView:(JPAlertView *)alertView;

// after animation
- (void)didPresentAlertView:(JPAlertView *)alertView;

// before animation and hiding view
- (BOOL)alertView:(JPAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex;

// after animation
- (void)alertView:(JPAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex;

@end
