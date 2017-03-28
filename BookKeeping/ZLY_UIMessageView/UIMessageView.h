//
//  UIMessageView.h
//  ZLYAccounts
//
//  Created by TalentBoy on 15/9/24.
//  Copyright (c) 2015年 TalentBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorTool.h"
#import "MessageModel.h"

@interface UIMessageView : UIView

//接受模型
@property (nonatomic,strong) MessageModel *messageModel;

@end

/*
 *用法：
 1.#import "UIMessageView"   //导入头文件
 2.UIMessageView *messageView = [UIMessageView alloc] initWithFrame:....];  //使用initWithFrame方法生成实例，也可使用init生成实例，再使用autoLayout布局
 3.messageView.messageModel = ....  //设置messageModel
 4.[self.view addSubviews:messageView]   //添加到父控件中
 */