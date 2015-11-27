//
//  LayerKeyPathAnimationViewController.m
//  Layer学习整理Demo
//
//  Created by baiqiang on 15/11/24.
//  Copyright © 2015年 baiqiang. All rights reserved.
//

#import "LayerKeyPathAnimationViewController.h"
#import "ClockView.h"
#import "ShipView.h"

static CGFloat const spacing = 20;

@interface LayerKeyPathAnimationViewController ()
@property (nonatomic, strong) NSArray *buttonTitle;
@property (nonatomic, strong) UIButton *preBtn;
@property (nonatomic, strong) UIView *disView;
@end

@implementation LayerKeyPathAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initUI];
}
- (void)initData {
    self.buttonTitle = @[
                         @"时钟",
                         @"飞船",
                         ];
}
- (void)initUI {
    NSInteger count = self.buttonTitle.count;
    CGFloat buttonWidth = (screenWidth - spacing * (count + 1))/ (CGFloat)count;
    for (int i = 0; i < count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(spacing + (buttonWidth + spacing) * i , CGRectGetMaxY(self.navigationController.navigationBar.frame) + 10, buttonWidth, 40);
        [btn setTitle:self.buttonTitle[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(btnClickedEvent:) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor = [UIColor grayColor];
        btn.layer.cornerRadius = 5;
        btn.clipsToBounds = YES;
        [self.view addSubview:btn];
        if (i == 0) {
            [self btnClickedEvent:btn];
        }
    }
}
- (void)btnClickedEvent:(UIButton *)btn {
    _preBtn.selected = !_preBtn.selected;
    btn.selected = !btn.selected;
    _preBtn = btn;
    if (_disView != nil) {
        [_disView removeFromSuperview];
    }
    UIView *disView;
    if ([btn.currentTitle isEqualToString:@"时钟"]) {
        disView = [[ClockView alloc] initWithFrame:CGRectMake(0, 0, 250, 250)];
    }else {
        disView = [[ShipView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 400)];
    }
    disView.center = self.view.center;
    [self.view addSubview:disView];
    _disView = disView;
}
@end
