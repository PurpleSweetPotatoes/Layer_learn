//
//  TestView.m
//  13.3脏矩形
//
//  Created by baiqiang on 15/11/18.
//  Copyright © 2015年 baiqiang. All rights reserved.
//

#import "TestView.h"

#define BRUSH_SIZE 32
@interface TestView()

//用以存储点的路径
@property (nonatomic, strong) NSMutableArray *strokes;

@end

@implementation TestView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _strokes = [NSMutableArray array];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint point = [[touches anyObject] locationInView:self];
    [self addBrushStrok:point];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint point = [[touches anyObject] locationInView:self];
    [self addBrushStrok:point];
}

/**
 *  根据点来确定其绘制区域
 */
- (CGRect)brushRectWithPoint:(CGPoint) point{
    CGRect brushRect = CGRectMake(point.x - BRUSH_SIZE/2, point.y - BRUSH_SIZE/2, BRUSH_SIZE, BRUSH_SIZE);
    return brushRect;
}
- (void)addBrushStrok:(CGPoint)point {
    [_strokes addObject:[NSValue valueWithCGPoint:point]];
    
    //方案一:直接重新绘制所有区域，性能浪费严重
//    [self setNeedsDisplay];
    
    //方案二:利用此方法只重绘对应部分的视图，这样不用重绘整个屏幕，性能相对来说提升较大
    [self setNeedsDisplayInRect:[self brushRectWithPoint:point]];
}

- (void)drawRect:(CGRect)rect {
    for (NSValue *value in _strokes) {
        CGPoint point = [value CGPointValue];
        CGRect brushRect = [self brushRectWithPoint:point];
        
        //方案一:直接重新绘制所有区域，性能浪费严重
        [[UIImage imageNamed:@"ball"] drawInRect:brushRect];
        
        //方案二:如果重绘区域相交则都重绘否则不重绘，提升效率
//        if (CGRectIntersectsRect(rect, brushRect)) {
//            [[UIImage imageNamed:@"ball"] drawInRect:brushRect];
//        }
        

    }
}

@end
