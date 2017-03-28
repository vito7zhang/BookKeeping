//
//  Model.h
//  testDB
//
//  Created by Ibokan on 15/9/23.
//  Copyright (c) 2015年 ibokan. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface Model : NSObject
@property (nonatomic,strong)NSString *date;
@property (nonatomic,strong)NSString *type;
@property (nonatomic,strong)NSString *money;
@property (nonatomic,strong)NSString *moneyType;
@property (nonatomic,strong)NSString *remark;
@property (nonatomic,strong)NSString *typeImageName;

-(id)initWithDictionary:(NSDictionary *)dictionary ;

@end
