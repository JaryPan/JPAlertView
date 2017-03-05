//
//  JPAlertView.m
//  JPAlertView
//
//  Created by ovopark_iOS on 16/6/20.
//  Copyright © 2016年 JaryPan. All rights reserved.
//

#define kContentWidth 270

#import "JPAlertView.h"

@interface JPAlertView () <JPAlertViewOptionalItemViewDelegate, JPAlertViewButtonViewDelegate>
{
    CGFloat contentHeight;
}

@property (strong, nonatomic) NSMutableArray *optionalItems;

@property (copy, nonatomic) NSString *cancelButtonTitle;

@property (strong, nonatomic) NSMutableArray *otherButtonTitles;


@property (strong, nonatomic) UIView *contentView;

@property (strong, nonatomic) JPAlertViewTextView *textView;
@property (strong, nonatomic) JPAlertViewOptionalItemView *optionalItemView;
@property (strong, nonatomic) JPAlertViewButtonView *buttonView;

@end

@implementation JPAlertView

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate optionalItems:(NSArray<NSString *> *)optionalItems cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    if (self = [super init]) {
        // 设置自身的一些属性
        self.frame =[UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
        self.clipsToBounds = YES;
        
        self.alpha = 0.0;
        
        // 注册横竖屏切换的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
        
        // 初始化可选项数组
        self.optionalItems = [NSMutableArray array];
        
        // 初始化按钮标题数组
        self.otherButtonTitles = [NSMutableArray array];
        
        self.title = title;
        self.message = message;
        self.delegate = delegate;
        self.tintColor = [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
        
        [self.optionalItems addObjectsFromArray:optionalItems];
        
        self.cancelButtonTitle = cancelButtonTitle;
        
        if (otherButtonTitles) {
            [self.otherButtonTitles addObject:otherButtonTitles];
        }
        va_list args;
        va_start(args, otherButtonTitles);
        if (otherButtonTitles) {
            NSString *otherButtonTitle;
            while ((otherButtonTitle = va_arg(args, NSString *))) {
                [self.otherButtonTitles addObject:otherButtonTitle];
            }
        }
        va_end(args);
        
        // 添加子控件
        [self addSubviews];
    }
    
    return self;
}


#pragma mark - 添加子控件
- (void)addSubviews
{
    // 显示图
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width/2 - kContentWidth/2, self.frame.size.height/2 - contentHeight/2, kContentWidth, contentHeight)];
    self.contentView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.4];
    self.contentView.layer.cornerRadius = 10;
    self.contentView.clipsToBounds = YES;
    [self addSubview:self.contentView];
    
    
    // 文本视图
    self.textView = [[JPAlertViewTextView alloc] initWithFrame:CGRectMake(0, 0, kContentWidth, contentHeight) title:self.title message:self.message];
    [self.contentView addSubview:self.textView];
    
    
    // 可选按钮
    self.optionalItemView = [[JPAlertViewOptionalItemView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.textView.frame), kContentWidth, contentHeight) OptionalItems:self.optionalItems];
    self.optionalItemView.delegate = self;
    [self.contentView addSubview:self.optionalItemView];
    
    
    // 按钮视图
    self.buttonView = [[JPAlertViewButtonView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.optionalItemView.frame), kContentWidth, contentHeight) cancelButtonTitle:self.cancelButtonTitle otherButtonTitles:self.otherButtonTitles];
    self.buttonView.delegate = self;
    [self.contentView addSubview:self.buttonView];
    
    
    contentHeight = self.textView.frame.size.height + self.optionalItemView.frame.size.height + self.buttonView.frame.size.height;
    contentHeight = (contentHeight == 0 ? 40 : contentHeight);
    
    
    // 更新 contentView 的尺寸
    self.contentView.frame = CGRectMake(self.frame.size.width/2 - kContentWidth/2, self.frame.size.height/2 - contentHeight/2, kContentWidth, contentHeight);
}


#pragma mark - JPAlertViewOptionalItemViewDelegate
- (void)optionalItemView:(JPAlertViewOptionalItemView *)optionalItemView selectOptionalItemAtIndex:(NSInteger)itemIndex
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(alertView:selectOptionalItemAtIndex:)]) {
        [self.delegate alertView:self selectOptionalItemAtIndex:itemIndex];
    }
}
- (void)optionalItemView:(JPAlertViewOptionalItemView *)optionalItemView deselectOptionalItemAtIndex:(NSInteger)itemIndex
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(alertView:deselectOptionalItemAtIndex:)]) {
        [self.delegate alertView:self deselectOptionalItemAtIndex:itemIndex];
    }
}


#pragma mark - JPAlertViewButtonViewDelegate
- (void)alertViewButtonView:(JPAlertViewButtonView *)alertViewButtonView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(alertView:clickedButtonAtIndex:)]) {
        [self.delegate alertView:self clickedButtonAtIndex:buttonIndex];
    }
    
    BOOL canDismiss = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(alertView:willDismissWithButtonIndex:)]) {
        canDismiss = [self.delegate alertView:self willDismissWithButtonIndex:buttonIndex];
    }
    if (!canDismiss) {
        return;
    }
    
    __weak typeof(self)weakSelf = self;
    [self hide:^{
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(alertView:didDismissWithButtonIndex:)]) {
            [weakSelf.delegate alertView:weakSelf didDismissWithButtonIndex:buttonIndex];
        }
    }];
}


#pragma mark - 收到横竖屏切换的通知方法
- (void)deviceOrientationDidChange:(NSNotification *)sender
{
    [self setNeedsLayout];
}

#pragma mark - layoutSubviews
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.frame = [UIScreen mainScreen].bounds;
    
    // 更新 contentView 的尺寸
    self.contentView.frame = CGRectMake(self.frame.size.width/2 - kContentWidth/2, self.frame.size.height/2 - contentHeight/2, kContentWidth, contentHeight);
}


#pragma mark - setTintColor
- (void)setTintColor:(UIColor *)tintColor
{
    if (_tintColor != tintColor) {
        _tintColor = tintColor;
    }
    
    self.textView.tintColor = tintColor;
    self.buttonView.tintColor = tintColor;
}

#pragma mark - setTitle
- (void)setTitle:(NSString *)title
{
    if (_title != title) {
        _title = title;
    }
    
    self.textView.title = title;
    
    self.optionalItemView.frame = CGRectMake(self.optionalItemView.frame.origin.x, CGRectGetMaxY(self.textView.frame), self.optionalItemView.frame.size.width, self.optionalItemView.frame.size.height);
    self.buttonView.frame = CGRectMake(self.buttonView.frame.origin.x, CGRectGetMaxY(self.optionalItemView.frame), self.buttonView.frame.size.width, self.buttonView.frame.size.height);
    contentHeight = self.textView.frame.size.height + self.optionalItemView.frame.size.height + self.buttonView.frame.size.height;
    contentHeight = (contentHeight == 0 ? 40 : contentHeight);
    
    // 更新 contentView 的尺寸
    self.contentView.frame = CGRectMake(self.frame.size.width/2 - kContentWidth/2, self.frame.size.height/2 - contentHeight/2, kContentWidth, contentHeight);
}

#pragma mark - setMessage
- (void)setMessage:(NSString *)message
{
    if (_message != message) {
        _message = message;
    }
    
    self.textView.message = message;
    
    self.optionalItemView.frame = CGRectMake(self.optionalItemView.frame.origin.x, CGRectGetMaxY(self.textView.frame), self.optionalItemView.frame.size.width, self.optionalItemView.frame.size.height);
    self.buttonView.frame = CGRectMake(self.buttonView.frame.origin.x, CGRectGetMaxY(self.optionalItemView.frame), self.buttonView.frame.size.width, self.buttonView.frame.size.height);
    contentHeight = self.textView.frame.size.height + self.optionalItemView.frame.size.height + self.buttonView.frame.size.height;
    contentHeight = (contentHeight == 0 ? 40 : contentHeight);
    
    // 更新 contentView 的尺寸
    self.contentView.frame = CGRectMake(self.frame.size.width/2 - kContentWidth/2, self.frame.size.height/2 - contentHeight/2, kContentWidth, contentHeight);
}


#pragma mark - show
- (void)show:(void (^)())completedHandler
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        if (![[window subviews] containsObject:self]) {
            BOOL canPresent = YES;
            if (self.delegate && [self.delegate respondsToSelector:@selector(willPresentAlertView:)]) {
                canPresent = [self.delegate willPresentAlertView:self];
            }
            if (!canPresent) {
                return;
            }
            
            self.alpha = 0.0;
            [window addSubview:self];
            
            [UIView animateWithDuration:0.26 animations:^{
                self.alpha = 1.0;
            } completion:^(BOOL finished) {
                if (completedHandler) {
                    completedHandler();
                }
                
                if (self.delegate && [self.delegate respondsToSelector:@selector(didPresentAlertView:)]) {
                    [self.delegate didPresentAlertView:self];
                }
            }];
        }
    });
}
#pragma mark - hide
- (void)hide:(void (^)())completedHandler
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    if ([[window subviews] containsObject:self]) {
        [UIView animateWithDuration:0.26 animations:^{
            self.alpha = 0.0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            
            if (completedHandler) {
                completedHandler();
            }
        }];
    }
}


#pragma mark - 在dealloc方法中注销通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
