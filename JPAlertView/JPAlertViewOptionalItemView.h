//
//  JPAlertViewOptionalItemView.h
//  JPAlertView
//
//  Created by ovopark_iOS on 16/7/26.
//  Copyright © 2016年 JaryPan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JPAlertViewOptionalItem.h"

@protocol JPAlertViewOptionalItemViewDelegate;

@interface JPAlertViewOptionalItemView : UIView

// 初始化方法
- (instancetype)initWithFrame:(CGRect)frame OptionalItems:(NSArray<NSString *> *)optionalItems;

// 代理属性
@property (weak, nonatomic) id<JPAlertViewOptionalItemViewDelegate>delegate;

// 插入一个可选按钮（默认处于最后一个位置）
- (void)insertItem:(NSString *)itemTitle;
// 在某个下标处插入一个可选按钮
- (void)insertOneItem:(NSString *)itemTitle atIndex:(NSInteger)index;
// 删除标题为“itemTitle”的所有可选按钮
- (void)deleteItem:(NSString *)itemTitle;
// 删除某个坐标下的可选按钮
- (void)deleteOneItemAtIndex:(NSInteger)index;

@end

// 代理方法
@protocol JPAlertViewOptionalItemViewDelegate <NSObject>

@optional
- (void)optionalItemView:(JPAlertViewOptionalItemView *)optionalItemView selectOptionalItemAtIndex:(NSInteger)itemIndex;
- (void)optionalItemView:(JPAlertViewOptionalItemView *)optionalItemView deselectOptionalItemAtIndex:(NSInteger)itemIndex;

@end
