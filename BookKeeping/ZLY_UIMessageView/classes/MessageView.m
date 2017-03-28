//
//  MessageView.m
//  ZLYAccounts
//
//  Created by TalentBoy on 15/9/22.
//  Copyright (c) 2015年 TalentBoy. All rights reserved.
//

#import "MessageView.h"
#import "ImageTool.h"

@interface MessageView ()

@property (nonatomic,weak) UIImageView *imageView;
@property (nonatomic,weak) UILabel *messageLabel;

@end

@implementation MessageView

- (instancetype)initWithType:(NSString *)type color:(UIColor *)color {
    if (self = [super init]) {
        [self viewDidAddSubviews];
        [self initSubviewsWithType:type color:color];
    }
    return self;
}

//添加子控件
- (void)viewDidAddSubviews {
    
    //imageView
    UIImageView *imageView = [[UIImageView alloc] init];
    [self addSubview:imageView];
    
    //messageLabel
    UILabel *messageLabel = [[UILabel alloc] init];
    [self addSubview:messageLabel];
    
    self.imageView = imageView;
    self.messageLabel = messageLabel;
}

//设置内容
- (void)initSubviewsWithType:(NSString *)type color:(UIColor *)color {
    CGSize size = CGSizeMake(40, 40);
    self.imageView.image = [ImageTool getImageWithColor:color size:size];
    self.messageLabel.text = type;
}


//frame布局
- (void)layoutSubviews {
    self.imageView.bounds = CGRectMake(0, 0, self.bounds.size.height * 0.3, self.bounds.size.height * 0.3);
    self.imageView.center = CGPointMake(self.bounds.size.height * 0.5, self.bounds.size.height * 0.5);
    self.messageLabel.frame = CGRectMake(CGRectGetMaxX(self.imageView.frame) + 10, 0, self.bounds.size.width - CGRectGetMaxX(self.imageView.frame) - 10, self.bounds.size.height);
}





@end
