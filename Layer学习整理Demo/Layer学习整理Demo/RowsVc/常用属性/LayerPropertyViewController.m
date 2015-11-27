//
//  LayerPropertyViewController.m
//  Layer学习整理Demo
//
//  Created by baiqiang on 15/11/24.
//  Copyright © 2015年 baiqiang. All rights reserved.
//

#import "LayerPropertyViewController.h"
#import "LayerView.h"
#import "DelegateLayerView.h"
#import "ShadowLayerView.h"
#import "MaskLayerView.h"


static CGFloat spacing = 5;
@interface LayerPropertyViewController ()

@property (nonatomic, strong) NSArray *buttonTitle;
@property (nonatomic, strong) UIView *disView;
@property (nonatomic, strong) UIButton *preBtn;
@end

@implementation LayerPropertyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor cyanColor];
    [self initData];
    [self initUI];
}
- (void)initData {
    self.buttonTitle = @[
                         @"普通",
                         @"代理",
                         @"阴影",
                         @"蒙版"];
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
    if (self.disView != nil) {
        [self.disView removeFromSuperview];
    }
    NSUInteger index = [self.buttonTitle indexOfObject:[btn currentTitle]];
    UIView *disView;
    switch (index) {
        case 0:
            disView = [[LayerView alloc] initWithFrame:CGRectMake(0, 0, screenWidth * 0.5, screenWidth * 0.5)];
            break;
        case 1:
            disView = [[DelegateLayerView alloc] initWithFrame:CGRectMake(0, 0, screenWidth * 0.5, screenWidth * 0.5)];
            break;
        case 2:
            disView = [[ShadowLayerView alloc] initWithFrame:CGRectMake(0, 0, screenWidth * 0.5, screenWidth * 0.5)];
            break;
        case 3:
            disView = [[MaskLayerView alloc] initWithFrame:CGRectMake(0, 0, screenWidth * 0.5, screenWidth * 0.5)];
            break;
        default:
            break;
    }
    disView.center = self.view.center;
    [self.view addSubview:disView];
    _disView = disView;
}






@end
