//
//  ImageTool.m
//  ZLYAccounts
//
//  Created by TalentBoy on 15/9/24.
//  Copyright (c) 2015年 TalentBoy. All rights reserved.
//

#import "ImageTool.h"

@implementation ImageTool

+ (UIImage *)duleWithImageName:(NSString *)imageName size:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    UIImage *image = [UIImage imageNamed:imageName];
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    [image drawInRect:rect];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

+ (UIImage *)getImageWithColor:(UIColor *)color size:(CGSize)imageSize  {
    CGSize size = imageSize;
    UIGraphicsBeginImageContext(size);
    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
    [color setFill];
    CGPoint centerPoint = CGPointMake(size.width / 2, size.height / 2);
    [bezierPath addArcWithCenter:centerPoint radius:size.width / 2  startAngle:0 endAngle:M_PI * 2 clockwise:NO];
    [bezierPath fill];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
