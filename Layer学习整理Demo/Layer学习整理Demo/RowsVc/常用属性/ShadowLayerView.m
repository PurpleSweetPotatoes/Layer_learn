//
//  ShadowLayerView.m
//  Layer学习整理Demo
//
//  Created by baiqiang on 15/11/25.
//  Copyright © 2015年 baiqiang. All rights reserved.
//

#import "ShadowLayerView.h"

@implementation ShadowLayerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self != nil) {
        [self setShadowLayer];
    }
    return self;
}
- (void)setShadowLayer {
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ball"]];
    imageView.frame = CGRectMake(0, 0, 200, 200);
    imageView.layer.cornerRadius = 100;
    imageView.clipsToBounds = YES;
#warning 若设置了裁剪 则会导致阴影设置无效，此时只能通过添加层阴影图层来实现阴影效果
    //创建阴影图
    UIView *shadowView = [[UIView alloc] initWithFrame:imageView.bounds];
    shadowView.center = self.center;
    //设置阴影透明度,默认为0，需要大于0才有阴影效果
    shadowView.layer.shadowOpacity = 0.8;
    //阴影偏移量,默认(0,-3)
    shadowView.layer.shadowOffset = CGSizeMake(4, 4);
    //阴影模糊度值越大 模糊度越高 层次感越强
    shadowView.layer.shadowRadius = 5;
    //最后设置圆弧度
    shadowView.layer.cornerRadius = 100;
    
    [shadowView addSubview:imageView];
    [self addSubview:shadowView];
    
}
@end
