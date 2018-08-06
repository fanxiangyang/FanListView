//
//  FanUIKit.h
//  FanKit
//
//  Created by 向阳凡 on 16/7/4.
//  Copyright © 2016年 凡向阳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FanUIKit : NSObject


#pragma mark - UITextView,Label文本高度
/** 根据TextView动态控制高度并返回高度
 *  lineSpace:行间距
 */
+ (CGFloat)fan_measureHeightOfUITextView:(UITextView *)fanTextView andLineSpace:(NSInteger)lineSpace;
/** 根据文本的内容，计算字符串的大小
 *  根据换行方式和字体的大小，已经计算的范围来确定字符串的size
 */
+(CGSize)fan_currentSizeWithContent:(NSString *)content font:(UIFont *)font cgSize:(CGSize)cgsize;
#pragma mark - 字节个数
/** 字节个数 */
+(NSUInteger) fan_unicodeLengthOfString: (NSString *) text;
#pragma mark - 颜色转化From:#FD87ED To:UIColor
/** 颜色转化From:#FD87ED To:UIColor */
+ (UIColor *)fan_colorFromHexColor:(NSString *)hexColor;
#pragma mark - 图片的处理
/** 等比例缩放图片到指定大小
 *  CGSize  :   缩放后的大小
 *  return  :   更改后的图片对象
 */
+(UIImage*)fan_scalImage:(UIImage *)sourceImage scalingForSize:(CGSize)targetSize;
/** 通过UIcolor获取一张图片 */
+ (UIImage *)fan_ImageWithColor:(UIColor *)color frame:(CGRect)rect;

/** 截屏*/
+(UIImage*)fan_beginImageContext:(CGRect)rect fromView:(UIView*)view;
/** OpenGL截图*/
+ (UIImage *)fan_openglSnapshotImage:(UIView *)openGLView;
/** 高斯模糊*/
+ (UIImage *)fan_gaussianBlurImage:(UIImage *)image;
/** 没有白边的高斯模糊 blur 1-100 */
+(UIImage *)fan_accelerateBlurWithImage:(UIImage *)image blurNumber:(CGFloat)blur;
/** 没有白边的高斯模糊（解决发红情况） blur 1-100 (最好1-25)*/
+(UIImage *)fan_accelerateBlurShortWithImage:(UIImage *)image blurNumber:(CGFloat)blur;
+(void)fan_addBlurEffectToView:(UIView *)toView;//添加毛玻璃
/** 拉伸图片，边缘不拉伸，图片的一半*/
+(UIImage *)fan_stretchableImage:(UIImage *)image;
/***************************************创建UI******************************************/
#pragma mark --创建Label
+(UILabel*)fan_createLabelWithFrame:(CGRect)frame text:(NSString*)text textColor:(UIColor *)textColor;
+(UILabel*)fan_createLabelWithFrame:(CGRect)frame Font:(int)font Text:(NSString*)text;
#pragma mark --创建imageView
+(UIImageView*)fan_createImageViewWithFrame:(CGRect)frame ImageName:(NSString*)imageName;
//主要图片
+(UIImageView*)fan_createImageViewWithBundleFrame:(CGRect)frame imageBundleName:(NSString*)imageName;

#pragma mark --创建button
+(UIButton*)fan_createButtonWithFrame:(CGRect)frame imageName:(NSString*)imageName target:(id)target action:(SEL)action;
+(UIButton*)fan_createButtonWithFrame:(CGRect)frame target:(id)target action:(SEL)action title:(NSString*)title titleColor:(UIColor *)titleColor;
+(UIButton*)fan_createButtonWithFrame:(CGRect)frame imageName:(NSString*)imageName target:(id)target action:(SEL)action title:(NSString*)title titleColor:(UIColor *)titleColor;
#pragma mark --创建UITextField
+(UITextField*)fan_createTextFieldWithFrame:(CGRect)frame placeholder:(NSString*)placeholder Font:(float)font backgoundColor:(UIColor*)bgColor;
+(UITextField*)fan_createTextFieldWithFrame:(CGRect)frame placeholder:(NSString*)placeholder leftImageView:(UIView*)imageView rightImageView:(UIView*)rightImageView Font:(float)font;

#pragma mark 创建UIScrollView
+(UIScrollView*)fan_createScrollViewWithFrame:(CGRect)frame contentSize:(CGSize)size;
#pragma mark 创建UIPageControl
+(UIPageControl*)fan_createPageControlWithFram:(CGRect)frame;
#pragma mark 创建UISlider
+(UISlider*)fan_createSliderWithFrame:(CGRect)rect thumbImage:(NSString*)imageName;
+(UISlider*)fan_createSliderWithFrame:(CGRect)rect thumbImage:(NSString*)imageName target:(id)target action:(SEL)action;
#pragma mark 创建UISwitch
+(UISwitch *)fan_createSwitchWithFrame:(CGRect)rect target:(id)target action:(SEL)action;

#pragma mark 创建UIViewController

+(id)fan_classFromName:(NSString *)aClassName;
/***************************************创建UI  End******************************************/

#pragma mark 返回设备类型

+(NSString *)fan_platformString;
@end
