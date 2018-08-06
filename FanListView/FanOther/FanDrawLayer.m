//
//  FanDrawLayer.m
//  FanTest
//
//  Created by 向阳凡 on 2018/6/26.
//  Copyright © 2018年 向阳凡. All rights reserved.
//

#import "FanDrawLayer.h"

@implementation FanDrawLayer

+(CAShapeLayer *)fan_dottedLineWith:(CGFloat)lineWidth lineColor:(UIColor *)lineColor cornerRadius:(CGFloat)cornerRadius frame:(CGRect)frame{
    CAShapeLayer *layer=[[CAShapeLayer alloc]init];
    layer.lineWidth=lineWidth;
    layer.strokeColor=lineColor.CGColor;
    layer.fillColor=[UIColor clearColor].CGColor;
    layer.lineDashPattern=@[@(lineWidth),@(lineWidth)];
    UIBezierPath* path = [UIBezierPath bezierPathWithRoundedRect:frame cornerRadius:cornerRadius];
    layer.path=[path CGPath];
    return layer;
}
+(CAShapeLayer *)fan_ringProgress:(CGFloat)progress ringWidth:(CGFloat)rightWidth ringColor:(UIColor *)ringColor Center:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle{
    CAShapeLayer *layer=[[CAShapeLayer alloc]init];
    layer.name=@"FanRingLayer";
    layer.lineWidth=rightWidth;
    layer.strokeColor=ringColor.CGColor;
    layer.fillColor=[UIColor clearColor].CGColor;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:startAngle+progress*2*M_PI clockwise:YES];
    layer.path=[path CGPath];

    return layer;
}
+(CAGradientLayer*)fan_gradientLayerFrame:(CGRect)frame startColor:(UIColor *)startColor endColor:(UIColor *)endColor isVertical:(BOOL)isVertical{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)startColor.CGColor, (__bridge id)endColor.CGColor];
    gradientLayer.locations = @[@(0.5), @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    if (isVertical) {
        gradientLayer.endPoint = CGPointMake(0, 1.0);
    }else{
        gradientLayer.endPoint = CGPointMake(1.0, 0);
    }
    gradientLayer.frame =frame;
    
    return gradientLayer;
}
+(CAGradientLayer*)fan_gradientLayerFrame:(CGRect)frame startColor:(UIColor *)startColor endColor:(UIColor *)endColor isVertical:(BOOL)isVertical locations:(NSArray *)locations{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)startColor.CGColor, (__bridge id)endColor.CGColor];
    gradientLayer.locations = locations;
    gradientLayer.startPoint = CGPointMake(0, 0);
    if (isVertical) {
        gradientLayer.endPoint = CGPointMake(0, 1.0);
    }else{
        gradientLayer.endPoint = CGPointMake(1.0, 0);
    }
    gradientLayer.frame =frame;
    
    return gradientLayer;
}

+(CAShapeLayer *)fan_triangleFillColor:(UIColor *)fillColor topPoint:(CGPoint)topPoint leftPoint:(CGPoint)leftPoint rightPoint:(CGPoint)rightPoint {
    CAShapeLayer *layer=[[CAShapeLayer alloc]init];
    //    layer.strokeColor=lineColor.CGColor;
    layer.fillColor=fillColor.CGColor;
    UIBezierPath* path = [UIBezierPath bezierPath];
    [path moveToPoint:topPoint];
    [path addLineToPoint:leftPoint];
    [path addLineToPoint:rightPoint];
    layer.path=[path CGPath];
    return layer;
}
@end
