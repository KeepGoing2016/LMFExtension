//
//  UIImage+LMFExtension.m
//  绘图
//
//  Created by lumf on 16/5/5.
//  Copyright © 2016年 lumf. All rights reserved.
//

#import "UIImage+LMFExtension.h"

@implementation UIImage (LMFExtension)
//截屏
+(UIImage *)imageWithCapture:(UIView *)view{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [view.layer renderInContext:ctx];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

//获取圆形带边框截图
+(UIImage *)imageClipToCirleView:(UIImage *)image borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor{
    
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    
    //    CGContextRef ref = UIGraphicsGetCurrentContext();
    
    CGFloat max = MAX(image.size.width, image.size.height);
    CGFloat min = MIN(image.size.width, image.size.height);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake((max-min)/2.0, 0, min, min)];
    [borderColor set];
    [path fill];
    
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake((max-min)/2.0+borderWidth, borderWidth, min-2*borderWidth, min-2*borderWidth)];
    [clipPath addClip];
    [image drawAtPoint:CGPointZero];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


//添加水印
+(UIImage *)imageWithWatermark:(UIImage *)originalImage watermark:(NSString *)waterString{
    UIGraphicsBeginImageContextWithOptions(originalImage.size, NO, 0);
    
    [originalImage drawAtPoint:CGPointZero];
    
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    dictM[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    dictM[NSForegroundColorAttributeName] = [UIColor grayColor];
    CGSize waterSize = [waterString sizeWithAttributes:dictM];
    [waterString drawAtPoint:CGPointMake(originalImage.size.width-waterSize.width-10, originalImage.size.height-waterSize.height-5) withAttributes:dictM];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
