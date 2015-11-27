//
//  CAShapeLayerViewController.m
//  Layer学习整理Demo
//
//  Created by baiqiang on 15/11/26.
//  Copyright © 2015年 baiqiang. All rights reserved.
//

#import "CAShapeLayerViewController.h"

@interface CAShapeLayerViewController ()

@end

@implementation CAShapeLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**
     *  渲染快速，高效使用内存，不会被图层边界裁剪，不会出现像素化
     */
    //可直接理解为画图layer
    CAShapeLayer *layer = [CAShapeLayer layer];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:CGPointMake(175, 150) radius:50 startAngle:0 endAngle:2 * M_PI clockwise:YES];
    [path moveToPoint:CGPointMake(175, 200)];
    [path addLineToPoint:CGPointMake(175, 400)];
    [path moveToPoint:CGPointMake(175, 250)];
    [path addLineToPoint:CGPointMake(125, 300)];
    [path moveToPoint:CGPointMake(175, 250)];
    [path addLineToPoint:CGPointMake(225, 300)];
    [path moveToPoint:CGPointMake(175, 400)];
    [path addLineToPoint:CGPointMake(125, 500)];
    [path moveToPoint:CGPointMake(175, 400)];
    [path addLineToPoint:CGPointMake(225, 500)];
    
    //线宽
    layer.lineWidth = 4;
    //线条颜色
    layer.strokeColor = [UIColor redColor].CGColor;
    //线条起始点的类型
    layer.lineJoin = kCALineJoinRound;
    layer.lineCap = kCALineCapRound;
    //填充色
    layer.fillColor = [UIColor clearColor].CGColor;
    //线条路径
    layer.path = path.CGPath;
    
    [self.view.layer addSublayer:layer];
}


@end
