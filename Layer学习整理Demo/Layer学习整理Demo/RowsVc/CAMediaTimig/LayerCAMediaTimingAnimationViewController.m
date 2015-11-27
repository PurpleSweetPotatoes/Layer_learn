//
//  LayerCAMediaTimingAnimationViewController.m
//  Layer学习整理Demo
//
//  Created by baiqiang on 15/11/24.
//  Copyright © 2015年 baiqiang. All rights reserved.
//

#import "LayerCAMediaTimingAnimationViewController.h"

@interface LayerCAMediaTimingAnimationViewController ()
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *timeoffset;
@property (weak, nonatomic) IBOutlet UILabel *speed;
@property (nonatomic, strong) CALayer *shipLayer;
@property (nonatomic, strong) UIBezierPath *bezierPath;
@end

@implementation LayerCAMediaTimingAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.contentView.layer addSublayer:self.shipLayer];
    
    CAShapeLayer *shape = [CAShapeLayer layer];
    shape.strokeColor = [UIColor redColor].CGColor;
    shape.lineWidth = 3.0f;
    shape.path = self.bezierPath.CGPath;
    shape.fillColor = [UIColor clearColor].CGColor;
    [self.contentView.layer addSublayer:shape];
    
    self.timeoffset.text = @"0.50";
    self.speed.text = @"0.50";
}

- (IBAction)btnClickedEvent:(UIButton *)sender {
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animation];
    keyAnimation.keyPath = @"position";
    keyAnimation.duration = 3.0f;
    //设置动画的速度,默认为1标准速度，
    keyAnimation.speed = [self.speed.text floatValue];
    //时间偏移，让动画执行起始位置为正常动画time时间后动画的位置
    keyAnimation.timeOffset = [self.timeoffset.text floatValue];
    keyAnimation.path = self.bezierPath.CGPath;
    keyAnimation.rotationMode = kCAAnimationRotateAuto;
    
    [self.shipLayer addAnimation:keyAnimation forKey:nil];
}
- (IBAction)sliderTime:(UISlider *)sender {
    CGFloat offset = sender.value;
    self.timeoffset.text = [NSString stringWithFormat:@"%.2f",offset];
}
- (IBAction)sliderSpeed:(UISlider *)sender {
    CGFloat offset = sender.value;
    self.speed.text = [NSString stringWithFormat:@"%.2f",offset];
}

- (CALayer *)shipLayer {
    if (_shipLayer == nil) {
        CALayer *shipLayer = [CALayer layer];
        shipLayer.frame = CGRectMake(0, 0, 64, 32);
        shipLayer.position = CGPointMake(0, 150);
        shipLayer.contents = (__bridge id)[UIImage imageNamed:@"feichuan_03"].CGImage;
        _shipLayer = shipLayer;
    }
    return _shipLayer;
}
- (UIBezierPath *)bezierPath {
    if (_bezierPath == nil) {
        CGFloat centerX = self.view.width * 0.5;
        self.shipLayer.position = CGPointMake(centerX , self.contentView.height);
        UIBezierPath *bezier = [UIBezierPath bezierPath];
        [bezier moveToPoint:CGPointMake(centerX , self.contentView.height)];
        [bezier addCurveToPoint:CGPointMake(centerX, self.contentView.height * 0.4) controlPoint1:CGPointMake(0, self.contentView.height * 0.8) controlPoint2:CGPointMake(self.contentView.width , self.contentView.height * 0.6)];
        [bezier addLineToPoint:CGPointMake(centerX, self.contentView.height * 0.1)];
        _bezierPath = bezier;
    }
    return _bezierPath;
}
@end
