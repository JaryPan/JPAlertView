//
//  JPAlertViewTextView.h
//  JPAlertView
//
//  Created by ovopark_iOS on 16/6/21.
//  Copyright © 2016年 JaryPan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JPAlertViewTextView : UIView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title message:(NSString *)message;

@property (strong, nonatomic) UIColor *tintColor;

@property (copy, nonatomic) NSString *title;

@property (copy, nonatomic) NSString *message;

@end
