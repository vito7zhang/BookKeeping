//
//  TableViewCell.h
//  UIBook
//
//  Created by Ibokan2 on 15/9/24.
//  Copyright (c) 2015年 TaLinBoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LinTableViewCell : UITableViewCell
@property (nonatomic,strong) UIView *headerView;
@property (nonatomic,strong) UIImageView *headerImagheVeiw;
@property (nonatomic,strong) UILabel *typeLabel;
@property (nonatomic,strong) UILabel *dateLabel;
@property (nonatomic,strong) UILabel *nomeyLabel;
@property (nonatomic,strong) UIView *costView;
@end
