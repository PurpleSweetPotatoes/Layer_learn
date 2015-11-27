//
//  LayerView.m
//  Layer学习整理Demo
//
//  Created by baiqiang on 15/11/25.
//  Copyright © 2015年 baiqiang. All rights reserved.
//

#import "LayerView.h"

@implementation LayerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self != nil) {
        [self showCustomLayer];
    }
    return self;
}

/**
 *  普通layer常用属性
 */
- (void)showCustomLayer {
    //create image
    UIImage *image = [UIImage imageNamed:@"boat.jpg"];
    //create layer
    CALayer *layer = [CALayer layer];
    //set layerFrame like view
    layer.frame = self.bounds;
    //set layer.contents it faster than imageView
    layer.contents = (__bridge id)image.CGImage;
    //The mode like View.contentMode
    layer.contentsGravity = kCAGravityCenter;
    //This is Stretch by This Rect
    layer.contentsRect = CGRectMake(0, 0, 1, 1);
    //layer的分辨率设置,defualt is 1;Retina is 2
    layer.contentsScale = [UIScreen mainScreen].scale;
    //position like view center
    layer.position = self.center;
    //add layer to view.layer
    [self.layer addSublayer:layer];
}

@end
