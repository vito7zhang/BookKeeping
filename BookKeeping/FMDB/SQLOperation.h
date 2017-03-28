//
//  SQLOperation.h
//  testDB
//
//  Created by Ibokan on 15/9/23.
//  Copyright (c) 2015年 ibokan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Model.h"
#import <FMDB.h>

@interface SQLOperation : NSObject
+(FMDatabase *)createDatabase;
+(NSArray *)findModelFromDate:(NSString *)date;
+(NSArray *)findModelFromType:(NSString *)type;
+(NSArray *)findModelFromDate:(NSString *)date Type:(NSString*)type;
//+(NSArray *)findModel
+(BOOL)insertWithModel:(Model *)m;
+(BOOL)delectWithDate:(NSString *)date;
@end
