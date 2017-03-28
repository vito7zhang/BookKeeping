//
//  WriteViewController.m
//  BookKeeping
//
//  Created by ibokan on 15/9/23.
//  Copyright (c) 2015年 rick. All rights reserved.
//

#import "WriteViewController.h"

@interface WriteViewController () <UITextViewDelegate,UIAlertViewDelegate>
{
    UITextView *_textView ;
    UITextField *textField;
    UIView *chooseBarView;
}

@end

@implementation WriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"编辑";
    [self backgroundImageViewLayout];
    [self leftBackButtonLayout];
    [self textViewLayout];
    [self textFieldLayout];
    [self chooseBarViewLayout];
    
    
    //键盘的升降
    [[NSNotificationCenter  defaultCenter]addObserver:self selector:@selector(keyboardWillShowAction:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
    [_textView becomeFirstResponder];
    
}

-(void)leftBackButtonLayout
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 20, 20);
    [button setImage:[UIImage imageNamed:@"back128"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backBarButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBarButton = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = backBarButton ;
}

-(void)backBarButtonAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)backgroundImageViewLayout
{
    //    UIImageView *backgroundImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"writeBackground128"]];
    //goldBackground
    UIImageView *backgroundImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"goldBackground"]];
    [self.view addSubview:backgroundImageView];
    
    backgroundImageView.translatesAutoresizingMaskIntoConstraints = NO ;
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:backgroundImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
    [self.view addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:backgroundImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:1 constant:0];
    [self.view addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:backgroundImageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    [self.view addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:backgroundImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    [self.view addConstraint:constraint];
    
}

-(void)textViewLayout
{
    _textView = [[UITextView alloc]init];
    _textView.font = [UIFont fontWithName:@"American Typewriter" size:20];
    _textView.backgroundColor = [UIColor clearColor];
    _textView.delegate = self ;
    
    [self.view addSubview:_textView];
    
    //布局
    _textView.translatesAutoresizingMaskIntoConstraints = NO ;
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:_textView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:Screen_Width];
    [self.view addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:_textView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:Screen_Height-64];
    [self.view addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:_textView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:64];
    [self.view addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:_textView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    [self.view addConstraint:constraint];
    
    
}

-(void)textFieldLayout
{
    textField = [[UITextField alloc]init];
    textField.placeholder = @"请输入记录...";
    textField.font = [UIFont fontWithName:@"American Typewriter" size:20];
    textField.frame = CGRectMake(3, 68, Screen_Width, 30);
    [self.view addSubview:textField];
}

-(void)chooseBarViewLayout
{
    chooseBarView = [[UIView alloc]initWithFrame:CGRectMake(0, Screen_Height-44, Screen_Width, 44)];
    chooseBarView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:chooseBarView];
    
    UIButton *conformsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [conformsButton setTitle:@"确定" forState:UIControlStateNormal];
    conformsButton.titleLabel.font = [UIFont fontWithName:@"American Typewriter" size:20];
    conformsButton.titleLabel.textColor = [UIColor whiteColor];
    conformsButton.layer.cornerRadius = 5 ;
    conformsButton.layer.masksToBounds = YES ;
    conformsButton.backgroundColor = [UIColor lightGrayColor];
    [conformsButton addTarget:self action:@selector(conformsButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [chooseBarView addSubview:conformsButton];
    
    conformsButton.translatesAutoresizingMaskIntoConstraints = NO ;
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:conformsButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:Screen_Width/2-10];
    [self.view addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:conformsButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:chooseBarView attribute:NSLayoutAttributeHeight multiplier:1 constant:-5];
    [self.view addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:conformsButton attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:chooseBarView attribute:NSLayoutAttributeLeading multiplier:1 constant:7.5];
    [self.view addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:conformsButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:chooseBarView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    [self.view addConstraint:constraint];
    
    
    UIButton *delectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [delectButton setTitle:@"取消" forState:UIControlStateNormal];
    delectButton.titleLabel.font = [UIFont fontWithName:@"American Typewriter" size:20];
    delectButton.titleLabel.textColor = [UIColor whiteColor];
    delectButton.layer.cornerRadius = 5 ;
    delectButton.layer.masksToBounds = YES ;
    delectButton.backgroundColor = [UIColor lightGrayColor];
    [delectButton addTarget:self action:@selector(delectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [chooseBarView addSubview:delectButton];
    
    delectButton.translatesAutoresizingMaskIntoConstraints = NO ;
    constraint = [NSLayoutConstraint constraintWithItem:delectButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:Screen_Width/2-10];
    [self.view addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:delectButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:chooseBarView attribute:NSLayoutAttributeHeight multiplier:1 constant:-5];
    [self.view addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:delectButton attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:chooseBarView attribute:NSLayoutAttributeTrailing multiplier:1 constant:-7.5];
    [self.view addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:delectButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:chooseBarView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    [self.view addConstraint:constraint];
    
    
}

#pragma mark -----------键盘升降方法--------------------
-(void)keyboardWillShowAction:(NSNotification *)sender
{
    /*
     UIKeyboardFrameBeginUserInfoKey
     UIKeyboardFrameEndUserInfoKey
     */
    CGRect keyboardFrameEndUserInfoKey = [[[sender userInfo] objectForKey:@"UIKeyboardFrameEndUserInfoKey"]CGRectValue];
    [UIView animateWithDuration:0.25 animations:^{
        chooseBarView.frame = CGRectMake(0,keyboardFrameEndUserInfoKey.origin.y - 44 , chooseBarView.frame.size.width, chooseBarView.frame.size.height);
    }];
    
    
}

-(void)keyboardWillHideNotification:(NSNotification *)sender
{
    
//    CGRect keyboardFrameBeginUserInfoKey = [[sender.userInfo objectForKey:@"UIKeyboardFrameBeginUserInfoKey"] CGRectValue];
//    CGRect keyboardFrameEndUserInfoKey = [[sender.userInfo objectForKey:@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
//    CGFloat height = keyboardFrameBeginUserInfoKey.origin.y - keyboardFrameEndUserInfoKey.origin.y ;
//    NSLog(@"%f",height);
    [UIView animateWithDuration:0.25 animations:^{
        chooseBarView.frame = CGRectMake(0,Screen_Height-44, chooseBarView.frame.size.width, chooseBarView.frame.size.height);
    }];
    
}

#pragma mark ---------textView的代理方法-----------
-(void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length != 0)
    {
        textField.hidden = YES ;
    }
    else
    {
        textField.hidden = NO ;
    }
}


-(void)conformsButtonAction:(UIButton *)sender
{
    //IOS9中方法需更改
    UIAlertView *alertView  =[[UIAlertView alloc]initWithTitle:@"提示" message:@"注释完成" delegate:nil cancelButtonTitle:@"完成" otherButtonTitles:@"继续", nil];
    [alertView show];
    alertView.delegate = self ;
    
}

#pragma mark ---------UIAlertViewDelegate--------------
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
        
        //block块传值
//        NSLog(@"%@",_textView.text);
        self.transValueBlock(_textView.text);
    }
    else
    {
        
    }
}

-(void)delectButtonAction:(UIButton *)sender
{
    [_textView resignFirstResponder];
    
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
