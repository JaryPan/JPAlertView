//
//  JPAlertViewButton.h
//  JPAlertView
//
//  Created by ovopark_iOS on 16/6/21.
//  Copyright © 2016年 JaryPan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JPAlertViewButton : UIView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title tag:(NSInteger)tag;

@property (copy, nonatomic) NSString *title;

@property (strong, nonatomic) UIFont *titleFont;

@property (strong, nonatomic) UIColor *titleColor;

- (void)addTarget:(id)target action:(SEL)action;

@end
