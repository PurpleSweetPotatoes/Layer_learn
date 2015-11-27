//
//  DrawView.m
//  13.2矢量图形
//
//  Created by baiqiang on 15/11/18.
//  Copyright © 2015年 baiqiang. All rights reserved.
//

#import "DrawView.h"

@interface DrawView()

@property (nonatomic, strong) UIBezierPath *bezier;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@end

@implementation DrawView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _bezier = [UIBezierPath bezierPath];
        //利用layer来重绘 能适当提高效率
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.frame = self.bounds;
        shapeLayer.strokeColor = [UIColor redColor].CGColor;
        shapeLayer.lineWidth = 2.0;
        shapeLayer.fillColor = [UIColor clearColor].CGColor;
        [self.layer addSublayer:shapeLayer];
        _shapeLayer = shapeLayer;
    }
    return self;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    [_bezier moveToPoint:point];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    [_bezier addLineToPoint:point];
    _shapeLayer.path = _bezier.CGPath;
//    [self setNeedsDisplay];
}
/**
 *  这样实现的问题在于，我们画得越多，程序就会越慢。因为每次移动手指的时候都会重绘整个贝塞尔路径（UIBezierPath），随着路径越来越复杂，每次重绘的工作就会增加，直接导致了帧数的下降
 - (void)drawRect:(CGRect)rect {
 [[UIColor clearColor] setFill];
 [[UIColor redColor] setStroke];
 [_bezier stroke];
 }
 */

@end
