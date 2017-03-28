//
//  ColorTool.m
//  DDemo
//
//  Created by TalentBoy on 15/9/28.
//  Copyright (c) 2015年 TalentBoy. All rights reserved.
//

#import "ColorTool.h"

@implementation ColorTool

+ (NSArray *)colorArrayWithCapicity:(NSUInteger)colorCount {
    id colors[] = {
        [UIColor colorWithRed:234 / 255.0 green:255 / 255.0 blue:128 / 255.0 alpha:1.0],
        [UIColor colorWithRed:170 / 255.0 green:255 / 255.0 blue:128 / 255.0 alpha:1.0],
        [UIColor colorWithRed:128 / 255.0 green:255 / 255.0 blue:149 / 255.0 alpha:1.0],
        [UIColor colorWithRed:128 / 255.0 green:234 / 255.0 blue:255 / 255.0 alpha:1.0],
        [UIColor colorWithRed:128 / 255.0 green:170 / 255.0 blue:255 / 255.0 alpha:1.0],
        [UIColor colorWithRed:149 / 255.0 green:128 / 255.0 blue:255 / 255.0 alpha:1.0],
        [UIColor colorWithRed:212 / 255.0 green:128 / 255.0 blue:255 / 255.0 alpha:1.0],
        [UIColor colorWithRed:255 / 255.0 green:128 / 255.0 blue:234 / 255.0 alpha:1.0],
        [UIColor colorWithRed:255 / 255.0 green:128 / 255.0 blue:170 / 255.0 alpha:1.0],
        [UIColor colorWithRed:255 / 255.0 green:149 / 255.0 blue:128 / 255.0 alpha:1.0],
        [UIColor colorWithRed:255 / 255.0 green:192 / 255.0 blue:66 / 255.0 alpha:1.0],
        [UIColor colorWithRed:255 / 255.0 green:172 / 255.0 blue:5 / 255.0 alpha:1.0],
        [UIColor colorWithRed:66 / 255.0 green:129 / 255.0 blue:255 / 255.0 alpha:1.0],
        [UIColor colorWithRed:5 / 255.0 green:88 / 255.0 blue:255 / 255.0 alpha:1.0],
        [UIColor colorWithRed:128 / 255.0 green:255 / 255.0 blue:212 / 255.0 alpha:1.0]
    };
    NSMutableArray *colorArray = [NSMutableArray arrayWithObjects:colors count:colorCount];
    return colorArray;
}

@end
