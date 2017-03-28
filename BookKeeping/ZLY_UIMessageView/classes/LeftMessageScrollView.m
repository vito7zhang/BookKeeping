//
//  LeftMessageScrollView.m
//  ZLYAccounts
//
//  Created by TalentBoy on 15/9/24.
//  Copyright (c) 2015年 TalentBoy. All rights reserved.
//

#import "LeftMessageScrollView.h"
#import "MessageView.h"
#import "MessageModel.h"

@interface LeftMessageScrollView ()

//每一部分的数值
@property (nonatomic,strong) NSArray *sectionMessage;
//每一部分的颜色
@property (nonatomic,strong) NSArray *sectionColor;

@end

@implementation LeftMessageScrollView

- (instancetype)initWithFrame:(CGRect)frame sectionMessage:(NSArray *)sectionMessage sectionColors:(NSArray *)sectionColors{
    if (self = [super initWithFrame:frame]) {
        _sectionMessage = sectionMessage;
        _sectionColor = sectionColors;
        int pageCount = 6;
        int page = (int)(ceilf((float)self.sectionMessage.count / pageCount));
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.bounces = NO;
        self.contentSize = CGSizeMake(0,page * frame.size.height);
        self.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.pagingEnabled = YES;
        
        for (int viewPage = 0; viewPage < page; viewPage++) {
            UIView *view = [[UIView alloc] init];
            view.frame = CGRectMake(0, 0 + viewPage * self.frame.size.height, self.frame.size.width, self.frame.size.height);
            [self addSubview:view];
            
            int cols = 1;
            CGFloat width = self.frame.size.width / cols;
            CGFloat height = self.frame.size.height / pageCount;
            NSInteger count = self.sectionMessage.count - viewPage * pageCount;
            count = count > pageCount ? pageCount : count;
            for (int start = viewPage * pageCount; start < viewPage * pageCount + count; start++) {
                MessageView *messageView = [[MessageView alloc] initWithType:self.sectionMessage[start] color:self.sectionColor[start]];
                messageView.frame = CGRectMake(0 , 0 + ((start - pageCount * viewPage) / cols) * height, width, height);
                [view addSubview:messageView];
            }
        }
        
        _page = page;
        
    }
    return self;
}
@end