//
//  JPAlertViewTextView.m
//  JPAlertView
//
//  Created by ovopark_iOS on 16/6/21.
//  Copyright © 2016年 JaryPan. All rights reserved.
//

#import "JPAlertViewTextView.h"

@interface JPAlertViewTextView ()

@property (strong, nonatomic) UIVisualEffectView *visualEffectView;

@property (strong, nonatomic) UILabel *titleLabel;

@property (strong, nonatomic) UILabel *messageLabel;

@end

@implementation JPAlertViewTextView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title message:(NSString *)message
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = YES;
        
        // 高斯模糊背景
        self.visualEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
        [self addSubview:self.visualEffectView];
        
        self.title = title;
        self.message = message;
    }
    return self;
}


#pragma mark - 计算文字高度的方法
- (CGFloat)labelHeightForText:(NSString *)text withFont:(UIFont *)font andMaxWidth:(CGFloat)maxWidth
{
    CGSize maxSize = CGSizeMake(maxWidth, CGFLOAT_MAX);
    CGRect rect = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return rect.size.height;
}


#pragma mark - setTitle
- (void)setTitle:(NSString *)title
{
    if (_title != title) {
        _title = title;
    }
    
    CGFloat contentHeight = 0;
    
    if (title.length > 0) {
        // 计算文字高度
        CGFloat titleHeight = [self labelHeightForText:title withFont:[UIFont boldSystemFontOfSize:17] andMaxWidth:self.frame.size.width - 40];
        titleHeight = titleHeight < 20 ? 20 : titleHeight;
        
        // 判断显示框是否存在
        if (!self.titleLabel) {
            self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, self.frame.size.width - 40, titleHeight)];
            self.titleLabel.text = title;
            self.titleLabel.textColor = [UIColor blackColor];
            self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            self.titleLabel.numberOfLines = 0;
            [self addSubview:self.titleLabel];
        } else {
            self.titleLabel.text = title;
            self.titleLabel.frame = CGRectMake(20, 20, self.frame.size.width - 40, titleHeight);
        }
        
        // 判断原来是否有message
        if (self.message.length > 0) {
            CGFloat messageHeight = [self labelHeightForText:self.message withFont:[UIFont systemFontOfSize:14] andMaxWidth:self.frame.size.width - 40];
            messageHeight = messageHeight < 20 ? 20 : messageHeight;
            
            self.messageLabel.font = [UIFont systemFontOfSize:14];
            self.messageLabel.frame = CGRectMake(20, CGRectGetMaxY(self.titleLabel.frame) + 10, self.frame.size.width - 40, messageHeight);
            
            contentHeight = 20 + titleHeight + 10 + messageHeight + 10;
        } else {
            contentHeight = 20 + titleHeight + 10;
        }
    } else {
        if (self.titleLabel) {
            self.titleLabel.text = title;
            self.titleLabel.frame = CGRectMake(20, 20, self.frame.size.width - 40, 0);
        }
        
        // 判断原来是否有message
        if (self.message.length > 0) {
            CGFloat messageHeight = [self labelHeightForText:self.message withFont:[UIFont boldSystemFontOfSize:17] andMaxWidth:self.frame.size.width - 40];
            messageHeight = messageHeight < 20 ? 20 : messageHeight;
            
            self.messageLabel.font = [UIFont boldSystemFontOfSize:17];
            self.messageLabel.frame = CGRectMake(20, CGRectGetMaxY(self.titleLabel.frame) + 10, self.frame.size.width - 40, messageHeight);
            
            contentHeight = 20 + messageHeight + 10;
        }
    }
    
    // 更新尺寸
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, contentHeight);
    self.visualEffectView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}


#pragma mark - setMessage
- (void)setMessage:(NSString *)message
{
    if (_message != message) {
        _message = message;
    }
    
    CGFloat contentHeight = 0;
    
    if (message.length > 0) {
        // 判断消息框是否存在
        if (!self.messageLabel) {
            self.messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, self.frame.size.width - 40, 0)];
            self.messageLabel.text = message;
            self.messageLabel.textColor = [UIColor blackColor];
            self.messageLabel.textAlignment = NSTextAlignmentCenter;
            self.messageLabel.numberOfLines = 0;
            [self addSubview:self.messageLabel];
        } else {
            self.messageLabel.text = message;
        }
        
        // 计算文字高度
        CGFloat messageHeight = 0;
        // 判断原来是否有title
        if (self.title.length > 0) {
            messageHeight = [self labelHeightForText:self.message withFont:[UIFont systemFontOfSize:14] andMaxWidth:self.frame.size.width - 40];
            messageHeight = messageHeight < 20 ? 20 : messageHeight;
            self.messageLabel.font = [UIFont systemFontOfSize:14];
            self.messageLabel.frame = CGRectMake(20, CGRectGetMaxY(self.titleLabel.frame) + 10, self.frame.size.width - 40, messageHeight);
            
            contentHeight = 20 + self.titleLabel.frame.size.height + 10 + messageHeight + 10;
        } else {
            messageHeight = [self labelHeightForText:self.message withFont:[UIFont boldSystemFontOfSize:17] andMaxWidth:self.frame.size.width - 40];
            messageHeight = messageHeight < 20 ? 20 : messageHeight;
            self.messageLabel.font = [UIFont boldSystemFontOfSize:17];
            self.messageLabel.frame = CGRectMake(20, CGRectGetMaxY(self.titleLabel.frame) + 10, self.frame.size.width - 40, messageHeight);
            
            contentHeight = 20 + messageHeight + 10;
        }
    } else {
        if (self.messageLabel) {
            self.messageLabel.text = message;
            self.messageLabel.frame = CGRectMake(self.messageLabel.frame.origin.x, self.messageLabel.frame.origin.y, self.messageLabel.frame.size.width, 0);
        }
        
        // 判断原来是否有title
        if (self.title.length > 0) {
            contentHeight = 20 + self.titleLabel.frame.size.height + 10;
        }
    }
    
    // 更新尺寸
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, contentHeight);
    self.visualEffectView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
