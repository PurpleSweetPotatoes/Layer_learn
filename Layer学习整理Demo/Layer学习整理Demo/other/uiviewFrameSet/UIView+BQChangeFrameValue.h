//
//  UIView+BQChangeFrameValue.h
//  模态推送动画
//
//  Created by baiqiang on 15/9/17.
//  Copyright (c) 2015年 baiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height

@interface UIView (BQChangeFrameValue)

@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@end
