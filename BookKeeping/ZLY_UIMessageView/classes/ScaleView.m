//
//  ScaleView.m
//  ZLYAccounts
//
//  Created by TalentBoy on 15/9/22.
//  Copyright (c) 2015年 TalentBoy. All rights reserved.
//

#import "ScaleView.h"
#import "MessageModel.h"

@implementation ScaleView

- (void)drawRect:(CGRect)rect {
    
    if (!self.messageModel) {
        return;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //中心点
    CGFloat centerX = self.bounds.size.width / 2;
    CGFloat centerY = self.bounds.size.height / 2;
    
    //外圆半径
    CGFloat outredius = centerX;
    
    //内圆半径
    CGFloat inRadius = outredius / 2;
    
    //数组画图属性
    CGFloat sum = 0;
    for (int i = 0; i < self.messageModel.consumeArray.count; i++) {
        sum += [self.messageModel.consumeArray[i] floatValue];
    }
    
    //外圆
    CGFloat startAngle = -M_PI_2;
    for (int i = 0; i < self.messageModel.consumeArray.count; i++) {
        CGFloat scale = [self.messageModel.consumeArray[i] floatValue] / sum;
        UIColor *sectionColor = self.messageModel.colorsArray[i];
        [sectionColor setFill];
        CGFloat endAngle = startAngle + scale * M_PI * 2;
        CGContextMoveToPoint(context, centerX, centerY);
        CGContextAddArc(context, centerX, centerY, outredius, startAngle, endAngle, 0);
        CGContextFillPath(context);
        startAngle = endAngle;
    }
    //内圆
    [[UIColor whiteColor] setFill];
    CGContextMoveToPoint(context, centerX, centerY);
    CGContextAddArc(context, centerX, centerY, inRadius, 0, M_PI * 2, 0);
    CGContextFillPath(context);
    
}

- (void)setMessageModel:(MessageModel *)messageModel {
    _messageModel = messageModel;
    [self setNeedsDisplay];
}




@end
