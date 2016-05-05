//
//  ViewController.m
//  绘图
//
//  Created by lumf on 16/5/4.
//  Copyright © 2016年 lumf. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+LMFExtension.h"

@interface ViewController ()
@property (nonatomic, weak) UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.bounds = CGRectMake(0, 0, 300, 300);
    imageView.center = self.view.center;
    [self.view addSubview:imageView];
    
    //加水印
//    imageView.image = [UIImage imageWithWatermark:[UIImage imageNamed:@"123.jpg"] watermark:@"迷途知返"];
    
    //加圆形边框
    imageView.image = [UIImage imageClipToCirleView:[UIImage imageNamed:@"123.jpg"] borderWidth:2.0 borderColor:[UIColor redColor]];
    
    self.imageView = imageView;
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.backgroundColor = [UIColor yellowColor];

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //获取截图
    UIImage *image = [UIImage imageWithCapture:self.view];
    self.imageView.image = image;
}

//截屏
-(void)getCapture{
    self.view.backgroundColor = [UIColor greenColor];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
    imageView.center = self.view.center;
    imageView.image = [UIImage imageNamed:@"123.jpg"];
    [self.view addSubview:imageView];
    
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, 0);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [self.view.layer renderInContext:ctx];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *imageData = UIImagePNGRepresentation(image);
    [imageData writeToFile:@"/Users/lumf/Desktop/view" atomically:YES];
}

//画圆形图标
-(void)drawCircleImage{
    UIImage *image = [UIImage imageNamed:@"123.jpg"];
    
    CGFloat border = 2;
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    
    CGContextRef ref = UIGraphicsGetCurrentContext();
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake((image.size.width-image.size.height)/2.0, 0, image.size.height, image.size.height)];
    [[UIColor redColor] set];
    [path fill];
    
    UIBezierPath *path2 = [UIBezierPath bezierPathWithOvalInRect:CGRectMake((image.size.width-image.size.height)/2.0+border, border, image.size.height-2*border, image.size.height-2*border)];
    [path2 addClip];
    [image drawAtPoint:CGPointZero];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:newImage];
    imageView.center = self.view.center;
    [self.view addSubview:imageView];
}




//加水印
-(void)drawImage{
    UIImage *image = [UIImage imageNamed:@"123.jpg"];
    
    
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    
    [image drawAtPoint:CGPointZero];
    
    NSString *str = @"Running";
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    dictM[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    dictM[NSForegroundColorAttributeName] = [UIColor redColor];
    [str drawAtPoint:CGPointMake(image.size.width-100, image.size.height-30) withAttributes:dictM];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.backgroundColor = [UIColor yellowColor];
    imageView.image = newImage;
    imageView.bounds = CGRectMake(0, 0, 200, 100);
    imageView.center = self.view.center;
    [self.view addSubview:imageView];
}

@end
