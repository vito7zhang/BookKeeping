//
//  ImageTool.h
//  ZLYAccounts
//
//  Created by TalentBoy on 15/9/24.
//  Copyright (c) 2015年 TalentBoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageTool : UIView

//得到处理后的图片
+ (UIImage *)duleWithImageName:(NSString *)imageName size:(CGSize)size;
//得到size大小的颜色图片
+ (UIImage *)getImageWithColor:(UIColor *)color size:(CGSize)imageSize;

@end
