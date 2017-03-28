//
//  LeftMessageView.h
//  ZLYAccounts
//
//  Created by TalentBoy on 15/9/24.
//  Copyright (c) 2015年 TalentBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LeftMessageScrollView;
@class MessageModel;

@interface LeftMessageView : UIView

//接受模型数据
@property (nonatomic,strong) MessageModel *messageModel;


@end
