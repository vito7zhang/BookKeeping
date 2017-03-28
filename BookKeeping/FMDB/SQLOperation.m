//
//  SQLOperation.m
//  testDB
//
//  Created by Ibokan on 15/9/23.
//  Copyright (c) 2015年 ibokan. All rights reserved.
//

#import "SQLOperation.h"


@implementation SQLOperation
+(FMDatabase *)createDatabase{
    NSString* docsdir = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString* dbpath = [docsdir stringByAppendingPathComponent:@"BookKeeping.sqlite"];
    
    FMDatabase *db = [FMDatabase databaseWithPath:dbpath];
    
    [db open];
    NSString *sqlCreateTable =  [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS 'accounts' ('date' TEXT, 'type' TEXT, 'typeImageName' TEXT, 'money' TEXT, 'moneyType' TEXT ,'remark' TEXT)"];
    [db executeUpdate:sqlCreateTable];
    [db close];
    return db;
}

+(NSArray *)findModelFromDate:(NSString *)date{
    NSMutableArray *array = [NSMutableArray array];
    
    FMDatabase *db = [self createDatabase];
    
    //寻找数据
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return nil;
    }
    NSString *sql = [NSString stringWithFormat:@"select * from accounts where date like '%@%%'",date];
    FMResultSet *result = [db executeQuery:sql];
    while ([result next]) {
        Model *m = [Model new];
        m.date = [result stringForColumn:@"date"];
        m.type = [result stringForColumn:@"type"];
        m.money = [result stringForColumn:@"money"];
        m.moneyType = [result stringForColumn:@"moneyType"];
        m.remark = [result stringForColumn:@"remark"];
        m.typeImageName = [result stringForColumn:@"typeImageName"];
        [array addObject:m];
    }
    [db close];
    return array;
    
}
+(NSArray *)findModelFromDate:(NSString *)date Type:(NSString*)type{
    NSMutableArray *array = [NSMutableArray array];
    
    FMDatabase *db = [self createDatabase];
    
    //寻找数据
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return nil;
    }
    NSString *sql = [NSString stringWithFormat:@"select * from accounts where type like '%@%%' and date like '%@%%'",type,date];
    FMResultSet *result = [db executeQuery:sql];
    while ([result next]) {
        Model *m = [Model new];
        m.date = [result stringForColumn:@"date"];
        m.type = [result stringForColumn:@"type"];
        m.money = [result stringForColumn:@"money"];
        m.moneyType = [result stringForColumn:@"moneyType"];
        m.remark = [result stringForColumn:@"remark"];
        m.typeImageName = [result stringForColumn:@"typeImageName"];
        [array addObject:m];
    }
    [db close];
    return array;
}

+(NSArray *)findModelFromType:(NSString *)type{
    NSMutableArray *array = [NSMutableArray array];
    
    FMDatabase *db = [self createDatabase];
    
    //寻找数据
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return nil;
    }
    NSString *sql = [NSString stringWithFormat:@"select * from accounts where type like '%@%%'",type];
    FMResultSet *result = [db executeQuery:sql];
    while ([result next]) {
        Model *m = [Model new];
        m.date = [result stringForColumn:@"date"];
        m.type = [result stringForColumn:@"type"];
        m.money = [result stringForColumn:@"money"];
        m.moneyType = [result stringForColumn:@"moneyType"];
        m.remark = [result stringForColumn:@"remark"];
        m.typeImageName = [result stringForColumn:@"typeImageName"];
        [array addObject:m];
    }
    [db close];
    return array;
    
}

+(BOOL)insertWithModel:(Model *)m{
    BOOL flag = NO;
    
    FMDatabase *db = [self createDatabase];
    
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return flag;
    }
    //插入数据
    /*
     英文名字	中文名字
     date	日期
     money	金额
     moneyType	金额类型（美元或者人民币等等）
     type	消费类型
     typeImageName	消费类型对应图片名称
     remark	备注
     */
    NSString *insertSql = [NSString stringWithFormat:@"INSERT INTO 'accounts' ('date', 'type', 'typeImageName', 'money', 'moneyType', 'remark') VALUES ('%@','%@', '%@', '%@', '%@', '%@')", m.date, m.type, m.typeImageName, m.money, m.moneyType,m.remark];
    flag = [db executeUpdate:insertSql];

    [db close];

    return flag;
    
}

+(BOOL)delectWithDate:(NSString *)date{
    BOOL flag = NO;
    
    FMDatabase *db = [self createDatabase];
    
    if (![db open]) {
        NSLog(@"数据库打开失败");
        return flag;
    }
    NSString *insertSql = [NSString stringWithFormat:@"delete from accounts where date like '%@%%'",date];
    flag = [db executeUpdate:insertSql];

    [db close];

    return flag;
}

@end
