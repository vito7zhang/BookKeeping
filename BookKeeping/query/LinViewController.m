//
//  LinViewController.m
//  UILIn
//
//  Created by Ibokan2 on 15/9/23.
//  Copyright (c) 2015年 TaLinBoy. All rights reserved.
//

#import "LinViewController.h"
#import "LinTableViewCell.h"
# define SelfViewWidth self.view.frame.size.width
# define SelfViewHeight ([UIScreen mainScreen].bounds.size.height - 64)
#define buttonWidth SelfViewWidth/5
#define showViewHeigth SelfViewHeight * 0.42
#define buttonSeparatorWidth (SelfViewWidth - buttonWidth*4)/5
#define buttonViewHeight 44.0
#define contentViewHeight ([UIScreen mainScreen].bounds.size.height - showViewHeigth - buttonViewHeight -64.0)
#define cellHeight 44.0
#define subTableViewCellWidth ([UIScreen mainScreen].bounds.size.width - 80)
#define findDateNil -1000
#define buttonHeightOfDescriptionView  40.0
#define buttonMarginToTopOfDescriptionView  (descriptionView.frame.size.height - buttonHeightOfDescriptionView-10)

@interface LinViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    
    
    UIButton *buttonYear;  //按钮 年
    UIButton *buttonMonth; //按钮 月
    UIButton *buttonDay;  //按钮 日
    UIButton *buttonScale; //linTableView的控制扩大或缩小
    
    UILabel *lineLabel;  // 按钮下方跟着按钮做动画的线
    
    UITableView *linTableView; //主要的TableView
     NSMutableArray *linTableViewDateScoure; //存放主要的TableView的数据
    NSIndexPath *linIsSelectionIndexPath; //存放TableView中被选的单元格位置
    CGFloat isSelectionRowHeight; //用于设置TableView中被选的单元格状态的高度
    
    UITableView *subTableView; //在TableView选中状态下的单元格中嵌套的子视图
    NSIndexPath *subIsSelectionIndexPath; //存放subTableView中被选的单元格位置
    NSMutableArray *subTableViewDateSoure; //存放subTableView的数据
    NSArray *types;  //存放消费类型
    NSString *selectDate; //被选中的单元格的日期
    
    NSString *moneyType; //用于指定货币类型
    UIView *descriptionView; //用于为描述某一条详细信息的UITextView提供父类。
    NSString *dataString; //用于记录选择的日期
    UILabel *remarkTextLabel; //用于显示某一条详细信息
    
    
    //一下用于控制显示TableView单元格中的数据类型是以什么为单位
    BOOL flagYear;
    BOOL flagMoth;
    BOOL flagDay;
    
    BOOL flagScale; // 控制TableView的大小
    
    //传值给分类比例显示图showView
    NSMutableArray *typeArray;
    NSMutableArray *consumeArray;
  
}
@end

@implementation LinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    //数据初始化
    [self loadData];
    subTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    //视图布局
    
    [self loadMainSubView];
    [self addContentViewSubView];
    [self showMonth];
    [self setDescriptionView];
    
    //测试
//    self.showView.backgroundColor = [UIColor cyanColor];
//    self.buttonView.backgroundColor = [UIColor colorWithRed:109/255.0 green:200/255.0 blue:250/255.0 alpha:1];
//    self.contentView.backgroundColor = [UIColor blueColor];
    
//   [UIScreen mainScreen].bounds.size.height
    
}

-(void) loadData{
    flagScale = NO;
    flagYear = YES;
    flagMoth = YES;
    flagDay = NO;
    subTableViewDateSoure = [NSMutableArray array];
    linTableViewDateScoure = [NSMutableArray array];
    types = @[@"alcohol",@"book",@"cellphone",@"clothes",@"food",@"game",@"house",@"income",@"insurance",@"movie",@"other",@"supermarket",@"transit",@"travel",@"water"];
    /*
     //type	消费类型
     @"烟酒",@"购书",@"话费",@"衣服",@"食品",@"游戏",@"房费",@"收入",@"保险",@"电影",@"其他",@"超市",@"车费",@"旅行",@"水电煤"
     
     */
    selectDate = [self nowDateDay];
    dataString = [selectDate substringWithRange:NSMakeRange(0, 7)];
    
}

-(NSString *) nowDateYear{
    NSString *year = [self nowDateDay];
    year = [year substringWithRange:NSMakeRange(0, 4)];
    return year;
}

-(NSString *) nowDateMonth{
    NSString *month = [self nowDateDay];
    month = [month substringWithRange:NSMakeRange(0, 7)];
    return month;
}

-(NSString *) nowDateDay {
     NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *string = [dateFormatter stringFromDate:date];
    return string;
}


//创建descriptionView
-(void) setDescriptionView {
    descriptionView = [[UIView alloc] initWithFrame:CGRectMake(20,SelfViewHeight, SelfViewWidth-40, SelfViewHeight - 40)];
    descriptionView.layer.cornerRadius = 20.0f;
    descriptionView.layer.masksToBounds = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(descriptionViewHiddenAction)];
    tap.numberOfTapsRequired = 2;
    [descriptionView addGestureRecognizer:tap];
    UIImageView *iamgeView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, descriptionView.frame.size.width, descriptionView.frame.size.height)];
    iamgeView.image = [UIImage imageNamed:@"goldBackground"];
    [descriptionView addSubview:iamgeView];
    
   
    
    UIButton *button0 = [[UIButton  alloc] initWithFrame:CGRectMake((descriptionView.frame.size.width - buttonHeightOfDescriptionView*2)/3, buttonMarginToTopOfDescriptionView,buttonHeightOfDescriptionView,buttonHeightOfDescriptionView)];
    [self setButtonStyle:button0];
    [button0 setTitle:@"返" forState:0];
    [button0 addTarget:self action:@selector(descriptionViewHiddenAction) forControlEvents:UIControlEventTouchUpInside];
    [descriptionView addSubview:button0];
    
    UIButton *button1 = [[UIButton  alloc] initWithFrame:CGRectMake((descriptionView.frame.size.width - buttonHeightOfDescriptionView*2)/3*2+buttonHeightOfDescriptionView, buttonMarginToTopOfDescriptionView,buttonHeightOfDescriptionView, buttonHeightOfDescriptionView)];
    [button1 setTitle:@"删" forState:0];
    
    [button1 addTarget:self action:@selector(willDeleteMessge) forControlEvents:UIControlEventTouchUpInside];
    [self setButtonStyle:button1];
    [descriptionView addSubview:button1];
    
    remarkTextLabel = [[UILabel  alloc] init];
    [descriptionView addSubview:remarkTextLabel];
    
    [self.view addSubview:descriptionView];
    descriptionView.hidden = YES;
}


-(void) setNavigationItemLeftBarButtonItem{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0,20,20);
    [button setImage:[UIImage imageNamed:@"back128"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backBarButtonAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBarButton = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = backBarButton ;
}

-(void) backBarButtonAction{
   [self.navigationController popToRootViewControllerAnimated:YES];
}

//为descriptionView中的button创建样式
-(void) setButtonStyle:(UIButton *)button {
    [button setTitleColor:[UIColor blackColor] forState:0];
    button.titleLabel.font = [UIFont systemFontOfSize:20];
    button.layer.cornerRadius = 20.0f;
    button.layer.masksToBounds = YES;
    button.layer.borderWidth = 3.0f;
    button.layer.borderColor =  [UIColor redColor].CGColor;
    button.layer.backgroundColor = [UIColor whiteColor].CGColor;
    [button addTarget:self action:@selector(setButtonStyleTouchDown:) forControlEvents:UIControlEventTouchDown];
    [button addTarget:self action:@selector(setButtonStyleTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
}


-(void) setButtonStyleTouchDown:(UIButton *)button{
    button.layer.backgroundColor = [UIColor grayColor].CGColor;
}


-(void) setButtonStyleTouchUpInside:(UIButton *)button {
    button.layer.backgroundColor = [UIColor whiteColor].CGColor;
}


//descriptionView点击删除时调用此方法
-(void) willDeleteMessge{
    [[[UIAlertView alloc] initWithTitle:@"警告" message:@"你确定要删除整条消费记录吗？" delegate:self cancelButtonTitle:nil otherButtonTitles:@"返回",@"确定删除", nil] show];
}


//descriptionView返回时调用此方法
-(void) descriptionViewHiddenAction {
    [UIView animateWithDuration:0.5 animations:^{
        descriptionView.frame = CGRectMake(20,SelfViewHeight+20, SelfViewWidth-40, SelfViewHeight - 40);
    }];
 
}


- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex  {
    if (buttonIndex == 1) {
        [self DidDeleteMessage];
        [self descriptionViewHiddenAction];
    }

}


-(void) DidDeleteMessage{
    
    int index = (int)subIsSelectionIndexPath.row;
    Model *m1 = subTableViewDateSoure[index];
    [SQLOperation delectWithDate:m1.date];
    
    Model *m2 = linTableViewDateScoure[linIsSelectionIndexPath.row];
    CGFloat count = [m2.money floatValue] - [m1.money floatValue];
    m2.money = [NSString stringWithFormat:@"%.2f",count];
    [linTableViewDateScoure removeObjectAtIndex:linIsSelectionIndexPath.row];
    if (subTableViewDateSoure.count > 1) {
        [linTableViewDateScoure insertObject:m2 atIndex:linIsSelectionIndexPath.row];
    }
    if(subTableViewDateSoure.count > 1)[self setSubTableViewDateSoureWithDate:[selectDate substringWithRange:NSMakeRange(0, 10)]];
    else{
        linIsSelectionIndexPath = nil;
        [subTableViewDateSoure removeObjectAtIndex:0];
        _showView.messageModel = nil;
        [linTableView reloadData];
    }
    
}


//总体布局View
-(void) loadMainSubView{
    
    [self setNavigationItemLeftBarButtonItem];
    
    //添加_showView
    _showView = [[UIMessageView alloc]initWithFrame:CGRectMake(0, 0,SelfViewWidth, showViewHeigth - 10)];
    _showView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_showView];
    
    //添加_buttonView
    _buttonView = [[UIButton alloc] initWithFrame:CGRectMake(0, showViewHeigth, SelfViewHeight, buttonViewHeight)];
    self.buttonView.backgroundColor = [UIColor whiteColor];
    [self addButtonViewSubView];
    [self.view addSubview:_buttonView];
    
    //添加_contentView
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(0,_buttonView.frame.origin.y + _buttonView.frame.size.height, SelfViewWidth,contentViewHeight)];
    [self.view addSubview:_contentView];
}


//为总体布局后的_buttonView添加按钮
-(void) addButtonViewSubView{
    buttonYear = [[UIButton alloc] initWithFrame:CGRectMake(buttonSeparatorWidth,0,buttonWidth, _buttonView.frame.size.height)];
    [buttonYear setTitle:@"年份" forState:0];
    [buttonYear setTitleColor:[UIColor blackColor] forState:0];
    [buttonYear setTitleColor:[UIColor colorWithRed:255/255.0 green:212/255.0 blue:128/255.0 alpha:1] forState:UIControlStateHighlighted];
    [buttonYear addTarget:self action:@selector(buttonYearAction:) forControlEvents:UIControlEventTouchUpInside];
    [_buttonView addSubview:buttonYear];
    
    buttonMonth = [[UIButton alloc] initWithFrame:CGRectMake(buttonSeparatorWidth*2 + buttonWidth, 0, buttonWidth, _buttonView.frame.size.height)];
    [buttonMonth setTitle:@"月份" forState:0];
    [buttonMonth setTitleColor:[UIColor blackColor] forState:0];
    [buttonMonth setTitleColor:[UIColor colorWithRed:255/255.0 green:212/255.0 blue:128/255.0 alpha:1] forState:UIControlStateHighlighted];
    [buttonMonth addTarget:self action:@selector(buttonMonthAction:) forControlEvents:UIControlEventTouchUpInside];
    [_buttonView addSubview:buttonMonth];
    
    buttonDay= [[UIButton alloc] initWithFrame:CGRectMake(buttonSeparatorWidth*3 + buttonWidth*2, 0, buttonWidth, _buttonView.frame.size.height)];
    [buttonDay setTitle:@"天" forState:0];
    [buttonDay setTitleColor:[UIColor blackColor] forState:0];
    [buttonDay setTitleColor:[UIColor colorWithRed:255/255.0 green:212/255.0 blue:128/255.0 alpha:1] forState:UIControlStateHighlighted];
    [buttonDay addTarget:self action:@selector(buttonDayAction:) forControlEvents:UIControlEventTouchUpInside];
    [_buttonView addSubview:buttonDay];
    
    buttonScale = [[UIButton alloc] initWithFrame:CGRectMake(buttonSeparatorWidth*4 + buttonWidth*3, 0, buttonWidth, _buttonView.frame.size.height)];
    [buttonScale setTitle:@"缩放" forState:0];
    buttonScale.titleLabel.font = [UIFont systemFontOfSize:17];
    [buttonScale setTitleColor:[UIColor blackColor] forState:0];
    [buttonScale addTarget:self action:@selector(buttonScaleAction:) forControlEvents:UIControlEventTouchUpInside];
    [_buttonView addSubview:buttonScale];
    
    CGFloat LineLabelHeight = 4;
    lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(buttonWidth*2 + buttonSeparatorWidth*3,_buttonView.frame.size.height-4,buttonWidth, LineLabelHeight)];
    lineLabel.layer.cornerRadius = 2.0F;
    lineLabel.layer.masksToBounds = YES;
    lineLabel.backgroundColor = [UIColor colorWithRed:255/255.0 green:212/255.0 blue:128/255.0 alpha:1];
    [_buttonView addSubview:lineLabel];
}


//为总体布局后的_contentView添加TableView
-(void) addContentViewSubView {
    
    linTableView = [[UITableView alloc] initWithFrame:_contentView.bounds style:UITableViewStylePlain];
    [_contentView addSubview:linTableView];
    linTableView.delegate = self;
    linTableView.dataSource = self;
    [linTableView registerClass:[LinTableViewCell class] forCellReuseIdentifier:@"lin"];
    
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == subTableView) {
        return subTableViewDateSoure.count;
    }
    return linTableViewDateScoure.count;
    
};


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LinTableViewCell *cell;
    if (tableView == subTableView) {
        cell = [self subLinTableViewCellSetUp:tableView cellForRowAtIndexPath:indexPath];
    }
    if (tableView == linTableView) {
        
        cell = [self linLinTableViewCellSetUp:tableView cellForRowAtIndexPath:indexPath];
        
        //取得SubtableView中的数据
        if (indexPath.row == linIsSelectionIndexPath.row && linIsSelectionIndexPath != nil) {
            Model *m = linTableViewDateScoure[indexPath.row];
            selectDate = m.date;
           
            cell.headerImagheVeiw.backgroundColor = [UIColor grayColor];
            

        }else{
            cell.headerImagheVeiw.backgroundColor = [UIColor cyanColor];
        }
        
        //为选中的cell添加SubtableView
        if (indexPath.row == linIsSelectionIndexPath.row && linIsSelectionIndexPath != nil  && subTableViewDateSoure.count > 0) {
            cell.costView.frame = CGRectMake(40, cellHeight, subTableViewCellWidth, isSelectionRowHeight-cellHeight);
            subTableView.frame = CGRectMake(0,0,subTableViewCellWidth, isSelectionRowHeight-cellHeight);
            subTableView.backgroundColor = [UIColor whiteColor];
            subTableView.layer.cornerRadius = 10.f;
            subTableView.layer.masksToBounds = YES;
            subTableView.delegate = self;
            subTableView.dataSource = self;
            [subTableView registerClass:[LinTableViewCell class] forCellReuseIdentifier:@"gan"];
            [cell.costView addSubview:subTableView];
        }
    }
    
    return cell;
}


//使用此方法设置linLinTableViewCell的具体内容
-(LinTableViewCell *) linLinTableViewCellSetUp:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LinTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lin"];
    if (indexPath.row < linTableViewDateScoure.count) {
        Model *M = linTableViewDateScoure[indexPath.row];
        cell.backgroundColor = [UIColor whiteColor];
        cell.layer.cornerRadius = 10.0f;
        cell.layer.masksToBounds = YES;
        cell.layer.borderColor = [UIColor whiteColor].CGColor;
        cell.layer.borderWidth = 0.5f;
        
        //年为单位
        if (flagYear && !flagMoth) {
            cell.typeLabel.textAlignment = NSTextAlignmentLeft;
            cell.typeLabel.frame = CGRectMake(44, 0, 120, 44);
            cell.typeLabel.text = M.date;
            cell.nomeyLabel.text =[NSString stringWithFormat:@"%@:%.2f",moneyType,[M.money floatValue]];
            cell.nomeyLabel.font = [UIFont systemFontOfSize:15];
        }
        //月为单位
        if (flagYear && !flagDay) {
            cell.typeLabel.text = M.date;
            cell.typeLabel.frame = CGRectMake(44, 0, 120, 44);
            cell.nomeyLabel.text = [NSString stringWithFormat:@"%@:%.2f",moneyType,[M.money floatValue]];
            cell.nomeyLabel.font = [UIFont systemFontOfSize:17];
        }
        //天为单位
        if (flagDay) {
            cell.typeLabel.text = M.date;
            cell.typeLabel.frame = CGRectMake(44, 0, 120, 44);
            cell.nomeyLabel.text = [NSString stringWithFormat:@"%@:%.2f",moneyType,[M.money floatValue]];
            cell.nomeyLabel.font = [UIFont systemFontOfSize:17];
        }
    }
    
    return cell;
}


//使用此方法设置subLinTableViewCell的具体内容
-(LinTableViewCell *) subLinTableViewCellSetUp:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LinTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"gan"];

    Model * m;
    if (indexPath.row < subTableViewDateSoure.count) {
       m = subTableViewDateSoure[indexPath.row];
        cell.headerImagheVeiw.layer.cornerRadius = 5.0f;
        cell.headerImagheVeiw.layer.masksToBounds = YES;
        cell.typeLabel .text = m.type;
        cell.dateLabel.text = [m.date substringWithRange:NSMakeRange(0, 10)];
        cell.nomeyLabel.text = [NSString stringWithFormat:@"%@:%.2f",moneyType,[m.money floatValue]];
        cell.nomeyLabel.font = [UIFont systemFontOfSize:15];
        cell.nomeyLabel.frame = CGRectMake(0, 0,subTableView.frame.size.width-10,cellHeight);
        cell.headerImagheVeiw.image = [UIImage imageNamed:[m.typeImageName stringByAppendingString:@"selected"]];
        //颜色提示有备注
        if (m.remark.length >0) {
            cell.nomeyLabel.textColor = [UIColor redColor];
        }else {
            cell.nomeyLabel.textColor = [UIColor blackColor];
        }
    }
   
    cell.layer.cornerRadius = 10.0f;
    cell.layer.masksToBounds = YES;
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}


// 设置单元格的高度
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height;
    if (indexPath.row == linIsSelectionIndexPath.row && tableView == linTableView && linIsSelectionIndexPath != nil &&subTableViewDateSoure.count > 0) {
        [self setIsSelectionRowHeight];
        height = isSelectionRowHeight;
    }else {
        height = cellHeight;
    }
    return height;
}


//linTableView选择状态下的单元格的高度
-(void) setIsSelectionRowHeight{
    CGFloat height = cellHeight * (subTableViewDateSoure.count+1);
    if (height <= _contentView.frame.size.height -44 ) {
        isSelectionRowHeight = height;
    }else {
        isSelectionRowHeight = _contentView.frame.size.height -44;
    }
    if(height > _contentView.frame.size.height  && linTableViewDateScoure.count == 1){
        isSelectionRowHeight = _contentView.frame.size.height;
    }
    
}


//记录linTableView被选中的cell的位置，在此位置插入一个SubTableView
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == linTableView) {
        linIsSelectionIndexPath = indexPath;
        NSArray *array = @[linIsSelectionIndexPath];
        [linTableView reloadRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationAutomatic];
        [linTableView scrollToRowAtIndexPath:linIsSelectionIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
        [self setSubTableViewDateSoureWithDate:selectDate];
        if (subTableViewDateSoure.count > 0) {
            
            [UIView animateWithDuration:0.02 animations:^{
                
            } completion:^(BOOL finished) {

                NSIndexPath *idexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                [subTableView scrollToRowAtIndexPath:idexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
                
                [linTableView scrollToRowAtIndexPath:linIsSelectionIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
            }];
        }
    }
    
    if(tableView == subTableView && subTableViewDateSoure.count > indexPath.row) {
        Model *m = subTableViewDateSoure [indexPath.row];
        subIsSelectionIndexPath = indexPath;
        Model *m1 = linTableViewDateScoure[0];
        if (m1.date.length >= 10) {
            [self setTextToremarkTextLabelOfDescriptionViewWithText:m.remark];
        }
    }
}


//用于描述某一条详细信息
-(void) setTextToremarkTextLabelOfDescriptionViewWithText:(NSString *)string {
    
    descriptionView.hidden = NO;
    string = [@"备注：\n" stringByAppendingString:string];
    CGRect rect = [string boundingRectWithSize:CGSizeMake(descriptionView.frame.size.width- 15,buttonMarginToTopOfDescriptionView - 10) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
    remarkTextLabel.frame = CGRectMake(10,10, rect.size.width, rect.size.height);
    remarkTextLabel.numberOfLines = 0;
    remarkTextLabel.text = string;
    remarkTextLabel.textColor = [UIColor blackColor];
    
    [UIView animateWithDuration:0.5 animations:^{
        descriptionView.frame = CGRectMake(20,20, SelfViewWidth-40, SelfViewHeight - 40);
    }];
}


// 设置SubTableViewDateSoure给SubTableView显示
-(void) setSubTableViewDateSoureWithDate:(NSString *)dateStr {
    typeArray = [NSMutableArray arrayWithCapacity:15];
    consumeArray = [NSMutableArray arrayWithCapacity:15];
    subTableViewDateSoure = [NSMutableArray array];
    BOOL flag = NO;
    NSArray *myarray = @[@"烟酒",@"购书",@"话费",@"衣服",@"食品",@"游戏",@"房费",@"收入",@"保险",@"电影",@"其他",@"超市",@"车费",@"旅行",@"水电煤"];
    for (int i = 0; i < types.count; i++ ) {
        NSArray *array = [SQLOperation findModelFromDate:dateStr Type:myarray[i]];
        
        Model *m1;
        Model *m2;
        CGFloat count = 0.0;
        
        if (array.count > 0) {
            m1 = array[0];
            [typeArray addObject:myarray[i]];
            self.title = [dateStr stringByAppendingString:@"类型消费图"];
            flag = YES;
        }
        if(dateStr.length < 10){
            for (int j = 1; j < array.count; j++) {
                m2 = array[j];
                NSInteger money;
                money = [m1.money integerValue] + [m2.money integerValue];
                m1.money = [NSString stringWithFormat:@"%ld",(long)money];
                m1.date = [self returnRecentlyCompareDate:m1.date WithDateString:m2.date];
            }
            if (array.count > 0) {
                m1.type = myarray[i];
                [consumeArray addObject:[NSNumber numberWithFloat:[m1.money floatValue]]];
                [subTableViewDateSoure addObject:m1];
                [linTableView reloadData];
                [subTableView reloadData];
                
            }
        }else{
            if (array.count > 0) {
                for (int j = 0; j < array.count;j ++) {
                    Model *m = array[j];
                    m.type = myarray[i];
                    count = count + [m.money floatValue];
                    [subTableViewDateSoure addObject:m];
                }
                [consumeArray addObject:[NSNumber numberWithFloat:count]];
                [linTableView reloadData];
                [subTableView reloadData];
            }
            
        
        }
        if (i == 7 && array.count > 0) {
            
            [typeArray removeLastObject];
            [consumeArray removeLastObject];
        }
        
    }
    if (flag) {
        [self setShowViewDateSource];
    }
}


//设置ShowView的数据
-(void) setShowViewDateSource {
    if (subTableViewDateSoure.count > 0) {
        MessageModel *model = [[MessageModel alloc] init];
        model.consumeArray = consumeArray;
        model.typeArray = typeArray;
        model.currentBalanceMoney = [consumeArray[0] floatValue];
        for (int  i = 1; i < consumeArray.count; i++) {
            model.currentBalanceMoney  = model.currentBalanceMoney + [consumeArray[i] floatValue];
        }
        model.colorsArray = [ColorTool colorArrayWithCapicity:consumeArray.count];
        _showView.messageModel = model;
        
    }
}
//找到该类型的最新账目
-(NSString *) returnRecentlyCompareDate:(NSString *)dateStr1 WithDateString:(NSString *)dateStr2 {
    
    NSString *dateStr;
    NSString *string1;
    NSString *string2;
    if (dateStr1.length > 10) {
        string1 = [dateStr1 substringWithRange:NSMakeRange(0, 10)];
    }
    if (dateStr2.length > 10) {
        string2 = [dateStr1 substringWithRange:NSMakeRange(0, 10)];
    }
    switch ([dateStr1 compare:dateStr2 options:NSLiteralSearch]) {
        case NSOrderedAscending:
            dateStr = dateStr2;
            break;
        case NSOrderedSame:
            dateStr = dateStr2;
            break;
        case NSOrderedDescending:
            dateStr = dateStr1;
            break;
        default:
            break;
    }
    return dateStr;
    
}


//点击“年”事件
-(void) buttonYearAction:(UIButton *)sender {
    
    [self animationOfLineLabelToFrame:CGRectMake(sender.frame.origin.x, _buttonView.frame.size.height - 4, sender.frame.size.width, 4)];
    linIsSelectionIndexPath = nil;
    [subTableView removeFromSuperview];
    flagYear = YES;
    flagMoth = NO;
    flagDay = NO;
    linTableViewDateScoure = [self findAggregateYearCountArrayMenberIsModel];
    [linTableView reloadData];
}


// 找到所有年份的总账，返回数组，数组中装的是Model。
-(NSMutableArray *) findAggregateYearCountArrayMenberIsModel{
    
    NSMutableArray *array = [NSMutableArray array];
    NSInteger yearInt = 2015;
    NSInteger nowYearInt = [[self nowDateYear] integerValue];
    for (NSInteger i = yearInt-1; i < nowYearInt;) {
        i++;
        Model *m = [Model new];
        m.date = [NSString stringWithFormat:@"%lu",(long)i];
        m.money =[NSString stringWithFormat:@"%f",[self aggregateDate:m.date]];
        if (findDateNil != [m.money intValue]) {
            [array addObject:m];
        }
    }
    return array;
}


// 求某日期之内的总账
-(NSMutableArray *)findAggregateDateCountArrayMenberIsModel{
    
    NSMutableArray *array = [NSMutableArray array];
    NSInteger month = [dataString integerValue] *100;
    NSInteger monthMax = month + 31;
    for (NSInteger i = month; i < monthMax;) {
        i++;
        NSString *date;
        if( i- month >= 10 ){
            date = [dataString stringByAppendingFormat:@"-%lu",(long)(i - month)];
        }else{
            date = [dataString stringByAppendingFormat:@"-0%lu",(long)(i - month)];
        }
        Model *m = [Model new];
        m.date = date;
        m.money =[NSString stringWithFormat:@"%f",[self aggregateDate:m.date]];
        if (findDateNil != [m.money intValue]) {
            [array addObject:m];
        }
    }
    return array;
    
}


//根据日期（年、月、日）求总账
-(CGFloat) aggregateDate:(NSString *)dateStr {
    
    CGFloat money = 0.0;
    NSArray *array = [SQLOperation findModelFromDate:dateStr];
    if (array.count == 0) {
        return findDateNil;
    }
    for (int i = 0; i < array.count; i++) {
        Model *m = array[i];
        money =money + [m.money floatValue];
        moneyType = m.moneyType;
    }
    return money;
    
}


//根据日期（年、月、日）和消费类型求总账
-(CGFloat) findMoneyCountOfDate:(NSString *)dateStr Type:(NSString *)type{
    
    CGFloat money = 0.0;
    NSArray *array = [SQLOperation findModelFromDate:dateStr Type:type];
    for (int i = 0; i < array.count; i++) {
        Model *m = array[i];
        money =money + [m.money floatValue];
    }
    return money;
    
}


//点击“月”事件
-(void) buttonMonthAction:(UIButton *)sender {

    [self animationOfLineLabelToFrame:CGRectMake(sender.frame.origin.x, _buttonView.frame.size.height - 4, sender.frame.size.width, 4)];
    [subTableView removeFromSuperview];
    linIsSelectionIndexPath = nil;
    dataString = [selectDate substringWithRange:NSMakeRange(0, 4)];
    flagMoth = YES;
    flagDay = NO;
   linTableViewDateScoure = [self findAggregateDateCountArrayMenberIsModel];
    [linTableView reloadData];
    
}


//进入账本是显示的tableView
-(void) showMonth {
    
    flagMoth = YES;
    flagDay = NO;
    linTableViewDateScoure = [self findAggregateDateCountArrayMenberIsModel];
    [linTableView reloadData];
    [self setSubTableViewDateSoureWithDate:[self nowDateMonth]];
    
}



//点击“日”事件
-(void) buttonDayAction:(UIButton *)sender {

    [self animationOfLineLabelToFrame:CGRectMake(sender.frame.origin.x, _buttonView.frame.size.height - 4, sender.frame.size.width, 4)];
    [subTableView removeFromSuperview];
    linIsSelectionIndexPath = nil;
    flagDay = YES;

    if(selectDate.length == 7)dataString = [selectDate substringWithRange:NSMakeRange(0, 7)];
    else dataString = [self nowDateMonth];
    linTableViewDateScoure = [self findAggregateDateCountArrayMenberIsModel];
    [linTableView reloadData];
    
}


//扩大/缩小
-(void) buttonScaleAction:(UIButton *)sender {
    CGFloat height = SelfViewHeight-buttonViewHeight;
    if (cellHeight * linTableViewDateScoure.count < height) {
        height = cellHeight * linTableViewDateScoure.count;
    }
    if (!flagScale) {
        [buttonScale setTitleColor:[UIColor colorWithRed:255/255.0 green:212/255.0 blue:128/255.0 alpha:1] forState:0];
        [UIView animateWithDuration:0.5 animations:^{
           
            _buttonView.frame = CGRectMake(0, SelfViewHeight - height - buttonViewHeight, SelfViewWidth, buttonViewHeight);
            _contentView.frame = CGRectMake(0,_buttonView.frame.origin.y + buttonViewHeight, SelfViewWidth,height);
            linTableView.frame = _contentView.bounds;
            [linTableView reloadData];
        }];
    } if(flagScale){
        [buttonScale setTitleColor:[UIColor blackColor] forState:0];
        [self animationOfTableView];
    }
    flagScale = !flagScale;
    
}

-(void) animationOfTableView{
    [UIView animateWithDuration:0.5 animations:^{
        _buttonView.frame = CGRectMake(0, showViewHeigth , self.view.frame.size.width, buttonViewHeight);
        _contentView.frame =CGRectMake(0,_buttonView.frame.origin.y + _buttonView.frame.size.height, SelfViewWidth,contentViewHeight);
        linTableView.frame = _contentView.bounds;
        [linTableView reloadData];
        
    }];
}

//lineLabel移动动画
-(void) animationOfLineLabelToFrame:(CGRect)frame{
    
    [UIView animateWithDuration:0.25 animations:^{
        lineLabel.frame = frame;
    } completion:^(BOOL finished) {
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
