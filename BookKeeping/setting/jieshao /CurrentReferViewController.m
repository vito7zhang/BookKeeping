//
//  CurrentReferViewController.m
//  test_demo
//
//  Created by ibokan on 15/9/28.
//  Copyright (c) 2015年 rick. All rights reserved.
//

#import "CurrentReferViewController.h"
#import "ExchangeRateModel.h"

@interface CurrentReferViewController ()<UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate>
{
    NSArray *dataSource ;
    NSMutableArray *fromCurrency ;
    NSMutableArray *toCurrency ;
    NSMutableArray *modelArray ;
}
@end

@implementation CurrentReferViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"汇率查询";
    
    fromCurrency = [NSMutableArray arrayWithObject:@"AUD"];
    toCurrency = [NSMutableArray arrayWithObject:@"AUD"];
    modelArray = [NSMutableArray array];

    _inputTextField.delegate = self ;
    
    NSString *plistList = [[NSBundle mainBundle] pathForResource:@"ExchangeRateList" ofType:@"plist"];
    _firstPickView.dataSource = self ;
    _firstPickView.delegate =self ;
    _secondPickVIew.dataSource = self ;
    _secondPickVIew.delegate = self ;
    dataSource = [NSArray arrayWithContentsOfFile:plistList];

    [_showLabel setFont:[UIFont fontWithName:@"American Typewriter" size:20]];
    _showLabel.textColor = [UIColor grayColor];
    
    [_currentRateLabel setFont:[UIFont fontWithName:@"American Typewriter" size:20]];
    _currentRateLabel.textColor = [UIColor grayColor];
 
    _searchButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [_searchButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"back128"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0,20,20);
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem ;
    
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return dataSource.count ;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return dataSource[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
 
    NSRange range = [dataSource[row] rangeOfString:@"("];
    
    NSString *EnglishName = [dataSource[row] substringFromIndex:range.location+1];
    EnglishName = [EnglishName substringToIndex:EnglishName.length-1];
    if (pickerView == _firstPickView )
    {
        [fromCurrency addObject:EnglishName];
    }
    else
    {
        [toCurrency addObject:EnglishName];
    }

}

#pragma mark -----------点击button响应方法--------------------

- (IBAction)searchAction:(UIButton *)sender
{
    NSString *amountString = _inputTextField.text ;
    NSString *fromCurrentcyString = [fromCurrency lastObject];
    NSString *toCurrentString = [toCurrency lastObject];
    
    if (_inputTextField.text.length == 0)
    {
        [[[UIAlertView alloc]initWithTitle:@"提示" message:@"请您输入要查询的数额" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        return ;
    }
    
    NSString *httpUrl = @"http://apis.baidu.com/apistore/currencyservice/currency";
    NSString *httpArg = [NSString stringWithFormat:@"fromCurrency=%@&toCurrency=%@&amount=%@",fromCurrentcyString,toCurrentString,amountString];
    [self request: httpUrl withHttpArg: httpArg];

}

-(void)backAction:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -----------------------------------

-(void)request: (NSString*)httpUrl withHttpArg: (NSString*)HttpArg  {
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, HttpArg];
    NSURL *url = [NSURL URLWithString: urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
    [request setHTTPMethod: @"GET"];
    [request addValue: @" 3e1bff0b9c611d667569f8baf86c0d09" forHTTPHeaderField: @"apikey"];
    [NSURLConnection sendAsynchronousRequest: request
                                       queue: [NSOperationQueue mainQueue]
                           completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error){
                               if (error) {
                                   [[[UIAlertView alloc]initWithTitle:@"提示" message:@"查询失败" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
                                   
                               } else {
                                   NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                   NSDictionary *dictionary = dic[@"retData"];
                                   
                                   if (dictionary.count == 0)
                                   {
                                       [[[UIAlertView alloc]initWithTitle:@"提示" message:@"查询失败" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
                                   }
 
                                   ExchangeRateModel *model = [[ExchangeRateModel alloc]initWithDictionary:dictionary];
                                   [modelArray addObject:model];
                                   
                                   CGFloat convertedamountFloat = [model.convertedamount floatValue];
                                   CGFloat currentcyFloat = [model.currency floatValue];
                                   
                                   _showLabel.text = [NSString stringWithFormat:@"%.4f",convertedamountFloat];
                                   _currentRateLabel.text = [NSString stringWithFormat:@"%.4f",currentcyFloat];
                               }
                           }];
}

#pragma mark -----------------
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_inputTextField resignFirstResponder];
}

#pragma mark ------------------
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_inputTextField resignFirstResponder];
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
