//
//  ChangeViewViewController.m
//  Layer学习整理Demo
//
//  Created by baiqiang on 15/11/26.
//  Copyright © 2015年 baiqiang. All rights reserved.
//

#import "ChangeViewViewController.h"

@interface ChangeViewViewController ()

@end

@implementation ChangeViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];
    [self createBtn];
}

- (void)createBtn {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 100, 30);
    btn.center = self.view.center;
    [btn setTitle:@"点击变换" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnclickedEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
- (void)btnclickedEvent:(UIButton *)btn {
    //开启图像上下文设置大小
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, YES, 0.0);
    //利用layer将图像保存至当前图像上下文中
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    //获取当前上下文图像
    UIImage *coverImage = UIGraphicsGetImageFromCurrentImageContext();
    //以截取图像创建View并加载
    UIView *coverView = [[UIImageView alloc] initWithImage:coverImage];
    [self.view addSubview:coverView];
    //设置页面背景色
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    self.view.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    [UIView animateWithDuration:1.0f animations:^{
        CGAffineTransform transform = CGAffineTransformMakeScale(0.01, 0.01);
        transform = CGAffineTransformRotate(transform, M_PI);
        coverView.transform = transform;
        coverView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [coverView removeFromSuperview];
    }];
}

@end
