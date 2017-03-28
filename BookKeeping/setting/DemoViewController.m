
#import "DemoViewController.h"

#import "SupportViewController.h"
#import "CurrentReferViewController.h"
#import "AboutViewController.h"
#import "PasswordViewController.h"
#import "ModifyViewController.h"
#define MOENY  @"money"
#define BUDGET @"budget"
#define LAOSHUAIGE @"laoshuaige"
#define PASSWORD @"password"
@interface DemoViewController ()<UITableViewDataSource,UITableViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,password>
{   UISwitch *_switch;
    NSMutableArray *dataSource;
    NSArray *money;
    NSArray *budGet;
    UIPickerView *chooseType;
    UITableView *table;
    UIView *view;
    UILabel *moneyLabel;
    UILabel *budgetLabel;
    BOOL flag;

}
@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"设置";
    self.view.backgroundColor=[UIColor whiteColor];
    //初始化部分全局变量
    dataSource=[NSMutableArray array];
    //[self switchWithFrame:CGRectMake(Screen_Width-60-70, 10, 51, 31) LocalKey:SwitchKey];此方法在下方，用来初始化_switch单例；它的大小固定；
    _switch=[self switchWithFrame:CGRectMake(Screen_Width-60-70, 10, 51, 31) LocalKey:SwitchKey];
    [_switch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    //添加数据到dataSource
    {
    [dataSource addObject:@"货币"];
    [dataSource addObject:@"密码口令"];
        if (_switch.on==YES) {
            [dataSource addObject:@"修改密码"];
        }
    [dataSource addObject:@"预算"];
    [dataSource addObject:@[@"支持",@"汇率查询",@"关于"]];
    }
    
    //初始化table并且设置代理
    table=[[UITableView alloc]initWithFrame:CGRectMake(30, 0, self.view.frame.size.width-60, self.view.frame.size.height) style:UITableViewStyleGrouped];
    [self.view addSubview:table];
    table.dataSource=self;
    table.delegate=self;
    table.rowHeight=50;
    table.showsVerticalScrollIndicator=NO;
    table.backgroundColor=[UIColor whiteColor];
    /*------------------------------------------------------------------------------*/

    [table registerClass:[UITableViewCell class] forCellReuseIdentifier:PASSWORD];

  //初始化一个view，用来装chooseType和toolBar，只要隐藏view就可以两个都隐藏chooseType和toolBar大小是固定的；
    //下面就是初始化chooseType和toolBar；
    {
        view =[[UIView alloc]initWithFrame:CGRectMake(0, Screen_Height-216-49, Screen_Width, 49+216)];
        [self.view addSubview:view];
        view.hidden=YES;
        view.backgroundColor=[UIColor clearColor];
        UIToolbar *toolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 216, Screen_Width, 49)];
        [view addSubview:toolBar];
        
        NSArray * item=@[@(UIBarButtonSystemItemFlexibleSpace),@(UIBarButtonSystemItemDone),@(UIBarButtonSystemItemFlexibleSpace),@(UIBarButtonSystemItemCancel),@(UIBarButtonSystemItemFlexibleSpace)];
        NSMutableArray *systemItem=[NSMutableArray array];
        for (int i=0;i<5; i++) {
            UIBarButtonItem *barItem;
            if (i==1) {
                barItem=[[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelAction:)];

            }else if(i==3){
                 barItem=[[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(sureAction:)];

            }else{
            barItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:[item[i]  integerValue]target:self action:nil];
            }
            
            [systemItem addObject:barItem];
        }
        
        toolBar.items=systemItem;
      

    }
    
    //获取plist数据
    {
        chooseType =[[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 216)];
        chooseType.backgroundColor=[UIColor whiteColor];
        NSString *moneyPlistFile=[[NSBundle mainBundle]pathForResource:@"laoshuaige" ofType:@"plist"];
        money=[NSArray arrayWithContentsOfFile:moneyPlistFile ];
        NSString *budGetPlistFile=[[NSBundle mainBundle]pathForResource:@"budget" ofType:@"plist"];
        budGet=[NSArray arrayWithContentsOfFile:budGetPlistFile ];
        chooseType.delegate=self;
        chooseType.dataSource=self;
        [view addSubview:chooseType];
        flag=NO;
    }
    
    [self leftBackButtonLayout];
    
}

#pragma mark ----------------------------
-(void)leftBackButtonLayout
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0,20,20);
    [button setImage:[UIImage imageNamed:@"back128"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBarButton = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = backBarButton ;
}

-(void)backAction:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark-------UIPickerView-----------
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return money.count;
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}


-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (flag==NO) {
         return money[row];
    }else{
        return budGet[row];
    }
   
}
//-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
//    lable.text=money[row];
//}

#pragma mark-------------
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    if (_switch.on==NO) {
        if (indexPath.section==3) {
            
            cell=[tableView dequeueReusableCellWithIdentifier:PASSWORD forIndexPath:indexPath];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
        else if (indexPath.section==0) {
            cell=[tableView dequeueReusableCellWithIdentifier:PASSWORD forIndexPath:indexPath];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
         moneyLabel=[self labelWithFrame:CGRectMake(Screen_Width-60-130, 10, 100, 30) LocalKey:MOENY];
            moneyLabel.textAlignment=NSTextAlignmentRight;
             [cell addSubview:moneyLabel];
            
        }else if (indexPath.section==2) {
            cell=[tableView dequeueReusableCellWithIdentifier:PASSWORD forIndexPath:indexPath];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            budgetLabel=[self labelWithFrame:CGRectMake(Screen_Width-60-120, 10, 90, 30) LocalKey:BUDGET];
             budgetLabel.textAlignment=NSTextAlignmentRight;
            [cell addSubview:budgetLabel];
            
        }
        else if(indexPath.section==1){
            cell=[tableView dequeueReusableCellWithIdentifier:PASSWORD forIndexPath:indexPath];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.accessoryType=UITableViewCellAccessoryNone;
            _switch=[self switchWithFrame:CGRectMake(Screen_Width-60-70, 10, 51, 31) LocalKey:SwitchKey];
            [_switch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
            [cell addSubview:_switch];
        }
        if (indexPath.section==3) {
            cell.textLabel.text=dataSource[3][indexPath.row];
        }else{
            cell.textLabel.text=dataSource[indexPath.section];
            
        }

    }else{
        if (indexPath.section==4) {
            
            cell=[tableView dequeueReusableCellWithIdentifier:PASSWORD forIndexPath:indexPath];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
        else if (indexPath.section==2) {
            cell=[tableView dequeueReusableCellWithIdentifier:PASSWORD forIndexPath:indexPath];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            
        } else if (indexPath.section==0) {
            cell=[tableView dequeueReusableCellWithIdentifier:PASSWORD forIndexPath:indexPath];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            moneyLabel=[self labelWithFrame:CGRectMake(Screen_Width-60-130, 10, 100, 30) LocalKey:MOENY];
             moneyLabel.textAlignment=NSTextAlignmentRight;
            [cell addSubview:moneyLabel];
            
        } else if (indexPath.section==3) {
            cell=[tableView dequeueReusableCellWithIdentifier:PASSWORD forIndexPath:indexPath];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            budgetLabel=[self labelWithFrame:CGRectMake(Screen_Width-60-120, 10, 90, 30) LocalKey:BUDGET];
             budgetLabel.textAlignment=NSTextAlignmentRight;
            [cell addSubview:budgetLabel];

            
        }
        else if(indexPath.section==1){
            cell=[tableView dequeueReusableCellWithIdentifier:PASSWORD forIndexPath:indexPath];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.accessoryType=UITableViewCellAccessoryNone;
            _switch=[self switchWithFrame:CGRectMake(Screen_Width-60-70, 10, 51, 31) LocalKey:SwitchKey];
            [_switch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
            [cell addSubview:_switch];
        }
        if (indexPath.section==4) {
            cell.textLabel.text=dataSource[4][indexPath.row];
        }else{
            cell.textLabel.text=dataSource[indexPath.section];     
        }
    }
    
 
    cell.backgroundColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0  alpha:1];
    cell.layer.cornerRadius=5;
    cell.layer.borderColor=[UIColor blackColor].CGColor;
    cell.layer.borderWidth=1;
    cell.layer.masksToBounds=YES;
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [formatter stringFromDate:date];
    dateString = [dateString substringToIndex:7];
    
    NSArray *array = [SQLOperation findModelFromDate:dateString];
    float count = 0 ;
    for (int i = 0 ; i < array.count; i++)
    {
        Model *model = array[i];
        if ([model.type isEqualToString:@"收入"])
        {
            continue ;
        }
        count += [model.money floatValue];
    }
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:SwitchKey] boolValue]) {
        if (indexPath.section==3) {
            if ([[[NSUserDefaults standardUserDefaults] valueForKey:BUDGET] floatValue]<count) {
                cell.layer.borderColor=[UIColor redColor].CGColor;
            }
        }
    }else{
        if (indexPath.section==2) {
            if ([[[NSUserDefaults standardUserDefaults] valueForKey:BUDGET]floatValue ]<count) {
                cell.layer.borderColor=[UIColor redColor].CGColor;
            }
        }
    }

    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    int num=1;
    if (_switch.on==NO) {
        switch (section) {
            case 3:
//                NSLog(@"4");
                num=3;
                break;
            default:
                break;
        }

    }else{
        switch (section) {
            case 4:
                num=3;
                break;
            default:
                break;
        }
    }
    
    return num;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_switch.on==NO) {
        return 4;
    }else{
        return 5;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    view.hidden=YES;
     [tableView reloadData];
    if (_switch.on==NO) {
        switch (indexPath.section) {
            case 0:
                flag=NO;
                [chooseType reloadAllComponents];
                
                
//                NSLog(@"进入界面Currency");
                view.hidden=NO;
                break;
            case 1:
            {
//                NSLog(@"switch");
            }
                break;
            case 2:
//                NSLog(@"进入界面Budget");
                flag=YES;
                [chooseType reloadAllComponents];
                view.hidden=NO;
                break;
            case 3:
            {
                switch (indexPath.row) {
                    case 0:
                    {
                        SupportViewController *suppor=[[SupportViewController alloc]init];
                        suppor.title=@"支持";
                        [self.navigationController pushViewController:suppor animated:YES];
//                        NSLog(@"进入界面Support");
                    }
                        break;
                    case 1:{
                        CurrentReferViewController *currentReferViewController = [[CurrentReferViewController alloc]initWithNibName:@"CurrentReferViewController" bundle:nil];
                        [self.navigationController pushViewController:currentReferViewController animated:YES];
//                        NSLog(@"进入界面Rate");
                    }
                        break;
                    case 2:{
                        AboutViewController *about=[[AboutViewController alloc]init];
                        about.title=@"关于";
                        [self.navigationController pushViewController:about animated:YES];
//                        NSLog(@"进入界面About");
                    }
                        break;
                }
                
                
            }
                break;
                
            default:
                break;
        }

    }else{
        
        switch (indexPath.section) {
            case 0:
                flag=NO;
                [chooseType reloadAllComponents];
//                NSLog(@"进入界面Currency");
                view.hidden=NO;
                break;
            case 1:
//                NSLog(@"switch");
                break;
            case 2:
            {
                ModifyViewController *modify=[[ModifyViewController alloc]init];
                modify.title=@"修改密码";
                modify.flag=_switch.on;
                [self.navigationController pushViewController:modify animated:YES];
                break;
            }
            case 3:
//                NSLog(@"进入界面Budget");
                flag=YES;
                [chooseType reloadAllComponents];
                view.hidden=NO;
                break;
            case 4:
            {
                switch (indexPath.row) {
                    case 0:
                    {
                        SupportViewController *suppor=[[SupportViewController alloc]init];
                        suppor.title=@"Support";
                        [self.navigationController pushViewController:suppor animated:YES];
//                        NSLog(@"进入界面Support");
                    }
                        break;
                    case 1:{
                        CurrentReferViewController *currentReferViewController = [[CurrentReferViewController alloc]initWithNibName:@"CurrentReferViewController" bundle:nil];
                        [self.navigationController pushViewController:currentReferViewController animated:YES];
//                        NSLog(@"进入界面Rate");
                    }
                        break;
                    case 2:{
                        AboutViewController *about=[[AboutViewController alloc]init];
                        about.title=@"About";
                        [self.navigationController pushViewController:about animated:YES];
//                        NSLog(@"进入界面About");
                    }
                        break;
                }
                
                
            }
                break;
                
            default:
                break;
        }

    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 20;
}- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*------------        UISwitch    -----------------*/

-(id)switchWithFrame:(CGRect)frame LocalKey:(NSString *)key{
    if (_switch==nil) {
        _switch=[[UISwitch alloc]initWithFrame:frame];
        id value = [[NSUserDefaults standardUserDefaults] valueForKey:SwitchKey];
       
        if (value == nil) {
             /*---------------------------*/
            _switch.on = NO;
            [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithBool:_switch.on] forKey:SwitchKey];
            [[NSUserDefaults standardUserDefaults] synchronize];

        }else{
            _switch.on = [value boolValue];
        }
    }
           return _switch;
}

-(void)switchAction:(UISwitch *)sender{
    view.hidden=YES;
    _switch.on=!_switch.on;
    PasswordViewController *pass=[[PasswordViewController alloc]init];
    pass.try=_switch.on;
    pass.delegade=self;
    [self.navigationController pushViewController:pass animated:YES ];
}

//view中按钮的方法
-(void)cancelAction:(UIBarButtonItem *)sender{
    view.hidden=YES;
    
}
-(void)sureAction:(UIBarButtonItem *)sender{
    view.hidden=YES;
    if (flag ==NO) {
        moneyLabel.text=money[([chooseType selectedRowInComponent:0])];
        [[NSUserDefaults standardUserDefaults] setValue:money[([chooseType selectedRowInComponent:0])] forKey:MOENY];
        [[NSUserDefaults standardUserDefaults] synchronize];

        //block传值,回传money类型
        self.moneyTransValueBlock(moneyLabel.text);
        
    }else{
        budgetLabel.text=budGet[([chooseType selectedRowInComponent:0])];
        [[NSUserDefaults standardUserDefaults] setValue:budGet[([chooseType selectedRowInComponent:0])] forKey:BUDGET];
        [[NSUserDefaults standardUserDefaults] synchronize];

        //block传值,回传预算值
        self.budgetTransValueBlock(budgetLabel.text);
        
    }
    [table reloadData];
}
/*-------------------创建label------------------------------*/
-(UILabel *)labelWithFrame:(CGRect)frame LocalKey:(NSString *)key{
    UILabel *label;
    if ([key isEqualToString:MOENY]) {
        if (moneyLabel==nil) {
            label=[[UILabel alloc]initWithFrame:frame];
            
            NSMutableString *mstring=[[NSUserDefaults standardUserDefaults] valueForKey:MOENY];
            if (mstring==nil) {
                label.text=@"人民币";
                [[NSUserDefaults standardUserDefaults] setValue:label.text forKey:MOENY];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }else{
                label.text=[[NSUserDefaults standardUserDefaults]valueForKey:MOENY];
            }
        }
        else{
          moneyLabel.text=[[NSUserDefaults standardUserDefaults]valueForKey:MOENY];
            return moneyLabel;
        }
       
    }
    else if([key isEqualToString:BUDGET]){
        if (budgetLabel==nil) {
            label=[[UILabel alloc]initWithFrame:frame];
            NSMutableString *mstring=[[NSUserDefaults standardUserDefaults] valueForKey:BUDGET];
            if (mstring==nil) {
                label.text=@"800";
                [[NSUserDefaults standardUserDefaults] setValue:label.text forKey:BUDGET];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }else{
                label.text=[[NSUserDefaults standardUserDefaults]valueForKey:BUDGET];
            }
        }
        else{
        budgetLabel.text=[[NSUserDefaults standardUserDefaults]valueForKey:BUDGET];
            return budgetLabel;
        }
    }
  
    return label;
}

-(void)try:(BOOL)tryfalg{
    _switch.on=tryfalg;
    if (tryfalg) {
        [dataSource insertObject:@"修改密码" atIndex:2];
    }else{
        [dataSource removeObjectAtIndex:2];
    
    }
    [table reloadData];
}

/*-----      新加的---------------*/
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    view.hidden=YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
