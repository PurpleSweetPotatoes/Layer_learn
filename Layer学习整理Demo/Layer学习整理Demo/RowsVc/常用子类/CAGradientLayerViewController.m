//
//  CAGradientLayerViewController.m
//  Layer学习整理Demo
//
//  Created by baiqiang on 15/11/26.
//  Copyright © 2015年 baiqiang. All rights reserved.
//

#import "CAGradientLayerViewController.h"

@interface CAGradientLayerViewController ()

@end

@implementation CAGradientLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createGradientLayer];
}

- (void)createGradientLayer {
    CAGradientLayer *gradLayer = [CAGradientLayer layer];
    gradLayer.frame = CGRectMake(0, 0, 200, 200);
    gradLayer.position = self.view.center;
    //渲染颜色数组集合
    gradLayer.colors = @[(__bridge id)[UIColor redColor].CGColor ,(__bridge id)[UIColor greenColor].CGColor,(__bridge id)[UIColor blueColor].CGColor];
    //渲染起始点和重点(0,0)左上角(1,1)右下角
    gradLayer.startPoint = CGPointMake(0, 0);
    gradLayer.endPoint = CGPointMake(1, 1);
    //渲染位置点(大小需与渲染颜色数组大小一致，否则渲染无效)
    gradLayer.locations = @[@(0.25),@(0.5),@(0.75)];
    
    [self.view.layer addSublayer:gradLayer];
}


@end
