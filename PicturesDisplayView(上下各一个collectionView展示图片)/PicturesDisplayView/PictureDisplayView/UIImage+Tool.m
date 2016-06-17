//
//  UIImage+Tool.m
//  UI-0730-Quartz2D-画板
//
//  Created by apple on 15/8/1.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "UIImage+Tool.h"

@implementation UIImage (Tool)

#pragma mark 将图片保存到指定路径下.并创建指定名称图片
- (BOOL)imageWriteToFile:(NSString *)path
{
    NSData *data=UIImagePNGRepresentation(self);
    return  [data  writeToFile:path atomically:YES];
    
}



#pragma mark 裁剪图片,裁剪后图片是椭圆或圆形.

+(instancetype)imageClippingWithImage:(UIImage *)image{
    return [UIImage  imageClippingWithImage:image border:0 color:nil];
}
+ (instancetype)imageClippingWithImageName:(NSString *)name border:(CGFloat)border color:(UIColor *)color
{
    return [UIImage  imageClippingWithImage:[UIImage  imageNamed:name] border:border color:color];
}
+(instancetype)imageClippingWithImage:(UIImage *)image border:(CGFloat)border color:(UIColor *)color{
    //1.定义圆形边框.
    CGFloat bordeW=border;
    //2.加载图片.
    CGFloat imageH=image.size.height+2*bordeW;
    CGFloat imageW=image.size.width+2*bordeW;
    
    //3.开启上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageW, imageH), NO, 0);
    
    //4.画大椭圆(着色背景)
    UIBezierPath *path=[UIBezierPath  bezierPathWithOvalInRect:CGRectMake(0, 0,imageW, imageH)];
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    CGContextAddPath(ctx, path.CGPath);
    if (!color) {//颜色为空时,白色为默认颜色.
        [[UIColor  whiteColor]  set];
    }else{
        [color   set];
    }
    CGContextFillPath(ctx);
    //5.画小椭圆(剪裁图片)
    CGRect imageShowSize=CGRectMake(bordeW, bordeW, image.size.width, image.size.height);
    UIBezierPath *clipPath=[UIBezierPath  bezierPathWithOvalInRect:imageShowSize];
    [clipPath   addClip];
    //6.绘制图片
    [image  drawAtPoint:CGPointMake(bordeW, bordeW)];
    //7.获取新图片
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    
    //8关闭上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}






#pragma mark 裁剪图片,裁剪后图片只是圆形.
+(instancetype)imageCircleClippingWithImage:(UIImage *)image{
    return [UIImage   imageCircleClippingWithImage:image border:0 scale:1 color:nil];
}
+ (instancetype)imageCircleClippingWithImageName:(NSString *)name  border:(CGFloat)border scale:(CGFloat)scale color:(UIColor *)color
{
    return [UIImage   imageCircleClippingWithImage:[UIImage  imageNamed:name] border:border scale:scale color:color];
}
+(instancetype)imageCircleClippingWithImage:(UIImage *)image border:(CGFloat)border scale:(CGFloat)scale color:(UIColor *)color{
    //1.定义圆形边框.
    CGFloat bordeW=border;
    
    //2.加载图片.
    CGFloat imageH=image.size.height+2*bordeW;
    CGFloat imageW=image.size.width+2*bordeW;
    //3.确定背景圆的直径
    CGFloat R=MIN(imageH, imageW)/2;
    CGFloat r=R-bordeW;
    
    //4.开启上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageW, imageH), NO, 0);
    
    CGFloat f=0;
    if (scale>=0&&scale<=1) {
        f=scale;
    }else
    {
        f=1;
    }
    //5.画大圆(着色背景)
    CGPoint cernter1=CGPointMake(imageW/2, imageH/2);
    UIBezierPath *path=[UIBezierPath  bezierPathWithArcCenter:cernter1 radius:R*f startAngle:0 endAngle:M_PI*2 clockwise:YES];
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    CGContextAddPath(ctx, path.CGPath);
    if (!color) {//颜色为空时,白色为默认颜色.
        [[UIColor  whiteColor]  set];
    }else{
        [color   set];
    }
    CGContextFillPath(ctx);
    //6.画小圆(裁剪图片)
    UIBezierPath *clipPath=[UIBezierPath  bezierPathWithArcCenter:cernter1 radius:r*f startAngle:0 endAngle:M_PI*2 clockwise:YES];
    [clipPath   addClip];
    //7.绘制图片
    [image  drawAtPoint:CGPointMake(bordeW, bordeW)];
    //8.获取新图片
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    
    //9关闭上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}
//指定大小生成的圆形图片
+ (instancetype)imageCircleClippingWithImage:(UIImage *)image border:(CGFloat)border scale:(CGFloat)scale color:(UIColor *)color  baseDistance:(CGFloat)baseDistance{
    //1.定义圆形边框.
    CGFloat bordeW=border;
    
    //2.加载图片.
    CGFloat imageH=image.size.height;
    CGFloat imageW=image.size.width;
    CGFloat contextW=0;
    CGFloat contextH=0;
    //判断高,宽进行等比例缩放
    if (imageH>=imageW) {
        contextW=baseDistance;
        contextH=contextW/imageW*imageH;
        
    }else{
        contextH=baseDistance;
        contextW=contextH/imageH*imageW;
    }
    contextH+=2*bordeW;
    contextW+=2*bordeW;
    //3.确定背景圆的直径
    CGFloat R=MIN(contextW, contextH)/2;
    CGFloat r=R-bordeW;
    
    //4.开启上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(contextW, contextH), NO, 0);
    
    CGFloat f=0;
    if (scale>=0&&scale<=1) {
        f=scale;
    }else
    {
        f=1;
    }
    //5.画大圆(着色背景)
    CGPoint cernter1=CGPointMake(contextW/2, contextH/2);
    UIBezierPath *path=[UIBezierPath  bezierPathWithArcCenter:cernter1 radius:R*f startAngle:0 endAngle:M_PI*2 clockwise:YES];
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    CGContextAddPath(ctx, path.CGPath);
    if (!color) {//颜色为空时,白色为默认颜色.
        [[UIColor  whiteColor]  set];
    }else{
        [color   set];
    }
    CGContextFillPath(ctx);
    //6.画小圆(裁剪图片)
    UIBezierPath *clipPath=[UIBezierPath  bezierPathWithArcCenter:cernter1 radius:r*f startAngle:0 endAngle:M_PI*2 clockwise:YES];
    [clipPath   addClip];
    //7.绘制图片
    //[image  drawAtPoint:CGPointMake(bordeW, bordeW)];
    [image   drawInRect:CGRectMake(bordeW, bordeW, contextW, contextH)];
    //8.获取新图片
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    
    //9关闭上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}
//根据老图片生成指定大小的新图片(definedSize最好和imageView的尺寸一致)
+ (instancetype)imageFromOldImage:(UIImage *)image withDefinedSize:(CGSize)definedSize{

    //2.加载图片.
    CGFloat imageH = image.size.height;
    CGFloat imageW = image.size.width;
    CGFloat definedW = definedSize.width;
    CGFloat definedH = definedSize.height;
    
    CGFloat H = definedW/imageW*imageH;//判断条件
    CGFloat newH;
    CGFloat newW;
    CGRect contentRect;
    //判断高,宽进行等比例缩放
    if (definedH <= H) {
        
        newH = definedH;
        newW = newH/imageH*imageW;
        CGFloat x = (definedW - newW)*.5;
        contentRect = CGRectMake(x, 0, newW, newH);
        
    }else{
        
        newW = definedW;
        newH = H;
        CGFloat y = (definedH - newH)*.5;
        contentRect = CGRectMake(0, y, newW, newH);
    }

    //4.开启上下文
    UIGraphicsBeginImageContextWithOptions(definedSize, NO, 0);
    
    [image   drawInRect:contentRect];
    //8.获取新图片
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    
    //9关闭上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

#pragma mark 裁剪图片,裁剪后图片只是矩形带有圆角.
+(UIImage *)imageRectClippingWithImage:(UIImage *)image{
    return [UIImage  imageRectClippingWithImage:image border:0 color:nil cornerRadius:0];
}
+ (UIImage *)imageRectClippingWithImageName:(NSString *)name border:(CGFloat)border color:(UIColor *)color cornerRadius:(CGFloat)radius{
    return [UIImage   imageRectClippingWithImage:[UIImage  imageNamed:name] border:border color:color cornerRadius:radius];
}
+ (UIImage *)imageRectClippingWithImage:(UIImage *)image  border:(CGFloat)border  color:(UIColor *)color cornerRadius:(CGFloat)radius
{
    //1.定义圆形边框.
    CGFloat bordeW=border;
    //2.加载图片.
    CGFloat imageH=image.size.height+2*bordeW;
    CGFloat imageW=image.size.width+2*bordeW;
    
    //3.开启上下文
    //UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageW, imageH), NO, 0);
    UIGraphicsBeginImageContext(CGSizeMake(imageW, imageH));
    //4.画大圆(着色背景)
    CGRect  bigRect=CGRectMake(0, 0, imageW, imageH);
    UIBezierPath *path=[UIBezierPath  bezierPathWithRoundedRect:bigRect cornerRadius:radius];
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    CGContextAddPath(ctx, path.CGPath);
    if (!color) {//颜色为空时,白色为默认颜色.
        [[UIColor  whiteColor]  set];
    }else{
        [color   set];
    }
    CGContextFillPath(ctx);
    //5.画小圆(裁剪图片)
    CGRect smallRect=CGRectMake(border, border, image.size.width, image.size.height);
    UIBezierPath *clipPath=[UIBezierPath  bezierPathWithRoundedRect:smallRect cornerRadius:radius];
    [clipPath   addClip];
    //6.绘制图片
    [image  drawAtPoint:CGPointMake(bordeW, bordeW)];
    //7.获取新图片
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    
    //8关闭上下文
    UIGraphicsEndImageContext();
    
    return newImage;
    
}



#pragma mark  截取view中内容,返回一个image图片.
+ (UIImage *)imageChaptureWithView:(UIView *)view
{
    //1.开启上下文
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0.0);
    //2.获取先下文
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    //3.渲染view的图层到上下文,图层只能用渲染不能用draw.
    [view.layer   renderInContext:ctx];
    //4.获取图片
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    //5.关闭上下文
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma  mark  生成纯色的UIImage
+ (UIImage *)imageWithColor:(UIColor *)color
{
    // 描述矩形
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    // 渲染上下文
    CGContextFillRect(context, rect);
    // 从上下文中获取图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    
    return theImage;
}

+ (UIImage *)imageWithColor:(UIColor *)color   size:(CGRect)bounds
{
    // 描述矩形
    CGRect rect = bounds;
    
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    // 渲染上下文
    CGContextFillRect(context, rect);
    // 从上下文中获取图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    
    return theImage;
}




@end
