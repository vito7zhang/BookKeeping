//
//  NewViewController.m
//  Demo
//
//  Created by 林福荣 on 15/9/29.
//  Copyright © 2015年 TalentBoy. All rights reserved.
//

#import "NewViewController.h"
#import "DemoViewController.h"

@interface NewViewController ()
{   UILabel *label;
    UILabel *downLabel;
    NSMutableString *mString;
    NSMutableString *mString2;
    UIView *view;
    int number;
}
@end

@implementation NewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    number=1;
    mString=[[NSMutableString alloc]init];
    mString2=[NSMutableString string];
    label=[[UILabel alloc]init];
    label.translatesAutoresizingMaskIntoConstraints=NO;
    label.text=@"输入密码";
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:12];
    label.textColor=[UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0  alpha:1];
    [self.view addSubview:label];
    NSLayoutConstraint *constraints=[NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    [self.view addConstraint:constraints];
    constraints=[NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:0 constant:120];
    [self.view addConstraint:constraints];
    constraints=[NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:0 constant:15];
    [self.view addConstraint:constraints];
    constraints=[NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:0.6 constant:0];
    [self.view addConstraint:constraints];
    //密码输入框
    { for (int i=1; i<5; i++) {
        
        UIImageView *imageview2=[[UIImageView alloc]init];
        imageview2.image=[UIImage imageNamed:@"password1"];
        imageview2.translatesAutoresizingMaskIntoConstraints=NO;
        [self.view addSubview:imageview2];
        imageview2.tag=i+100;
        constraints=[NSLayoutConstraint constraintWithItem:imageview2 attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:40*(i-2.5)];
        [self.view addConstraint:constraints];
        constraints=[NSLayoutConstraint constraintWithItem:imageview2 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:0 constant:20];
        [self.view addConstraint:constraints];
        constraints=[NSLayoutConstraint constraintWithItem:imageview2 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:0 constant:20];
        [self.view addConstraint:constraints];
        constraints=[NSLayoutConstraint constraintWithItem:imageview2 attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:0.7 constant:0];
        [self.view addConstraint:constraints];
    }
    }
    
    //下label
    {
        downLabel=[[UILabel alloc]init];
        downLabel.translatesAutoresizingMaskIntoConstraints=NO;
        downLabel.textAlignment=NSTextAlignmentCenter;
        downLabel.font=[UIFont systemFontOfSize:12];
        downLabel.textColor=[UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0  alpha:1];
        [self.view addSubview:downLabel];
        NSLayoutConstraint *constraints=[NSLayoutConstraint constraintWithItem:downLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
        [self.view addConstraint:constraints];
        constraints=[NSLayoutConstraint constraintWithItem:downLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:0 constant:140];
        [self.view addConstraint:constraints];
        constraints=[NSLayoutConstraint constraintWithItem:downLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:0 constant:20];
        [self.view addConstraint:constraints];
        constraints=[NSLayoutConstraint constraintWithItem:downLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:0.8 constant:0];
        [self.view addConstraint:constraints];
    }
    {
        view=[[UIView alloc]init];
        [self.view addSubview:view];
        view.backgroundColor=[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0  alpha:1];
        view.frame=CGRectMake(0, Screen_Height-Screen_Height/5.0*2, Screen_Width, Screen_Height/5.0*2);
        [self.view addSubview:view];
    }
    NSArray *array=@[@"7",@"8",@"9",@"4",@"5",@"6",@"1",@"2",@"3",@"0",@"0",@"0"];
    CGFloat height=Screen_Height/5.0*2.0/4;
    int  count=0;
    for (int i=0; i<4; i++) {
        Screen_Width/3-10;
        for (int j=0; j<3; j++) {
            if (count==9) {
                count++;
                continue;
            }
            UIButton *button=[UIButton buttonWithType:UIButtonTypeSystem];
            [view addSubview:button];
            button.frame=CGRectMake(Screen_Width/3*j+1, height*i, Screen_Width/3-1, height-1);
            if (count==11) {
                [button addTarget:self action:@selector(moveLastAction:) forControlEvents:UIControlEventTouchUpInside];
                button.tintColor=[UIColor whiteColor];
                [button setTitle:@"回删" forState:0];
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
                button.backgroundColor=[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0  alpha:1];
                count++;
                continue;
            }
            button.titleLabel.font=[UIFont systemFontOfSize:25];
            button.backgroundColor=[UIColor whiteColor];
            [button setTintColor:[UIColor blackColor]];
            [button setTitle:array[count] forState:0];
            [button setTitle:array[count] forState:UIControlStateHighlighted];
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            count++;
        }
        
    }


    
   }
-(void)moveLastAction:(UIButton *)sender{
    
    if (mString.length==0) {
        return;
    }else{
        UIImageView *imageView=(UIImageView *)[self.view viewWithTag:100+mString.length];
        imageView.image=[UIImage imageNamed:@"password1"];
        [mString deleteCharactersInRange:NSMakeRange(mString.length-1, 1)];
    }
}
-(void)buttonAction:(UIButton *)sender{
    [mString appendString:sender.currentTitle ];
    UIImageView *imageView=(UIImageView *)[self.view viewWithTag:100+mString.length];
    imageView.image=[UIImage imageNamed:@"password2"];
    if (mString.length ==4) {
        [ self performSelector:@selector(timeAction) withObject:nil afterDelay:0.1];
    }
}
-(void)cancelAction:(UIBarButtonItem *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)timeAction{
    for (int i=1; i<5; i++) {
        UIImageView *imageView=(UIImageView *)[self.view viewWithTag:100+i];
        imageView.image=[UIImage imageNamed:@"password1"];
    }
    
    {
        //取值密码；
        mString2=[[NSUserDefaults standardUserDefaults] valueForKey:Password];
        if ([mString isEqualToString:mString2]) {
            mString=[NSMutableString string];
            /*-------------------------*/
//            NSLog(@"进入看数据");
            
            LinViewController *queryViewController = [LinViewController new];
            [self.navigationController pushViewController:queryViewController animated:YES];
            
            return;
        }
        downLabel.layer.cornerRadius=10;
        downLabel.layer.masksToBounds=YES;
        downLabel.textColor=[UIColor whiteColor];
        downLabel.layer.borderWidth=1;
        downLabel.text=[NSString stringWithFormat:@"%d次密码输入错误",number];
        downLabel.backgroundColor=[UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0  alpha:1];
        number++;
    }
    mString=[NSMutableString string];
    
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
