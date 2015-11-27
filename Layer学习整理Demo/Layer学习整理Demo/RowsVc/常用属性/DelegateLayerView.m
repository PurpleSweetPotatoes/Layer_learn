//
//  DelegateLayerView.m
//  Layer学习整理Demo
//
//  Created by baiqiang on 15/11/25.
//  Copyright © 2015年 baiqiang. All rights reserved.
//

#import "DelegateLayerView.h"

@implementation DelegateLayerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self != nil) {
        [self layerDelegate];
    }
    return self;
}
/**
 *  layer delegate Method
 */
- (void)layerDelegate {
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 0, 100, 100);
    layer.position = self.center;
    //set backgroundColor use CGColor
    layer.backgroundColor = [UIColor grayColor].CGColor;
    /**
     *  if set layer delegate when self will be dealloc must set layer delegate is nil or remove The layer,
     */
//    layer.delegate = self;
    //set scale
    layer.contentsScale = [UIScreen mainScreen].scale;
    [self.layer addSublayer:layer];
    //重绘layer
//    [layer display];
}
//设置代理后重绘layer代理方法
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    CGContextSetLineWidth(ctx, 2.0f);
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextStrokeEllipseInRect(ctx,layer.bounds);
}
@end
