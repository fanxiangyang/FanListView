//
//  FanDrawLayer.h
//  FanTest
//
//  Created by 向阳凡 on 2018/6/26.
//  Copyright © 2018年 向阳凡. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FanDrawLayer : NSObject


/**
 画虚线框

 @param lineWidth 线宽
 @param lineColor 线的颜色
 @param cornerRadius 圆角半径
 @param frame 虚线区域
 @return layre
 */
+(CAShapeLayer *)fan_dottedLineWith:(CGFloat)lineWidth lineColor:(UIColor *)lineColor cornerRadius:(CGFloat)cornerRadius frame:(CGRect)frame;

/**
 获取圆环进度

 @param progress 进度0-1
 @param rightWidth 圆环宽度
 @param ringColor 圆环颜色
 @param center 圆心坐标
 @param radius 最大圆半径
 @param startAngle 进度的开始坐标
 @return layer
 */
+(CAShapeLayer *)fan_ringProgress:(CGFloat)progress ringWidth:(CGFloat)rightWidth ringColor:(UIColor *)ringColor Center:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle;
/**
 获取渐变色Layer就两种（水平和垂直）
 
 @param frame 渐变区域
 @param startColor 开始颜色
 @param endColor 结束颜色
 @param isVertical 是垂直吗
 @return 渐变Layer
 */
+(CAGradientLayer*)fan_gradientLayerFrame:(CGRect)frame startColor:(UIColor *)startColor endColor:(UIColor *)endColor isVertical:(BOOL)isVertical;
+(CAGradientLayer*)fan_gradientLayerFrame:(CGRect)frame startColor:(UIColor *)startColor endColor:(UIColor *)endColor isVertical:(BOOL)isVertical locations:(NSArray *)locations;
/**
 生成三角形

 @param fillColor 填充颜色
 @param topPoint 顶点
 @param leftPoint 左边点
 @param rightPoint 右边点
 @return 三角形layer
 */
+(CAShapeLayer *)fan_triangleFillColor:(UIColor *)fillColor topPoint:(CGPoint)topPoint leftPoint:(CGPoint)leftPoint rightPoint:(CGPoint)rightPoint;
@end
