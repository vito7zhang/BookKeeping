//
//  TableViewCell.m
//  UIBook
//
//  Created by Ibokan2 on 15/9/24.
//  Copyright (c) 2015年 TaLinBoy. All rights reserved.
//

#import "LinTableViewCell.h"

@implementation LinTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,self.bounds.size.width, 44)];
        _headerImagheVeiw  = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 24, 24)];
        [_headerView addSubview:_headerImagheVeiw];
        _headerImagheVeiw.layer.cornerRadius = 12;
        _headerImagheVeiw.layer.masksToBounds = YES;
        
        _typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(44, 0, 120, 24)];
        [_headerView addSubview:_typeLabel];
        _typeLabel.font = [UIFont systemFontOfSize:17];
        _nomeyLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 210, 0, 200, 44)];
        _nomeyLabel.textAlignment = NSTextAlignmentRight;
        _nomeyLabel.font = [UIFont systemFontOfSize:17];
        [_headerView addSubview:_nomeyLabel];
        
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(44, 24, 120, 20)];
        _dateLabel.font = [UIFont systemFontOfSize:15];
        [_headerView addSubview:_dateLabel];
        
        [self addSubview:_headerView];
        
        _costView = [UIView new];
        [self addSubview:_costView];
    }
    return self;
}

@end
