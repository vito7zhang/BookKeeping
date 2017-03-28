//
//  ViewController.m
//  BookKeeping
//
//  Created by ibokan on 15/9/19.
//  Copyright (c) 2015年 rick. All rights reserved.
//

#import "ViewController.h"
#import "WriteViewController.h"
#import "Model.h"
#import "SQLOperation.h"

#import "DemoViewController.h"
#import "SupportViewController.h"
#import "AboutViewController.h"
#import "NewViewController.h"
#define LAOSHUAIGE @"laoshuaige"
#define PASSWORD @"password"
#define HAHA @"haha"
#define MOENY  @"money"

@interface ViewController ()<UIScrollViewDelegate,UIAlertViewDelegate>
{
    UIView *calculateView;               //numberLabel
    UIScrollView *chooseScrollView ;    //chooseScrollView
    UIPageControl *pageControl;         //pageControl
    UIView *editView;                   //编辑View
    UIView *numberView ;                //数字View
    BOOL numberViewIsDown ;             //判断numberView 是否下去了
    UITextView *textView ;              //写入内容的TextView
    UIImageView *writeImageView ;       //writeImageView
    UITextView *writeTextView;          //UITextView *writeTextView
    UIButton *writeConformButton ;      //UIButton *writeConformButton
    UITextField *writeTextField;        //UITextField *writeTextField
    UILabel *moneyLabel;
    WriteViewController *writeViewController ; //编辑页面
    NSMutableArray *preChooseButtonArray ;
    NSInteger chooseScrollViewButtonTag ;
    NSMutableArray *showMoneyArray ;
    NSMutableArray *remarkArray ;
    NSDictionary *dictionary ;
    NSMutableArray *moneyTypeArray ;     //设置中money的类型
    NSMutableArray *budgetArray ;        //设置中预算的数
    NSDictionary *ddic ;
    NSMutableArray *pictureIsSelectedArray ;
  
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"速记";
    self.view.backgroundColor = [UIColor whiteColor];
    
    preChooseButtonArray = [NSMutableArray array];
    showMoneyArray = [NSMutableArray array];
    remarkArray = [NSMutableArray array];
    dictionary = [NSDictionary dictionary];
    moneyTypeArray = [NSMutableArray array];
    budgetArray = [NSMutableArray array];
    chooseScrollViewButtonTag = 600 ;
    pictureIsSelectedArray = [NSMutableArray array];
    
    //使用字体   @"American Typewriter"
    //视图初始化以及布局
    [self rightBarButtonLayout];
    [self calculateViewLayout];
    [self chooseScrollViewLayout];
    [self chooseButtonLayout];
    [self PageControlLayout];
    [self editViewLayout];
    [self editButtonLayout];
    [self numberViewLayout];
    [self numberButtonLayout];
    [self leftBarButtonLayout];
    
    /*
    int index = 1;
    NSArray *typeArray = @[@"alcohol",@"book",@"cellphone",@"clothes",@"food",@"game",@"house",@"income",@"insurance",@"movie",@"other",@"supermarket",@"transit",@"travel",@"water"];
    NSArray *imageArray = @[@"alcohol128",@"book128",@"cellphone128",@"clothes128",@"food128",@"game128",@"house128",@"income128",@"insurance128",@"movie128",@"other128",@"supermarket128",@"transit128",@"travel128",@"water128"];
    for (int i = 0; i < 20; i++) {
        for (int j = 0; j < 200; j++) {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
            NSDate *date = [NSDate dateWithTimeIntervalSinceNow:-index*1440*60];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH-mm-ss"];
            NSString *string = [dateFormatter stringFromDate:date];
            Model *m = [Model new];
            m.date = string;
            m.type = typeArray[index%15];
            m.money = [NSString stringWithFormat:@"%d",index];
            m.moneyType = @"RMB";
            m.typeImageName = imageArray[index%15];
            m.remark = [NSString stringWithFormat:@"%@and%@",m.type,m.typeImageName];
            [SQLOperation insertWithModel:m];
            index++;
        }
    }
   */
    
    
}

#pragma mark -----------视图初始化以及布局----------------------
//calculateView
-(void)calculateViewLayout
{
    calculateView = [[UIView alloc]init];
    calculateView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:calculateView];
    
    calculateView.translatesAutoresizingMaskIntoConstraints = NO ;
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:calculateView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:Screen_Width];
    [self.view addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:calculateView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:(Screen_Height/2 - 64 -37 )/3];
    [self.view addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:calculateView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    [self.view addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:calculateView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:64];
    [self.view addConstraint:constraint];
    
    //底部分割线View
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0,(Screen_Height/2 - 64 -37 )/3 - 2, Screen_Width, 2)];
    bottomView.backgroundColor = [UIColor colorWithRed:255/255.0 green:212/255.0 blue:128/255.0 alpha:1] ;
    [calculateView addSubview:bottomView];
    
    //左边的 钱符号Label  显示
    UILabel *leftLabel = [[UILabel alloc]init];
    leftLabel.tag = 401 ;
    
#pragma mark ----------修改--------------------
    NSString *mType = [[NSUserDefaults standardUserDefaults]valueForKey:MOENY];
    
    if (mType == nil)
    {
        leftLabel.text = @"RMB" ;
    }
    else
    {
        if ([mType isEqualToString:@"日元"])
        {
            mType = @"JPY";
        }
        else if ([mType isEqualToString:@"美元"])
        {
            mType = @"USD";
        }
        else if ([mType isEqualToString:@"欧元"])
        {
            mType = @"EUR";
        }
        else if ([mType isEqualToString:@"英镑"])
        {
            mType = @"GBP";
        }
        else if ([mType isEqualToString:@"人民币"])
        {
            mType = @"RMB";
        }
        else if ([mType isEqualToString:@"澳大利亚元"])
        {
            mType = @"AUD";
        }
        else if ([mType isEqualToString:@"加拿大元"])
        {
            mType = @"CAD";
        }
        else if ([mType isEqualToString:@"瑞士法郎"])
        {
            mType = @"CHF";
        }
        else if ([mType isEqualToString:@"港币"])
        {
            mType = @"HKD";
        }
        else if ([mType isEqualToString:@"新台币"])
        {
            mType = @"TWD";
        }
        else if ([mType isEqualToString:@"韩元"])
        {
            mType = @"KRW";
        }
        else if ([mType isEqualToString:@"泰国铢"])
        {
            mType = @"THB";
        }
        else if ([mType isEqualToString:@"澳门元"])
        {
            mType = @"MOP";
        }
        else if ([mType isEqualToString:@"卢布"])
        {
            mType = @"RUB";
        }
        else if ([mType isEqualToString:@"新西兰元"])
        {
            mType = @"NZD";
        }
        else if ([mType isEqualToString:@"新加坡元"])
        {
            mType = @"SGD";
        }
        leftLabel.text = mType;
    }

    
    leftLabel.font = [UIFont fontWithName:@"American Typewriter" size:17];
    leftLabel.textColor = [UIColor grayColor] ;
    leftLabel.textAlignment = NSTextAlignmentCenter;
    [calculateView addSubview:leftLabel];
    
    leftLabel.translatesAutoresizingMaskIntoConstraints = NO ;
    constraint = [NSLayoutConstraint constraintWithItem:leftLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:Screen_Width/4-10];
    [calculateView addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:leftLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:calculateView attribute:NSLayoutAttributeHeight multiplier:1 constant:calculateView.frame.size.height*2/3];
    [calculateView addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:leftLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:calculateView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    [calculateView addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:leftLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:calculateView attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    [calculateView addConstraint:constraint];
    
    //中间 moneyLabel
    moneyLabel = [[UILabel alloc]init];
    moneyLabel.text = @"0";
    moneyLabel.textAlignment = NSTextAlignmentCenter ;
    moneyLabel.font = [UIFont fontWithName:@"American Typewriter" size:40];
    moneyLabel.textColor = [UIColor colorWithRed:255/255.0 green:212/255.0 blue:128/255.0 alpha:1] ;
    moneyLabel.adjustsFontSizeToFitWidth = YES ;
    [calculateView addSubview:moneyLabel];
    
    moneyLabel.translatesAutoresizingMaskIntoConstraints = NO ;
    constraint = [NSLayoutConstraint constraintWithItem:moneyLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:calculateView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    [calculateView addConstraint:constraint];
    
    constraint= [NSLayoutConstraint constraintWithItem:moneyLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:calculateView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    [calculateView addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:moneyLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:Screen_Width/2+20];
    [calculateView addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:moneyLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:calculateView attribute:NSLayoutAttributeHeight multiplier:1 constant:0];
    [calculateView addConstraint:constraint];
    
}

//chooseScrollView
-(void)chooseScrollViewLayout
{
    //chooseScrollView
    chooseScrollView = [[UIScrollView alloc]init];
    chooseScrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:chooseScrollView];
    
    chooseScrollView.contentSize = CGSizeMake(Screen_Width *3,0);
    chooseScrollView.pagingEnabled = YES ;
    chooseScrollView.showsHorizontalScrollIndicator = NO ;
    chooseScrollView.delegate = self ;
    
    
    chooseScrollView.translatesAutoresizingMaskIntoConstraints = NO ;
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:chooseScrollView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:Screen_Width];
    [self.view addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:chooseScrollView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:(Screen_Height/2 - 64 -37)*2/3];
    [self.view addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:chooseScrollView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1 constant:0 ];
    [self.view addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:chooseScrollView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:64 + (Screen_Height/2-64-37)/3];
    [self.view addConstraint:constraint];
    
    
}

//chooseScrollView中的按钮
-(void)chooseButtonLayout
{
    CGFloat h = (Screen_Height/2 - 64 -37)*2/3;
    CGFloat buttonHeight =  55 ;
    
    NSArray *firstPageLabelArray =  @[@"收入",@"衣服",@"食品",@"车费",@"电影"];
    NSArray *firstPageNormalArray = @[[UIImage imageNamed:@"income128"],[UIImage imageNamed:@"clothes128"],[UIImage imageNamed:@"food128"],[UIImage imageNamed:@"transit128"],[UIImage imageNamed:@"movie128"]];
    NSArray *firstPageSelectedArray = @[[UIImage imageNamed:@"income128selected"],[UIImage imageNamed:@"clothes128selected"],[UIImage imageNamed:@"food128selected"],[UIImage imageNamed:@"transit128selected"],[UIImage imageNamed:@"movie128selected"]];
    int index = 0;
    
    UIView *firstPageView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, (Screen_Height/2 - 64 -37)*2/3)];
    firstPageView.backgroundColor = [UIColor clearColor];
    [chooseScrollView addSubview:firstPageView];
    
    
    for (int i = 0 ; i < 5 ; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [firstPageView addSubview:button];
        
        //button的Tag值 100+
        button.tag = 300+1+i ;
        
        //点击button响应的方法
        [button addTarget:self action:@selector(scrollViewButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        //button样式
        [button setImage:firstPageNormalArray[i] forState:UIControlStateNormal];
        [button setImage:firstPageSelectedArray[i] forState:UIControlStateSelected];
        button.layer.cornerRadius = 5.0f;
        button.layer.masksToBounds = YES ;
        button.titleLabel.font = [UIFont fontWithName:@"American Typewriter" size:20];
        
        //布局
        button.translatesAutoresizingMaskIntoConstraints = NO ;
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:buttonHeight];
        [firstPageView addConstraint:constraint];
        
        constraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:buttonHeight];
        [firstPageView addConstraint:constraint];
        
        constraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:firstPageView attribute:NSLayoutAttributeLeading multiplier:1 constant:(i+1)*(Screen_Width - 5 * buttonHeight)/6 +buttonHeight*i];
        [firstPageView addConstraint:constraint];
        
        constraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:firstPageView attribute:NSLayoutAttributeTop multiplier:1 constant:(h-buttonHeight-21)/2];
        [firstPageView addConstraint:constraint];
        
        //button下面的字体显示Label
        UILabel *chooseLabel = [[UILabel alloc]init];
        [firstPageView addSubview:chooseLabel];
        
        chooseLabel.text = firstPageLabelArray[index];
        chooseLabel.font = [UIFont fontWithName:@"American Typewriter" size:14];
        chooseLabel.textAlignment = NSTextAlignmentCenter ;
        chooseLabel.textColor = [UIColor grayColor];
        index++ ;
        
        //布局
        chooseLabel.translatesAutoresizingMaskIntoConstraints = NO ;
        constraint = [NSLayoutConstraint constraintWithItem:chooseLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:button attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
        [firstPageView addConstraint:constraint];
        
        constraint = [NSLayoutConstraint constraintWithItem:chooseLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:21];
        [firstPageView addConstraint:constraint];
        
        constraint = [NSLayoutConstraint constraintWithItem:chooseLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:button attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
        [firstPageView addConstraint:constraint];
        
        constraint = [NSLayoutConstraint constraintWithItem:chooseLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:button attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
        [firstPageView addConstraint:constraint];
        
    }
    
    //第二页
    NSArray *secondPageLabelArray =  @[@"游戏",@"话费",@"购书",@"超市",@"烟酒"];
    index = 0;
    NSArray *secondPageNormalArray = @[[UIImage imageNamed:@"game128"],[UIImage imageNamed:@"cellphone128"],[UIImage imageNamed:@"book128"],[UIImage imageNamed:@"supermarket128"],[UIImage imageNamed:@"alcohol128"]];
    NSArray *secondPageSelectedArray = @[[UIImage imageNamed:@"game128selected"],[UIImage imageNamed:@"cellphone128selected"],[UIImage imageNamed:@"book128selected"],[UIImage imageNamed:@"supermarket128selected"],[UIImage imageNamed:@"alcohol128selected"]];
    
    UIView *secondPageView = [[UIView alloc]initWithFrame:CGRectMake(Screen_Width, 0, Screen_Width, (Screen_Height/2 - 64 -37)*2/3)];
    secondPageView.backgroundColor = [UIColor clearColor];
    [chooseScrollView addSubview:secondPageView];
    
    
    for (int i = 0 ; i < 5 ; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [secondPageView addSubview:button];
        
        
        //button的Tag值 100+
        button.tag = 300+6+i ;
        
        //点击button响应的方法
        [button addTarget:self action:@selector(scrollViewButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        //button样式
        [button setImage:secondPageNormalArray[i] forState:UIControlStateNormal];
        [button setImage:secondPageSelectedArray[i] forState:UIControlStateSelected];
        
        button.layer.cornerRadius = 5.0f;
        button.layer.masksToBounds = YES ;
        button.titleLabel.font = [UIFont fontWithName:@"American Typewriter" size:20];
        
        //布局
        button.translatesAutoresizingMaskIntoConstraints = NO ;
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:buttonHeight];
        [secondPageView addConstraint:constraint];
        
        constraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:buttonHeight];
        [secondPageView addConstraint:constraint];
        
        constraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:secondPageView attribute:NSLayoutAttributeLeading multiplier:1 constant:(i+1)*(Screen_Width - 5 * buttonHeight)/6 +buttonHeight*i];
        [secondPageView addConstraint:constraint];
        
        constraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:secondPageView attribute:NSLayoutAttributeTop multiplier:1 constant:(h-buttonHeight-21)/2];
        [secondPageView addConstraint:constraint];
        
        //button下面的字体显示Label
        UILabel *chooseLabel = [[UILabel alloc]init];
        [secondPageView addSubview:chooseLabel];
        
        chooseLabel.text = secondPageLabelArray[index];
        chooseLabel.font = [UIFont fontWithName:@"American Typewriter" size:14];
        chooseLabel.textAlignment = NSTextAlignmentCenter ;
        chooseLabel.textColor = [UIColor grayColor];
        index++ ;
        
        //布局
        chooseLabel.translatesAutoresizingMaskIntoConstraints = NO ;
        constraint = [NSLayoutConstraint constraintWithItem:chooseLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:button attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
        [secondPageView addConstraint:constraint];
        
        constraint = [NSLayoutConstraint constraintWithItem:chooseLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:21];
        [secondPageView addConstraint:constraint];
        
        constraint = [NSLayoutConstraint constraintWithItem:chooseLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:button attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
        [secondPageView addConstraint:constraint];
        
        constraint = [NSLayoutConstraint constraintWithItem:chooseLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:button attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
        [secondPageView addConstraint:constraint];
        
    }
    
    //第三页
    NSArray *thirdPageLabelArray =  @[@"旅行",@"保险",@"水电煤",@"房费",@"其它"];
    index = 0;
    
    NSArray *thirdPageNormalArray = @[[UIImage imageNamed:@"travel128"],[UIImage imageNamed:@"insurance128"],[UIImage imageNamed:@"water128"],[UIImage imageNamed:@"house128"],[UIImage imageNamed:@"other128"]];
    NSArray *thirdPageSelectedArray = @[[UIImage imageNamed:@"travel128selected"],[UIImage imageNamed:@"insurance128selected"],[UIImage imageNamed:@"water128selected"],[UIImage imageNamed:@"house128selected"],[UIImage imageNamed:@"other128selected"]];
    
    UIView *thirdPageView = [[UIView alloc]initWithFrame:CGRectMake(2*Screen_Width, 0, Screen_Width, (Screen_Height/2 - 64 -37)*2/3)];
    thirdPageView.backgroundColor = [UIColor clearColor];
    [chooseScrollView addSubview:thirdPageView];
    
    
    for (int i = 0 ; i < 5 ; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [thirdPageView addSubview:button];
        
        //button的Tag值 100+
        button.tag = 300+11+i ;
        
        //点击button响应的方法
        [button addTarget:self action:@selector(scrollViewButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        //button样式
        
        [button setImage:thirdPageNormalArray[i] forState:UIControlStateNormal];
        [button setImage:thirdPageSelectedArray[i] forState:UIControlStateSelected];
        button.layer.cornerRadius = 5.0f;
        button.layer.masksToBounds = YES ;
        button.titleLabel.font = [UIFont fontWithName:@"American Typewriter" size:20];
        
        //布局
        button.translatesAutoresizingMaskIntoConstraints = NO ;
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:buttonHeight];
        [thirdPageView addConstraint:constraint];
        
        constraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:buttonHeight];
        [thirdPageView addConstraint:constraint];
        
        constraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:thirdPageView attribute:NSLayoutAttributeLeading multiplier:1 constant:(i+1)*(Screen_Width - 5 * buttonHeight)/6 +buttonHeight*i];
        [thirdPageView addConstraint:constraint];
        
        constraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:thirdPageView attribute:NSLayoutAttributeTop multiplier:1 constant:(h-buttonHeight-21)/2];
        [thirdPageView addConstraint:constraint];
        
        //button下面的字体显示Label
        UILabel *chooseLabel = [[UILabel alloc]init];
        [thirdPageView addSubview:chooseLabel];
        
        chooseLabel.text = thirdPageLabelArray[index];
        chooseLabel.font = [UIFont fontWithName:@"American Typewriter" size:14];
        chooseLabel.textAlignment = NSTextAlignmentCenter ;
        chooseLabel.textColor = [UIColor grayColor];
        index++ ;
        
        //布局
        chooseLabel.translatesAutoresizingMaskIntoConstraints = NO ;
        constraint = [NSLayoutConstraint constraintWithItem:chooseLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:button attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
        [thirdPageView addConstraint:constraint];
        
        constraint = [NSLayoutConstraint constraintWithItem:chooseLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:21];
        [thirdPageView addConstraint:constraint];
        
        constraint = [NSLayoutConstraint constraintWithItem:chooseLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:button attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
        [thirdPageView addConstraint:constraint];
        
        constraint = [NSLayoutConstraint constraintWithItem:chooseLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:button attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
        [thirdPageView addConstraint:constraint];
        
    }
    
}

//Page Control
-(void)PageControlLayout
{
    //Page Control
    pageControl = [[UIPageControl alloc]init];
    pageControl.backgroundColor = [UIColor clearColor];
    [self.view addSubview:pageControl];
    
    pageControl.numberOfPages = 3 ;
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:255/255.0 green:212/255.0 blue:128/255.0 alpha:1];
    
    //布局
    pageControl.translatesAutoresizingMaskIntoConstraints = NO ;
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:pageControl attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:Screen_Width];
    [self.view addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:pageControl attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:37];
    [self.view addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:pageControl attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:chooseScrollView attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    [self.view addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:pageControl attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:chooseScrollView attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    [self.view addConstraint:constraint];
}

//编辑View
-(void)editViewLayout
{
    //编辑View,在numberView上方
    editView = [[UIView alloc]init];
    editView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:editView];
    
    editView.translatesAutoresizingMaskIntoConstraints = NO ;
    NSLayoutConstraint * constraint = [NSLayoutConstraint constraintWithItem:editView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:Screen_Width];
    [self.view addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:editView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:Screen_Height/10];
    [self.view addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:editView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    [self.view addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:editView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:Screen_Height/2];
    [self.view addConstraint:constraint];
    
}

//编辑button
-(void)editButtonLayout
{
    
    CGFloat width = ( Screen_Width - 4*2 ) / 3;
    CGFloat height = (Screen_Height*2/5 - 5*2)/ 4 ;
    
    
    //"x"按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [editView addSubview:button];
    
    //    [button addSubview:image];
    //button的Tag值 200+
    button.tag = 201 ;
    
    //点击button响应的方法
    [button addTarget:self action:@selector(DelectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"delect128"]];
    imageView.frame = CGRectMake((width-height/2)/2, height/4, height/2, height/2);
    //button样式
    [button addSubview:imageView];
    
    button.backgroundColor = [UIColor colorWithRed:145/255.0 green:145/255.0 blue:160/255.0 alpha:1];
    button.layer.cornerRadius = 5.0f;
    button.layer.masksToBounds = YES ;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont fontWithName:@"American Typewriter" size:20];
    
    //布局
    button.translatesAutoresizingMaskIntoConstraints = NO ;
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:width];
    [editView addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:height];
    [editView addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:editView attribute:NSLayoutAttributeLeading multiplier:1 constant:2];
    [editView addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:editView attribute:NSLayoutAttributeTop multiplier:1 constant:2];
    [editView addConstraint:constraint];
    
    //编辑按钮
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    [editView addSubview:button];
    imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"edit128"]];
    imageView.frame = CGRectMake((width-height/2)/2, height/4, height/2, height/2);
    [button addSubview:imageView];
    //button的Tag值 200+
    button.tag = 202 ;
    
    //点击button响应的方法
    [button addTarget:self action:@selector(editButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //button样式
    button.backgroundColor = [UIColor colorWithRed:190/255.0 green:190/255.0 blue:190/255.0 alpha:1];
    button.layer.cornerRadius = 5.0f;
    button.layer.masksToBounds = YES ;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont fontWithName:@"American Typewriter" size:20];
    
    //布局
    button.translatesAutoresizingMaskIntoConstraints = NO ;
    constraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:width];
    [editView addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:height];
    [editView addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:editView attribute:NSLayoutAttributeLeading multiplier:1 constant:width+2*2];
    [editView addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:editView attribute:NSLayoutAttributeTop multiplier:1 constant:2];
    [editView addConstraint:constraint];
    
    //保存(右边)按钮
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    [editView addSubview:button];
    imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"save128"]];
    imageView.frame = CGRectMake((width-height/2)/2, height/4, height/2, height/2);
    [button addSubview:imageView];
    
    //button的Tag值 200+
    button.tag = 203 ;
    
    //点击button响应的方法
    [button addTarget:self action:@selector(saveButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //button样式
    button.backgroundColor = [UIColor colorWithRed:255/255.0 green:212/255.0 blue:128/255.0 alpha:1];
    button.layer.cornerRadius = 5.0f;
    button.layer.masksToBounds = YES ;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont fontWithName:@"American Typewriter" size:20];
    
    //布局
    button.translatesAutoresizingMaskIntoConstraints = NO ;
    constraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:width];
    [editView addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:height];
    [editView addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:editView attribute:NSLayoutAttributeLeading multiplier:1 constant:width*2+2*3];
    [editView addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:editView attribute:NSLayoutAttributeTop multiplier:1 constant:2];
    [editView addConstraint:constraint];
    
}

//数字View
-(void)numberViewLayout
{
    //数字View
    numberView = [[UIView alloc]init];
    numberView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:numberView];
    numberViewIsDown = NO ;
    
    numberView.translatesAutoresizingMaskIntoConstraints = NO ;
    NSLayoutConstraint * constraint = [NSLayoutConstraint constraintWithItem:numberView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:Screen_Width];
    [self.view addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:numberView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:Screen_Height *2 * Screen_Height / 5];
    [self.view addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:numberView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1 constant:0 ];
    [self.view addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:numberView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:(Screen_Height/2+Screen_Height/10)];
    [self.view addConstraint:constraint];
}

//数字button
-(void)numberButtonLayout
{
    NSArray *numberArray = @[@"7",@"8",@"9",@"4",@"5",@"6",@"1",@"2",@"3"];
    
    CGFloat width = ( Screen_Width - 4*2 ) / 3;
    CGFloat height = (Screen_Height*2/5 - 5*2)/ 4 ;
    
    //布局1~9
    int index = 0 ;
    for (int i = 0 ; i < 3 ; i++)
    {
        for (int j = 0; j< 3; j++)
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            [numberView addSubview:button];
            
            //button的Tag值 100+
            button.tag = 100 + [numberArray[index] intValue] ;
            
            //点击button响应的方法
            [button addTarget:self action:@selector(numberButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            
            //button样式
            [button setTitle:numberArray[index] forState:UIControlStateNormal];
            button.backgroundColor = [UIColor colorWithRed:190/255.0 green:190/255.0 blue:190/255.0 alpha:1];
            button.layer.cornerRadius = 5.0f;
            button.layer.masksToBounds = YES ;
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont fontWithName:@"American Typewriter" size:20];
            
            index++;
            
            //布局
            button.translatesAutoresizingMaskIntoConstraints = NO ;
            NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:width];
            [numberView addConstraint:constraint];
            
            constraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:height];
            [numberView addConstraint:constraint];
            
            constraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:numberView attribute:NSLayoutAttributeLeading multiplier:1 constant:width*j+2*(j+1)];
            [numberView addConstraint:constraint];
            
            constraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:numberView attribute:NSLayoutAttributeTop multiplier:1 constant:height*i+2*(i+1)];
            [numberView addConstraint:constraint];
        }
    }
    
    //布局 0
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [numberView addSubview:button];
    
    //button"0"的Tag值 110
    button.tag = 110;
    
    //点击button响应的方法
    [button addTarget:self action:@selector(zeroButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //button样式
    [button setTitle:@"0" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor colorWithRed:190/255.0 green:190/255.0 blue:190/255.0 alpha:1];
    button.layer.cornerRadius = 5.0f;
    button.layer.masksToBounds = YES ;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont fontWithName:@"American Typewriter" size:20];
    //布局
    button.translatesAutoresizingMaskIntoConstraints = NO ;
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:width*2+2];
    [numberView addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:height];
    [numberView addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:numberView attribute:NSLayoutAttributeLeading multiplier:1 constant:2];
    [numberView addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:numberView attribute:NSLayoutAttributeTop multiplier:1 constant:height*3+2*4];
    [numberView addConstraint:constraint];
    
    //布局 "."
    button = [UIButton buttonWithType:UIButtonTypeSystem];
    [numberView addSubview:button];
    
    //button"."的Tag值 111
    button.tag = 111;
    
    //点击button响应的方法
    [button addTarget:self action:@selector(pointButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //button样式
    [button setTitle:@"." forState:UIControlStateNormal];
    button.backgroundColor = [UIColor colorWithRed:190/255.0 green:190/255.0 blue:190/255.0 alpha:1];
    button.layer.cornerRadius = 5.0f;
    button.layer.masksToBounds = YES ;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont fontWithName:@"American Typewriter" size:20];
    
    //布局
    button.translatesAutoresizingMaskIntoConstraints = NO ;
    constraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:width];
    [numberView addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:height];
    [numberView addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:numberView attribute:NSLayoutAttributeLeading multiplier:1 constant:width*2 + 6];
    [numberView addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:numberView attribute:NSLayoutAttributeTop multiplier:1 constant:height*3+2*4];
    [numberView addConstraint:constraint];
    
}

//RightBarButton
-(void)rightBarButtonLayout
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 20, 20);
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightBarButton ;
    
    [button addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [button setImage:[UIImage imageNamed:@"login128"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"login128selected"] forState:UIControlStateSelected];
    
}

-(void)leftBarButtonLayout
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0,25,25);
    [button addTarget:self action:@selector(settingAction:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"setting128"] forState:UIControlStateNormal];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem ;
}

#pragma mark ---------点击Button响应的方法-----------------
//点击numberButton响应的方法
-(void)numberButtonAction:(UIButton *)sender
{
    if ([showMoneyArray containsObject:@"."])
    {
        NSUInteger position = [showMoneyArray indexOfObject:@"."] ;
        //显示只保留两位小数
        if (showMoneyArray.count > position+2)
        {
            
        }
        else
        {
            [showMoneyArray addObject:sender.titleLabel.text];
            NSString *text = [showMoneyArray componentsJoinedByString:@""];
            moneyLabel.text = text ;
        }
    }
    else
    {
        if (showMoneyArray.count == 0)
        {
            [showMoneyArray addObject:sender.titleLabel.text];
            moneyLabel.text = sender.titleLabel.text ;
        }
        else
        {
            if ([showMoneyArray[0] isEqualToString:@"0"])
            {
                [showMoneyArray removeAllObjects];
                [showMoneyArray addObject:sender.titleLabel.text];
                NSString *text = [showMoneyArray componentsJoinedByString:@""];
                moneyLabel.text = text ;
            }
            else
            {
                [showMoneyArray addObject:sender.titleLabel.text];
                NSString *text = [showMoneyArray componentsJoinedByString:@""];
                moneyLabel.text = text ;
            }
        }
        
    }
}

-(void)zeroButtonAction:(UIButton *)sender
{
    if (showMoneyArray.count == 0)
    {
        [showMoneyArray addObject:sender.titleLabel.text];
        moneyLabel.text = sender.titleLabel.text ;
    }
    else
    {
        if ([showMoneyArray containsObject:@"."])
        {
            NSUInteger position = [showMoneyArray indexOfObject:@"."] ;
            //显示只保留两位小数
            if (showMoneyArray.count > position+2)
            {
                
            }
            else
            {
                [showMoneyArray addObject:sender.titleLabel.text];
                NSString *text = [showMoneyArray componentsJoinedByString:@""];
                moneyLabel.text = text ;
            }
        }
        else
        {
            //不包含点
            if ([showMoneyArray[0] isEqualToString:@"0"])
            {
                
            }
            else
            {
                [showMoneyArray addObject:sender.titleLabel.text];
                NSString *text = [showMoneyArray componentsJoinedByString:@""];
                moneyLabel.text = text ;
            }
        }
    }
}

-(void)pointButtonAction:(UIButton *)sender
{
    if ([showMoneyArray containsObject:@"."])
    {
        
    }
    else
    {
        if (showMoneyArray.count == 0)
        {
            [showMoneyArray addObject:@"0"];
            [showMoneyArray addObject:sender.titleLabel.text];
            NSString *text = [showMoneyArray componentsJoinedByString:@""];
            moneyLabel.text = text ;
        }
        else
        {
            [showMoneyArray addObject:sender.titleLabel.text];
            NSString *text = [showMoneyArray componentsJoinedByString:@""];
            moneyLabel.text = text ;
        }
    }
}

//点击DelectButtonAction响应的方法
-(void)DelectButtonAction:(UIButton *)sender
{
    if (showMoneyArray.count == 0)
    {
        moneyLabel.text = @"0" ;
    }
    else if (showMoneyArray.count == 1)
    {
        [showMoneyArray removeLastObject];
        moneyLabel.text = @"0" ;
    }
    else
    {
        [showMoneyArray removeLastObject];
        NSString *text = [showMoneyArray componentsJoinedByString:@""];
        moneyLabel.text = text ;
    }
}

//点击editButtonAction响应的方法
-(void)editButtonAction:(UIButton *)sender
{
    writeViewController = [[WriteViewController alloc]init];
    UINavigationController *writeNavigationController = [[UINavigationController alloc]initWithRootViewController:writeViewController];
    writeNavigationController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self.navigationController presentViewController:writeNavigationController animated:YES completion:^{
        
    }];
    __weak NSMutableArray *array = remarkArray;
    writeViewController.transValueBlock = ^(NSString *string ){
        
        [array addObject:string];
//        [remarkArray addObject:string];
    };
    remarkArray = array ;
}

//点击saveButtonAction响应的方法
-(void)saveButtonAction:(UIButton *)sender
{
    if (chooseScrollViewButtonTag == 600)
    {
        [[[UIAlertView alloc]initWithTitle:@"提示" message:@"请选择种类" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        return ;
    }
    
    if ([[pictureIsSelectedArray lastObject] isEqualToString:@"notSelected"])
    {
        [[[UIAlertView alloc]initWithTitle:@"提示" message:@"请选择种类" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        return ;
    }
    
    /*
     英文名字	中文名字
     date	日期
     money	金额
     moneyType	金额类型（美元或者人民币等等）
     type	消费类型
     typeImageName	消费类型对应图片名称
     remark	备注
     */
    
    //date	日期
    NSDate *Date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *date = [formatter stringFromDate:Date];
    
    //money	金额
    NSString *money ;
    if (showMoneyArray.count == 0)
    {
        money = @"0";
    }
    else
    {
        money = [showMoneyArray componentsJoinedByString:@""];
    }
    
    //moneyType	金额类型（美元或者人民币等等）
    NSString *moneyType;

    if (moneyTypeArray.count == 0)
    {
        moneyType = @"RMB";
    }
    else
    {
         moneyType = [moneyTypeArray lastObject];
    }
//     NSLog(@"moneyType = %@",moneyType);
    
    //type	消费类型
    NSString *type ;
    switch (chooseScrollViewButtonTag)
    {
        case 301:
        {
            type = @"收入";
        }
            break;
        case 302:
        {
            type = @"衣服";
        }
            break;
        case 303:
        {
            type = @"食品";
        }
            break;
        case 304:
        {
            type = @"车费";
        }
            break;
        case 305:
        {
            type = @"电影";
        }
            break;
        case 306:
        {
            type = @"游戏";
        }
            break;
        case 307:
        {
            type = @"话费";
        }
            break;
        case 308:
        {
            type = @"购书";
        }
            break;
        case 309:
        {
            type = @"超市";
        }
            break;
        case 310:
        {
            type = @"烟酒";
        }
            break;
        case 311:
        {
            type = @"旅行";
        }
            break;
        case 312:
        {
            type = @"保险";
        }
            break;
        case 313:
        {
            type = @"水电煤";
        }
            break;
        case 314:
        {
            type = @"房费";
        }
            break;
        case 315:
        {
            type = @"其他";
        }
            break;
        default:
            break;
    }
    
    //typeImageName	消费类型对应图片名称
    NSString *typeImageName ;
    
    switch (chooseScrollViewButtonTag)
    {
        case 301:
        {
            typeImageName = @"income128";
        }
            break;
        case 302:
        {
            typeImageName = @"clothes128";
        }
            break;
        case 303:
        {
            typeImageName = @"food128";
        }
            break;
        case 304:
        {
            typeImageName = @"transit128";
        }
            break;
        case 305:
        {
            typeImageName = @"movie128";
        }
            break;
        case 306:
        {
            typeImageName = @"game128";
        }
            break;
        case 307:
        {
            typeImageName = @"cellphone128";
        }
            break;
        case 308:
        {
            typeImageName = @"book128";
        }
            break;
        case 309:
        {
            typeImageName = @"supermarket128";
        }
            break;
        case 310:
        {
            typeImageName = @"alcohol128";
        }
            break;
        case 311:
        {
            typeImageName = @"travel128";
        }
            break;
        case 312:
        {
            typeImageName = @"insurance128";
        }
            break;
        case 313:
        {
            typeImageName = @"water128";
        }
            break;
        case 314:
        {
            typeImageName = @"house128";
        }
            break;
        case 315:
        {
            typeImageName = @"other128";
        }
            break;
        default:
            break;
    }
    
    //remark	备注
    NSString *remark ;
    if (remarkArray.count == 0)
    {
        remark = @"";
    }
    else
    {
        remark = [remarkArray lastObject];
    }

    ddic= @{
                         @"date":date,
                         @"money":money,
                         @"moneyType":moneyType,
                         @"type":type,
                         @"typeImageName":typeImageName,
                         @"remark":remark
                         };
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"保存记录" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil] ;
    [alertView show];
    alertView.delegate = self ;
    /*
    //查找
    NSArray *array =[SQLOperation findModelFromType:@"食品"];
    for (int i = 0 ; i < array.count; i++)
    {
        Model *m = array[i];
        NSLog(@"date = %@,m.money = %@ ,m.moneyType = %@,type = %@,typeImageName = %@ , remark =%@",m.date,m.money,m.moneyType,m.type,m.typeImageName,m.remark );
    }
     */
}

//点击chooseScrollView 中的按钮时响应的方法
-(void)scrollViewButtonAction:(UIButton *)sender
{
    if (sender.selected == YES)
    {
        [pictureIsSelectedArray addObject:@"notSelected"];
    }
    else
    {
        //选中状态
        [pictureIsSelectedArray addObject:@"isSelected"];
    }
    
    if (preChooseButtonArray.count == 0 )
    {
        [preChooseButtonArray addObject:sender];
        sender.selected = !sender.selected ;
    }
    else if (preChooseButtonArray.count == 1)
    {
        [preChooseButtonArray addObject:sender];
        if (preChooseButtonArray[0] != preChooseButtonArray[1])
        {
            UIButton *button = (UIButton *)preChooseButtonArray[0];
            button.selected = NO ;
            sender.selected = !sender.selected ;
        }
        else
        {
            sender.selected = !sender.selected ;
        }
    }
    else
    {
        [preChooseButtonArray exchangeObjectAtIndex:0 withObjectAtIndex:1];
        [preChooseButtonArray removeLastObject];
        [preChooseButtonArray addObject:sender];
        
        if (preChooseButtonArray[0] != preChooseButtonArray[1])
        {
            UIButton *button = (UIButton *)preChooseButtonArray[0];
            button.selected = NO ;
            sender.selected = !sender.selected ;
        }
        else
        {
            sender.selected = !sender.selected ;
        }
        
    }
    chooseScrollViewButtonTag = sender.tag ;
    
    
}

//点击login响应的方法
-(void)loginAction:(UIButton *)sender
{
    //    sender.selected = !sender.selected ;
    id value=[[NSUserDefaults standardUserDefaults] valueForKey:SwitchKey];
    if (value == nil) {
        //直接进去看数据
        LinViewController *queryViewController = [LinViewController new];
        [self.navigationController pushViewController:queryViewController animated:YES];
        
    }else{
        if([value boolValue]){
            
            [self.navigationController pushViewController:[[NewViewController alloc]init] animated:YES];
        }
        else{
            //直接进去看数据
            LinViewController *queryViewController = [LinViewController new];
            [self.navigationController pushViewController:queryViewController animated:YES];
        }
    }
}

//点击setting响应的方法
-(void)settingAction:(UIButton *)sender
{
    DemoViewController *demoViewController = [[DemoViewController alloc]init];
    UINavigationController *demoViewNavigationController = [[UINavigationController alloc]initWithRootViewController:demoViewController];
        demoViewNavigationController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal ;
    [self presentViewController:demoViewNavigationController animated:YES completion:^{
        
    }];
    
    demoViewController.moneyTransValueBlock = ^(NSString *moneyType )
    {
//        NSLog(@"moneyType = %@",moneyType);
        UILabel *leftLabel = (UILabel *)[self.view viewWithTag:401];
        
        if ([moneyType isEqualToString:@"日元"])
        {
            moneyType = @"JPY";
        }
        else if ([moneyType isEqualToString:@"美元"])
        {
            moneyType = @"USD";
        }
        else if ([moneyType isEqualToString:@"欧元"])
        {
            moneyType = @"EUR";
        }
        else if ([moneyType isEqualToString:@"英镑"])
        {
            moneyType = @"GBP";
        }
        else if ([moneyType isEqualToString:@"人民币"])
        {
            moneyType = @"RMB";
        }
        else if ([moneyType isEqualToString:@"澳大利亚元"])
        {
            moneyType = @"AUD";
        }
        else if ([moneyType isEqualToString:@"加拿大元"])
        {
            moneyType = @"CAD";
        }
        else if ([moneyType isEqualToString:@"瑞士法郎"])
        {
            moneyType = @"CHF";
        }
        else if ([moneyType isEqualToString:@"港币"])
        {
            moneyType = @"HKD";
        }
        else if ([moneyType isEqualToString:@"新台币"])
        {
            moneyType = @"TWD";
        }
        else if ([moneyType isEqualToString:@"韩元"])
        {
            moneyType = @"KRW";
        }
        else if ([moneyType isEqualToString:@"泰国铢"])
        {
            moneyType = @"THB";
        }
        else if ([moneyType isEqualToString:@"澳门元"])
        {
            moneyType = @"MOP";
        }
        else if ([moneyType isEqualToString:@"卢布"])
        {
            moneyType = @"RUB";
        }
        else if ([moneyType isEqualToString:@"新西兰元"])
        {
            moneyType = @"NZD";
        }
        else if ([moneyType isEqualToString:@"新加坡元"])
        {
            moneyType = @"SGD";
        }
        
        leftLabel.text = moneyType ;
        [moneyTypeArray addObject:moneyType];
    };

    demoViewController.budgetTransValueBlock = ^(NSString *budget)
    {
        NSLog(@"budget = %@",budget);
        [budgetArray addObject:budget];
    };
    
}

#pragma mark ------chooseScrollView的代理方法------------
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (chooseScrollView.contentOffset.x < Screen_Width -30)
    {
        pageControl.currentPage = 0 ;
    }
    else if (chooseScrollView.contentOffset.x < 2*Screen_Width && chooseScrollView.contentOffset.x > Screen_Width -30 )
    {
        pageControl.currentPage = 1 ;
    }
    else if (chooseScrollView.contentOffset.x < 3*Screen_Width && chooseScrollView.contentOffset.x > Screen_Width *2 -30)
    {
        pageControl.currentPage = 2 ;
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

#pragma mark ----------UIAlertViewDelegate-------------------
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
       Model *m = [[Model alloc]initWithDictionary:ddic];
      //插入数据库
      [SQLOperation insertWithModel:m];
       moneyLabel.text = @"0";
        [showMoneyArray removeAllObjects];
    }
    else
    {
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
