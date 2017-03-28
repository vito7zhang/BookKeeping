//
//  ExchangeRateModel.m
//  test_demo
//
//  Created by ibokan on 15/9/28.
//  Copyright (c) 2015年 rick. All rights reserved.
//

#import "ExchangeRateModel.h"

@implementation ExchangeRateModel

/*
 "fromCurrency": "CNY",
 "toCurrency": "USD",
 "date": "2015-09-28",
 "time": "04:09:50",
 "currency": 0.15705243980965,
 "amount": 5,
 "convertedamount": 0.78526219904826
 */

-(id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        [self setValuesForKeysWithDictionary:dictionary];
    }
    return self ;
}

@end
