//
//  UIMessageView.m
//  ZLYAccounts
//
//  Created by TalentBoy on 15/9/24.
//  Copyright (c) 2015年 TalentBoy. All rights reserved.
//

#import "UIMessageView.h"
#import "LeftMessageView.h"
#import "ScaleView.h"


@interface UIMessageView () {
    UIView *_topView;  //头部信息页面
    UIView *_centerView; //中间信息页面
}

@property (nonatomic,weak) UILabel *expendMoneyLabel;
@property (nonatomic,weak) UILabel *currentBalanceMoneyLabel;
@property (nonatomic,weak) ScaleView *scaleView;
@property (nonatomic,weak) LeftMessageView *leftMessageView;

@end

@implementation UIMessageView

//MARK:重写初始化方法
//使用frame布局
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self viewDidAddSubviews];
        [self topViewDidAddSubview];
        [self centerViewDidAddSubviewWithMessage];
    }
    return self;
}

//使用autoLayout布局
- (instancetype)init {
    if (self = [super init]) {
        [self viewDidAddSubviews];
        [self topViewDidAddSubview];
        [self centerViewDidAddSubviewWithMessage];
    }
    return self;
}

//MARK:添加子控件
//UIMessageView添加子控件
- (void)viewDidAddSubviews {
    _topView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, self.bounds.size.width - 20, self.bounds.size.height * 0.2)];
    [self addSubview:_topView];
    _centerView = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_topView.frame), self.bounds.size.width - 20, self.bounds.size.height - CGRectGetMaxY(_topView.frame))];
    [self addSubview:_centerView];
    
    [self topViewDidAddSubview];
}
//_topView添加子控件
- (void)topViewDidAddSubview {
    NSArray *typeMessages = @[@"",@"实际支出"];
    CGFloat labelW = _topView.bounds.size.width / 2;
    CGFloat labelH = _topView.bounds.size.height / 2;
    for (int i = 0; i < 4; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0 + (i % 2) * labelW, (i / 2) * labelH, labelW, labelH)];
//        label.adjustsFontSizeToFitWidth = YES;
        label.font = [UIFont systemFontOfSize:14];
        if (i % 2 == 1) {
            label.textAlignment = NSTextAlignmentRight;
        }
        if (i / 2 == 0) {
            label.text = typeMessages[i];
        }
        if (i == 2) {
            _expendMoneyLabel = label;
//            label.text = 0;
            label.textColor = [UIColor greenColor];
        }
        if (i == 3) {
            _currentBalanceMoneyLabel = label;
            label.text = 0;
            label.textColor = [UIColor greenColor];
        }
        [_topView addSubview:label];
    }
}

//_centerView添加子控件
- (void)centerViewDidAddSubviewWithMessage {
    LeftMessageView *leftMessageView= [[LeftMessageView alloc] initWithFrame:CGRectMake(0, 0, _centerView.bounds.size.width * 0.4, _centerView.bounds.size.height)];
    [_centerView addSubview:leftMessageView];
   
    CGFloat scaleMin = MIN(_centerView.bounds.size.width * 0.6, _centerView.bounds.size.height);
    if (scaleMin ==  _centerView.bounds.size.height) {
        scaleMin = _centerView.bounds.size.width * 0.42;
    }
    ScaleView *scaleView = [[ScaleView alloc] initWithFrame:CGRectMake(0, 0,scaleMin, scaleMin)];
    scaleView.center = CGPointMake(CGRectGetMaxX(leftMessageView.frame) + scaleMin / 2, _centerView.bounds.size.height / 2);
    scaleView.backgroundColor = [UIColor whiteColor];
    [_centerView addSubview:scaleView];
    
    self.leftMessageView = leftMessageView;
    self.scaleView = scaleView;
}

//MARK:重写setMessageModel方法
- (void)setMessageModel:(MessageModel *)messageModel {
    _messageModel = messageModel;
//    NSString *expendString = [self duleNumberWithMoney:[NSString stringWithFormat:@"%.2f",messageModel.expendMoney]];
//    self.expendMoneyLabel.text = [NSString stringWithFormat:@"$ %@",expendString];
    NSString *currentString = [self duleNumberWithMoney:[NSString stringWithFormat:@"%.2f",messageModel.currentBalanceMoney]];
    self.currentBalanceMoneyLabel.text = [NSString stringWithFormat:@"$ %@",currentString];
    self.leftMessageView.messageModel = messageModel;
    self.scaleView.messageModel = messageModel;
    if (_messageModel.expendMoney < messageModel.currentBalanceMoney) {
        self.currentBalanceMoneyLabel.textColor = [UIColor redColor];
    }else {
        self.currentBalanceMoneyLabel.textColor = [UIColor greenColor];
    }
}

//MARK:数字的处理
- (NSString *)duleNumberWithMoney:(NSString *)money {
    NSNumberFormatter *numerFormatter = [[NSNumberFormatter alloc] init];
    numerFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    money = [numerFormatter stringFromNumber:[numerFormatter numberFromString:money]];
    return money;
}

@end
