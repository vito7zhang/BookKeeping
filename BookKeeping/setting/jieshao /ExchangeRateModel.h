//
//  ExchangeRateModel.h
//  test_demo
//
//  Created by ibokan on 15/9/28.
//  Copyright (c) 2015年 rick. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExchangeRateModel : NSObject

@property (nonatomic,strong)NSString *fromCurrency;

@property (nonatomic,strong) NSString *toCurrency ;

@property (nonatomic,strong) NSString *date ;

@property (nonatomic,strong) NSString *time ;

@property (nonatomic,strong) NSNumber *currency ;

@property (nonatomic,strong) NSNumber *amount ;

@property (nonatomic,strong) NSNumber *convertedamount ;

-(id)initWithDictionary:(NSDictionary *)dictionary ;

@end
