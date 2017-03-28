//
//  LinViewController.h
//  UIBook
//
//  Created by Ibokan2 on 15/9/24.
//  Copyright (c) 2015年 TaLinBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model.h"
#import "UIMessageView.h"
@interface LinViewController : UIViewController
@property (nonatomic,strong) Model *model;
@property (nonatomic,strong) UIMessageView *showView; // 用于显示比例图

@property (nonatomic,strong) UIView *buttonView; // 用于显示中部的button
@property (nonatomic,strong) UIView *contentView; // 用于显示下半部分的数据TableView

@end
