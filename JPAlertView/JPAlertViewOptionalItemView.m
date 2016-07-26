//
//  JPAlertViewOptionalItemView.m
//  JPAlertView
//
//  Created by ovopark_iOS on 16/7/26.
//  Copyright © 2016年 JaryPan. All rights reserved.
//

#import "JPAlertViewOptionalItemView.h"

@interface JPAlertViewOptionalItemView ()

@property (strong, nonatomic) NSMutableArray<NSString *> *optionalItems;

@property (strong, nonatomic) UIVisualEffectView *visualEffectView;

@end

@implementation JPAlertViewOptionalItemView

- (instancetype)initWithFrame:(CGRect)frame OptionalItems:(NSArray<NSString *> *)optionalItems
{
    if (self = [super initWithFrame:frame]) {
        self.optionalItems = [NSMutableArray array];
        [self.optionalItems addObjectsFromArray:optionalItems];
        
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = YES;
        
        // 添加子控件
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews
{
    // 高斯模糊背景
    self.visualEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
    [self addSubview:self.visualEffectView];
    
    // 添加可选按钮
    for (NSInteger i = 0; i < self.optionalItems.count; i++) {
        JPAlertViewOptionalItem *item = [[JPAlertViewOptionalItem alloc] initWithFrame:CGRectMake(10, 10 + 20 * i, self.frame.size.width - 20, 20)];
        item.tag = 10000 + i;
        item.title = self.optionalItems[i];
        [item setTitleColor:[UIColor colorWithWhite:105.0/255.0 alpha:1.0] forState:JPAlertViewOptionalItemControlStateNormal];
        [item setTitleColor:[UIColor blackColor] forState:JPAlertViewOptionalItemControlStateSelected];
        [item addTarget:self action:@selector(optionalItemAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:item];
    }
    
    // 重新设置尺寸
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 20 * self.optionalItems.count + (self.optionalItems.count > 0 ? 20 : 0));
    self.visualEffectView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

#pragma mark - 可选按钮的点击事件
- (void)optionalItemAction:(JPAlertViewOptionalItem *)sender
{
    if (sender.isSelected) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(optionalItemView:selectOptionalItemAtIndex:)]) {
            [self.delegate optionalItemView:self selectOptionalItemAtIndex:sender.tag - 10000];
        }
    } else {
        if (self.delegate && [self.delegate respondsToSelector:@selector(optionalItemView:deselectOptionalItemAtIndex:)]) {
            [self.delegate optionalItemView:self deselectOptionalItemAtIndex:sender.tag - 10000];
        }
    }
}


#pragma mark - 插入一个可选按钮（默认处于最后一个位置）
- (void)insertItem:(NSString *)itemTitle
{
    // 判断标题是否为空
    if (!itemTitle) {
        NSLog(@"JPAlertViewOptionalItemView无法插入一个标题为空的可选按钮");
        return;
    }
    
    // 装入数据
    [self.optionalItems addObject:itemTitle];
    
    // 创建可选按钮
    NSInteger index = self.optionalItems.count - 1;
    JPAlertViewOptionalItem *item = [[JPAlertViewOptionalItem alloc] initWithFrame:CGRectMake(0, 10 + 20 * index, self.frame.size.width, 20)];
    item.tag = 10000 + index;
    item.title = itemTitle;
    [item setTitleColor:[UIColor colorWithWhite:105.0/255.0 alpha:1.0] forState:JPAlertViewOptionalItemControlStateNormal];
    [item setTitleColor:[UIColor blackColor] forState:JPAlertViewOptionalItemControlStateSelected];
    [item addTarget:self action:@selector(optionalItemAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:item];
    
    // 重新设置尺寸
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 20 * self.optionalItems.count + (self.optionalItems.count > 0 ? 20 : 0));
    self.visualEffectView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}
#pragma mark - 在某个下标处插入一个可选按钮
- (void)insertOneItem:(NSString *)itemTitle atIndex:(NSInteger)index
{
    // 判断标题是否为空
    if (!itemTitle) {
        NSLog(@"JPAlertViewOptionalItemView无法插入一个标题为空的可选按钮");
        return;
    }
    
    // 判断是否越界
    if (index > self.optionalItems.count) {
        NSLog(@"JPAlertViewOptionalItemView插入可选按钮时下标“%ld”越界", index);
        return;
    }
    
    // 装入数据
    [self.optionalItems insertObject:itemTitle atIndex:index];
    
    // 调整部分按钮的tag值和位置
    for (JPAlertViewOptionalItem *item in [self subviews]) {
        if ([item isKindOfClass:[JPAlertViewOptionalItem class]] && item.tag >= (10000 + index)) {
            item.tag++;
            item.frame = CGRectMake(item.frame.origin.x, item.frame.size.height * (item.tag - 10000), item.frame.size.width, item.frame.size.height);
        }
    }
    
    // 创建可选按钮
    JPAlertViewOptionalItem *item = [[JPAlertViewOptionalItem alloc] initWithFrame:CGRectMake(0, 10 + 20 * index, self.frame.size.width, 20)];
    item.tag = 10000 + index;
    item.title = itemTitle;
    [item setTitleColor:[UIColor colorWithWhite:105.0/255.0 alpha:1.0] forState:JPAlertViewOptionalItemControlStateNormal];
    [item setTitleColor:[UIColor blackColor] forState:JPAlertViewOptionalItemControlStateSelected];
    [item addTarget:self action:@selector(optionalItemAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:item];
    
    // 重新设置尺寸
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 20 * self.optionalItems.count + (self.optionalItems.count > 0 ? 20 : 0));
    self.visualEffectView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}
#pragma mark - 删除标题为“itemTitle”的所有可选按钮
- (void)deleteItem:(NSString *)itemTitle
{
    // 记录原来的个数
    NSInteger oldCount = self.optionalItems.count;
    
    // 删除数据
    [self.optionalItems removeObject:itemTitle];
    
    // 计算被删除的按钮个数
    NSInteger deleteCount = oldCount - self.optionalItems.count;
    
    // 删除多余的按钮
    if (deleteCount > 0) {
        for (NSInteger i = 0; i < deleteCount; i++) {
            for (JPAlertViewOptionalItem *item in [self subviews]) {
                if ([item isKindOfClass:[JPAlertViewOptionalItem class]] && item.tag >= 10000) {
                    [item removeFromSuperview];
                    break;
                }
            }
        }
    }
    
    // 重新设置按钮的标题、tag值和位置
    NSInteger index = 0;
    for (JPAlertViewOptionalItem *item in [self subviews]) {
        if ([item isKindOfClass:[JPAlertViewOptionalItem class]] && item.tag >= 10000) {
            item.title = self.optionalItems[index];
            item.tag = 10000 + index;
            item.frame = CGRectMake(item.frame.origin.x, 10 + item.frame.size.height * index, item.frame.size.width, item.frame.size.height);
        }
    }
    
    // 重新设置尺寸
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 20 * self.optionalItems.count + (self.optionalItems.count > 0 ? 20 : 0));
    self.visualEffectView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}
#pragma mark - 删除某个坐标下的可选按钮
- (void)deleteOneItemAtIndex:(NSInteger)index
{
    // 判断是否越界
    if (index > self.optionalItems.count - 1) {
        NSLog(@"JPAlertViewOptionalItemView删除可选按钮时下标“%ld”越界", index);
        return;
    }
    
    // 删除数据
    [self.optionalItems removeObjectAtIndex:index];
    
    // 调整部分按钮的tag值和位置
    for (JPAlertViewOptionalItem *item in [self subviews]) {
        if ([item isKindOfClass:[JPAlertViewOptionalItem class]] && item.tag >= (10000 + index)) {
            item.tag--;
            item.frame = CGRectMake(item.frame.origin.x, item.frame.size.height * (item.tag - 10000), item.frame.size.width, item.frame.size.height);
        }
    }
    
    // 重新设置尺寸
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 20 * self.optionalItems.count + (self.optionalItems.count > 0 ? 20 : 0));
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
