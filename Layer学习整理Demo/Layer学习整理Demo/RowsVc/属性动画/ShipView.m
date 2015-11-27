//
//  ShipView.m
//  Layer学习整理Demo
//
//  Created by baiqiang on 15/11/26.
//  Copyright © 2015年 baiqiang. All rights reserved.
//

#import "ShipView.h"

@interface ShipView ()
@property (nonatomic, strong) CALayer *shipLayer;
@end

@implementation ShipView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createShipLayer];
    }
    return self;
}
- (void)createShipLayer {
    //设置bezier曲线
    CGFloat centerX = self.width * 0.5;
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(centerX , self.height)];
    [bezierPath addCurveToPoint:CGPointMake(centerX, self.height * 0.4) controlPoint1:CGPointMake(0, self.height * 0.8) controlPoint2:CGPointMake(self.width , self.height * 0.6)];
    [bezierPath addLineToPoint:CGPointMake(centerX, self.height * 0.1)];
    //绘制路径
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = bezierPath.CGPath;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = [UIColor redColor].CGColor;
    layer.lineWidth = 3.0f;
    [self.layer addSublayer:layer];
    //设置飞船layer层
    CALayer *shiplayer = [CALayer layer];
    shiplayer.contents = (__bridge id)[UIImage imageNamed:@"feichuan_03"].CGImage;
    shiplayer.position = CGPointMake(0, 150);
    shiplayer.frame = CGRectMake(0, 0, 64, 32);
    [self.layer addSublayer:shiplayer];
    _shipLayer = shiplayer;
    //设置飞船动画
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    //设置动画关联的属性
    animation.keyPath = @"position";
    animation.duration = 2.0f;
    //当动画完成后不移除
    animation.removedOnCompletion = NO;
    //保持动画后的效果状态
    animation.fillMode = kCAFillModeForwards;
    //设置动画代理
    animation.delegate = self;
    //设置动画路径
    animation.path = bezierPath.CGPath;
    //让动画沿切线角度旋转
    animation.rotationMode = kCAAnimationRotateAuto;
    
    [shiplayer addAnimation:animation forKey:@"ship"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (flag == YES) {
        CABasicAnimation *basicAnimation = [CABasicAnimation animation];
        basicAnimation.duration = 1.0f;
        //transform有虚拟属性(实际不存在)
        basicAnimation.keyPath = @"transform.rotation";
        basicAnimation.toValue = @(M_PI * 2);
        [_shipLayer addAnimation:basicAnimation forKey:@"test"];
    }
}
@end
