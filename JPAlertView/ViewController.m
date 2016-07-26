//
//  ViewController.m
//  JPAlertView
//
//  Created by ovopark_iOS on 16/6/20.
//  Copyright © 2016年 JaryPan. All rights reserved.
//

#import "ViewController.h"
#import "JPAlertView.h"
#import "JPAlertViewOptionalItem.h"


@interface ViewController () <JPAlertViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)showAlertView:(id)sender {
    JPAlertView *alertView = [[JPAlertView alloc] initWithTitle:@"鹧鸪天" message:nil delegate:self optionalItems:@[@"选项一", @"选项二"] cancelButtonTitle:@"取消" otherButtonTitles:@"好的", nil];
    alertView.message = @"彩袖殷勤捧玉钟，当年拼却醉颜红。\n舞低杨柳楼心月，歌尽桃花扇底风。\n从别后，忆相逢，几回魂梦与君同？\n今宵剩把银缸照，犹恐相逢是梦中。";
    [alertView show:^{
        // 弹框出现之后可以在block里面做其他操作，也可以在代理方法中监测弹框的出现
    }];
}

- (void)alertView:(JPAlertView *)alertView selectOptionalItemAtIndex:(NSInteger)itemIndex
{
    NSLog(@"选中可选按钮%ld", itemIndex);
}
- (void)alertView:(JPAlertView *)alertView deselectOptionalItemAtIndex:(NSInteger)itemIndex
{
    NSLog(@"取消选中可选按钮%ld", itemIndex);
}
- (void)alertView:(JPAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"点击了按钮 buttonIndex = %ld", buttonIndex);
}

// before animation and showing view
- (BOOL)willPresentAlertView:(JPAlertView *)alertView
{
    // 如果返回NO，弹框将不再弹出
    NSLog(@"将要出现");
    return YES;
}

// after animation
- (void)didPresentAlertView:(JPAlertView *)alertView
{
    NSLog(@"已经出现");
}

// before animation and hiding view
- (BOOL)alertView:(JPAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    // 如果返回NO，弹框将不会消失
    NSLog(@"将要消失 buttonIndex = %ld", buttonIndex);
    return YES;
}

// after animation
- (void)alertView:(JPAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"已经消失 buttonIndex = %ld", buttonIndex);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
