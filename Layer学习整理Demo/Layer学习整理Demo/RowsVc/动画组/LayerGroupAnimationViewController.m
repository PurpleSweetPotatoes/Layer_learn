//
//  LayerGroupAnimationViewController.m
//  Layer学习整理Demo
//
//  Created by baiqiang on 15/11/24.
//  Copyright © 2015年 baiqiang. All rights reserved.
//

#import "LayerGroupAnimationViewController.h"

@interface LayerGroupAnimationViewController ()

@end

@implementation LayerGroupAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self statrGroupAnimation];
}
- (void)statrGroupAnimation {
    CGFloat centerX = self.view.center.x;
    CGFloat viewHeight = self.view.height;
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(centerX, viewHeight * 0.8)];
    [bezierPath addLineToPoint:CGPointMake(centerX, viewHeight * 0.6)];
    [bezierPath addArcWithCenter:CGPointMake(centerX, viewHeight * 0.4 - 50) radius:50 startAngle:M_PI_2 endAngle: M_PI * 2  + M_PI_2 clockwise:YES];
    
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.path = bezierPath.CGPath;
    pathLayer.strokeColor = [UIColor blackColor].CGColor;
    pathLayer.fillColor = [UIColor clearColor].CGColor;
    pathLayer.lineWidth = 3.0f;
    [self.view.layer addSublayer:pathLayer];
    
    
    CALayer *colorLayer = [CALayer layer];
    colorLayer.backgroundColor = [UIColor blueColor].CGColor;
    colorLayer.frame = CGRectMake(0, 0, 50, 50);
    colorLayer.position = CGPointMake(0 , 150);
    [self.view.layer addSublayer:colorLayer];
    
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animation];
    keyAnimation.keyPath = @"position";
    //    keyAnimation.duration = 3.0f;
    keyAnimation.path = bezierPath.CGPath;
    
    CABasicAnimation *basicAnimation = [CABasicAnimation animation];
    basicAnimation.keyPath = @"backgroundColor";
    //    basicAnimation.duration = 3.0f;
    basicAnimation.toValue = (__bridge id)[UIColor redColor].CGColor;
    
    //设置动画组
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    group.duration = 2.0f;
    group.animations = @[keyAnimation, basicAnimation];
    
    
    [colorLayer addAnimation:group forKey:nil];
}

@end
