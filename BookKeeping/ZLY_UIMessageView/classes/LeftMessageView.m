//
//  LeftMessageView.m
//  ZLYAccounts
//
//  Created by TalentBoy on 15/9/24.
//  Copyright (c) 2015年 TalentBoy. All rights reserved.
//

#import "LeftMessageView.h"
#import "LeftMessageScrollView.h"
#import "ImageTool.h"
#import "MessageModel.h"

@interface LeftMessageView ()<UIScrollViewDelegate>

//控件
@property (nonatomic,weak) LeftMessageScrollView *leftScrollView;
@property (nonatomic,weak) UIButton *topPageButton;
@property (nonatomic,weak) UIButton *buttomPageButton;

//属性
@property (nonatomic,assign) NSInteger page;
@property (nonatomic,assign) NSInteger currentPage;

@property (nonatomic,assign) CGFloat lastOffsetY;

@end

@implementation LeftMessageView

//MARK:添加子控件
- (void)viewDidAddSubviewsAndInitWithData {
    
    CGFloat buttonH = 20;
    UIButton *topPageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    topPageButton.frame = CGRectMake(0, 0, self.bounds.size.width, buttonH);
    [self addSubview:topPageButton];
    [topPageButton addTarget:self action:@selector(lastPage:) forControlEvents:UIControlEventTouchUpInside];
    
    LeftMessageScrollView *leftScrollView = [[LeftMessageScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(topPageButton.frame), self.bounds.size.width, self.bounds.size.height - buttonH * 2) sectionMessage:self.messageModel.typeArray sectionColors:self.messageModel.colorsArray];
    [self addSubview:leftScrollView];
    
    UIButton *buttomPageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    buttomPageButton.frame = CGRectMake(0, CGRectGetMaxY(leftScrollView.frame), self.bounds.size.width, buttonH);
    [self addSubview:buttomPageButton];
    [buttomPageButton addTarget:self action:@selector(nextPage:) forControlEvents:UIControlEventTouchUpInside];
    
    //初始化属性
    _leftScrollView = leftScrollView;
    _topPageButton = topPageButton;
    _buttomPageButton = buttomPageButton;
    _page = leftScrollView.page;
    _currentPage = 0;
    _leftScrollView.delegate = self;
    _lastOffsetY = 0;
    [self initButtonStyle];
    [self initWithButton];
    
}

//MARK:重写setMessageModel
- (void)setMessageModel:(MessageModel *)messageModel {
    while (self.subviews.firstObject) {
        [self.subviews.firstObject removeFromSuperview];
    }
    _messageModel = messageModel;
    [self viewDidAddSubviewsAndInitWithData];
}

//MARK:按钮的点击事件
//点击加载上一页的内容
- (void)lastPage:(UIButton *)sender {
    [self isNextPage:NO];
}

//点击加载下一页的内容
- (void)nextPage:(UIButton *)sender {
    [self isNextPage:YES];
}

//是否是下一页
- (void)isNextPage:(BOOL)flag {
    if (flag) {
        self.currentPage ++;
    }else {
        self.currentPage --;
    }
    if (self.currentPage > self.page - 1 || self.currentPage < 0) {
        return;
    }
    CGPoint offsetPoint = CGPointMake(0 , self.currentPage * self.leftScrollView.frame.size.height);
    [self.leftScrollView setContentOffset:offsetPoint animated:YES];
    [self initWithButton];
}

//MARK:按钮控件的样式
//初始化按钮
- (void)initWithButton {
    if (self.currentPage == 0) {
        self.topPageButton.enabled = NO;
    }else {
        self.topPageButton.enabled = YES;
    }
    
    if (self.currentPage == self.page - 1) {
        self.buttomPageButton.enabled = NO;
    }else {
        self.buttomPageButton.enabled = YES;
    }
}

//设置按钮的点击样式
- (void)initButtonStyle {
    CGSize size = CGSizeMake(20, 20);
    [self.topPageButton setImage:[ImageTool duleWithImageName:@"top_normal" size:size] forState:UIControlStateNormal];
    [self.topPageButton setImage:[ImageTool duleWithImageName:@"top_highlighted" size:size] forState:UIControlStateHighlighted];
    [self.topPageButton setImage:[ImageTool duleWithImageName:@"top_disable" size:size] forState:UIControlStateDisabled];
    [self.buttomPageButton setImage:[ImageTool duleWithImageName:@"bottom_normal" size:size] forState:UIControlStateNormal];
    [self.buttomPageButton setImage:[ImageTool duleWithImageName:@"bottom_highlighted" size:size] forState:UIControlStateHighlighted];
    [self.buttomPageButton setImage:[ImageTool duleWithImageName:@"bottom_disable" size:size] forState:UIControlStateDisabled];
}

#pragma mark --UIScrollViewDelegate--
//触摸滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.currentPage = (int)((scrollView.contentOffset.y) / scrollView.bounds.size.height);
        _lastOffsetY = scrollView.contentOffset.y;
    if (_lastOffsetY >= (self.page - 1.5) * scrollView.bounds.size.height) {
        self.currentPage = self.page - 1;
    }
    [self initWithButton];
}

@end
