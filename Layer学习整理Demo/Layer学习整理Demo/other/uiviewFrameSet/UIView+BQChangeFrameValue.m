//
//  UIView+BQChangeFrameValue.m
//  模态推送动画
//
//  Created by baiqiang on 15/9/17.
//  Copyright (c) 2015年 baiqiang. All rights reserved.
//

#import "UIView+BQChangeFrameValue.h"

@implementation UIView (BQChangeFrameValue)

- (void)setOrigin:(CGPoint)origin{
    CGRect rect = self.frame;
    rect.origin = origin;
    self.frame = rect;
}
- (CGPoint)origin{
    return self.frame.origin;
}

- (void)setX:(CGFloat)x{
    CGRect rect = self.frame;
    rect.origin.x  = x;
    self.frame = rect;
}
- (CGFloat)x{
    return self.origin.x;
}

- (void)setY:(CGFloat)y{
    CGRect rect = self.frame;
    rect.origin.y  = y;
    self.frame = rect;
}
- (CGFloat)y{
    return self.origin.y;
}

- (void)setSize:(CGSize)size{
    CGRect rect = self.frame;
    rect.size = size;
    self.frame = rect;
}
- (CGSize)size{
    return self.frame.size;
}

- (void)setWidth:(CGFloat)width{
    CGRect rect = self.frame;
    rect.size.width  = width;
    self.frame = rect;
}
- (CGFloat)width{
    return self.size.width;
}

- (void)setHeight:(CGFloat)height{
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
}
- (CGFloat)height{
    return self.size.height;
}
@end
