//
//  LeftMessageScrollView.h
//  ZLYAccounts
//
//  Created by TalentBoy on 15/9/24.
//  Copyright (c) 2015年 TalentBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MessageModel;

@interface LeftMessageScrollView : UIScrollView


@property (nonatomic,strong) MessageModel *messageModel;

//信息页数
@property (nonatomic,assign) NSInteger page;

//生成垂直状态的信息列表图
- (instancetype)initWithFrame:(CGRect)frame sectionMessage:(NSArray *)sectionMessage sectionColors:(NSArray *)sectionColors;

@end
