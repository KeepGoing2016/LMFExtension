//
//  UIImage+LMFExtension.h
//  绘图
//
//  Created by lumf on 16/5/5.
//  Copyright © 2016年 lumf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (LMFExtension)


/**
 *  //截屏
 *
 *  @param view 需要截取的view
 *
 *  @return 返回截取的图片
 */
+(UIImage *)imageWithCapture:(UIView *)view;

//获取圆形带边框截图
+(UIImage *)imageClipToCirleView:(UIImage *)image borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

//添加水印
+(UIImage *)imageWithWatermark:(UIImage *)originalImage watermark:(NSString *)waterString;

@end
