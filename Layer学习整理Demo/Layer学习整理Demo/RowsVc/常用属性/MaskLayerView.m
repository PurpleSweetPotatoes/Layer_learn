//
//  MaskLayerView.m
//  Layer学习整理Demo
//
//  Created by baiqiang on 15/11/25.
//  Copyright © 2015年 baiqiang. All rights reserved.
//

#import "MaskLayerView.h"

@implementation MaskLayerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self != nil) {
        [self showMaskLayer];
    }
    return self;
}
/**
 *  蒙版有颜色的地方都会透出蒙版下方的视图图像，其他遮盖的地方会显示父视图的背景色
 */
- (void)showMaskLayer {
    //创建图层
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    imageView.image = [UIImage imageNamed:@"boat.jpg"];
    //添加图层
    [self addSubview:imageView];
    //创建蒙版
    CALayer *layer = [CALayer layer];
    layer.frame = self.bounds;
    //此处以图像做蒙版
    layer.contents = (__bridge id)[UIImage imageNamed:@"mask"].CGImage;
    //设置图层蒙版
    imageView.layer.mask = layer;
    
}
@end
