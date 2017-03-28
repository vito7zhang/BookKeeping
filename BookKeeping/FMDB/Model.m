//
//  Model.m
//  testDB
//
//  Created by Ibokan on 15/9/23.
//  Copyright (c) 2015年 ibokan. All rights reserved.
//

#import "Model.h"
#import <FMDB.h>

@implementation Model

-(id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        [self setValuesForKeysWithDictionary:dictionary];
    }
    return self ;
}

@end
