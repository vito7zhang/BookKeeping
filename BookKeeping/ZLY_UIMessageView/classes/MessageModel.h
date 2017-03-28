//
//  MessageModel.h
//  ZLYAccounts
//
//  Created by TalentBoy on 15/9/25.
//  Copyright (c) 2015年 TalentBoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageModel : NSObject

//消费额数组
@property (nonatomic,weak) NSArray *consumeArray;
//颜色数组
@property (nonatomic,weak) NSArray *colorsArray;
//消费类型的数组
@property (nonatomic,strong) NSArray *typeArray;
//预期的money
@property (nonatomic,assign) CGFloat expendMoney;
//已经用的money
@property (nonatomic,assign) CGFloat currentBalanceMoney;

@end
