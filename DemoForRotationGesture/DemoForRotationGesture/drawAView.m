//
//  drawAView.m
//  DemoForRotationGesture
//
//  Created by 林林尤达 on 17/2/8.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import "drawAView.h"
#define SCREEN_WIDTH    [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT   [[UIScreen mainScreen] bounds].size.height
@implementation drawAView

- (void)drawRect:(CGRect)rect {
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();//获取上下文
    
    CGPoint center = CGPointMake(SCREEN_WIDTH/2, SCREEN_WIDTH *0.68/2);  //设置圆心位置
    CGFloat radius = 125;  //设置半径
    CGFloat startA = - M_PI_2;  //圆起点位置
//    CGFloat endA = -M_PI_2 + M_PI * 2 * _progress;  //圆终点位置
    CGFloat endA = _nowProgress+_progress;
    _nowProgress = endA;
    if (_nowProgress>=2*M_PI){
        _nowProgress =2*M_PI;
        endA = 2*M_PI;
    }else if (_nowProgress<=0){
        _nowProgress = 0;
        endA = 0;
    }
    CGFloat finall= endA +startA;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:finall clockwise:YES];
    
    CGContextSetLineWidth(ctx, 10); //设置线条宽度
    [[UIColor blueColor] setStroke]; //设置描边颜色

    CGContextAddPath(ctx, path.CGPath); //把路径添加到上下文
    
    CGContextStrokePath(ctx);  //渲染
}

//外部改变值的时候重绘
- (void)drawProgress:(CGFloat)progress
{
    _progress = progress;
    [self setNeedsDisplay];
}
@end
