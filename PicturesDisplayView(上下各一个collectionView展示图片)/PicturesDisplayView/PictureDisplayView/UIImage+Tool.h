//
//  UIImage+Tool.h
//  UI-0730-Quartz2D-画板
//
//  Created by apple on 15/8/1.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Tool)
//根据指定路径,保存图片
- (BOOL)imageWriteToFile:(NSString *)path;


//裁剪图片(圆形或椭圆)
+ (instancetype)imageClippingWithImage:(UIImage *)image;
+ (instancetype)imageClippingWithImageName:(NSString *)name  border:(CGFloat)border  color:(UIColor *)color;
+ (instancetype)imageClippingWithImage:(UIImage *)image  border:(CGFloat)border  color:(UIColor *)color;



//裁剪图片(只是圆形图片)
+ (instancetype)imageCircleClippingWithImage:(UIImage *)image;
+ (instancetype)imageCircleClippingWithImageName:(NSString *)name  border:(CGFloat)border scale:(CGFloat)scale color:(UIColor *)color;
+ (instancetype)imageCircleClippingWithImage:(UIImage *)image  border:(CGFloat)border scale:(CGFloat)scale color:(UIColor *)color;
//指定大小生成的圆形图片(适合于imageView的cener模式.)
+ (instancetype)imageCircleClippingWithImage:(UIImage *)image border:(CGFloat)border scale:(CGFloat)scale color:(UIColor *)color  baseDistance:(CGFloat)baseDistance;
//根据老图片生成指定大小的新图片(definedSize最好和imageView的尺寸一致)
+ (instancetype)imageFromOldImage:(UIImage *)image  withDefinedSize:(CGSize)definedSize;

//裁剪图片(只是矩形带有圆角图片)
+ (UIImage *)imageRectClippingWithImage:(UIImage *)image;
+ (UIImage *)imageRectClippingWithImageName:(NSString *)name  border:(CGFloat)border  color:(UIColor *)color cornerRadius:(CGFloat)radius;
+ (UIImage *)imageRectClippingWithImage:(UIImage *)image  border:(CGFloat)border  color:(UIColor *)color cornerRadius:(CGFloat)radius;

//截图
+ (UIImage *)imageChaptureWithView:(UIView *)view;


//生成1x1大小的纯色image
+ (UIImage *)imageWithColor:(UIColor *)color;
//生成指定大小的纯色图片
+ (UIImage *)imageWithColor:(UIColor *)color  size:(CGRect)bounds;

@end
