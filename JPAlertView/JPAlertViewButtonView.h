//
//  JPAlertViewButtonView.h
//  JPAlertView
//
//  Created by ovopark_iOS on 16/6/21.
//  Copyright © 2016年 JaryPan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JPAlertViewButton.h"

@protocol JPAlertViewButtonViewDelegate;

@interface JPAlertViewButtonView : UIView

// 初始化方法
- (instancetype)initWithFrame:(CGRect)frame cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles;

// 代理属性
@property (weak, nonatomic) id<JPAlertViewButtonViewDelegate>delegate;

@property (strong, nonatomic) UIColor *tintColor;

@end

// 代理方法
@protocol JPAlertViewButtonViewDelegate <NSObject>
@optional

- (void)alertViewButtonView:(JPAlertViewButtonView *)alertViewButtonView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end
