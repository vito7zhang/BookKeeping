//
//  WriteViewController.h
//  BookKeeping
//
//  Created by ibokan on 15/9/23.
//  Copyright (c) 2015年 rick. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^transVlaue)(NSString *writeContent);

@interface WriteViewController : UIViewController

@property (nonatomic,copy) transVlaue transValueBlock ;

@end
