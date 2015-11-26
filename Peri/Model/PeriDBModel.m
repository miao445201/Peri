//
//  PeriDBModel.m
//  Peri
//
//  Created by fitfun on 15/11/25.
//  Copyright © 2015年 miao. All rights reserved.
//

#import "PeriDBModel.h"
#import "imageModel.h"

static  PeriDBModel * s_Instance = nil;
#define DBNAME  @"Peri_ImageUrl.sqlite"

@interface PeriDBModel() {
    @private
    FMDatabase* m_db;
}
@end
@implementation PeriDBModel


+ (instancetype)GetInstance {
    if (nil != s_Instance) {
        return s_Instance;
    }
    s_Instance = [[PeriDBModel alloc]init];
    s_Instance->m_db = nil;
    return s_Instance;
}

- (void)initDB {
    
    if (nil != m_db) {
        return;
    }
    
    NSString *docsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *dbPath   = [docsPath stringByAppendingPathComponent:DBNAME];
    NSLog(@"==============================================%@",dbPath);
    m_db = [FMDatabase databaseWithPath:dbPath];
    
    if ([m_db open]) {
        NSString *CreateTablesql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS PERI (PAGE INTEGER PRIMARY KEY AUTOINCREMENT,IMAGE TEXT UNIQUE,DETAIL TEXT UNIQUE)"];
        BOOL result = [m_db executeUpdate:CreateTablesql];
        if (result) {
            NSLog(@"建表成功");
        }
        else {
            NSLog(@"建表失败");
        }
    }
    else {
        NSLog(@"打开数据库失败");
    }
}

- (void)closeDB {
    if ( nil != m_db )
    {
        [m_db close];
        m_db = nil;
    }
}

//插入数据
- (void)insertWithDataArray:(NSMutableArray *)dataArray
{
    for (imageModel *model in dataArray) {
        [m_db executeUpdate:@"INSERT INTO PERI (IMAGE,DETAIL) VALUES (?, ?)",model.imageUrl,model.imageDetail];
    }
}

//查询
- (NSMutableArray*)queryWithPage:(int)page
{
    // 1.执行查询语句
    NSString *pageCount = [NSString stringWithFormat:@"%d",30 * (page-1)];
    FMResultSet *resultSet = [m_db executeQuery:@"SELECT * FROM PERI LIMIT ?,30",pageCount];
    NSMutableArray *dataArray = [[NSMutableArray alloc]initWithCapacity:100];
    // 2.遍历结果
    while ([resultSet next]) {
        imageModel *model = [[imageModel alloc]init];
        model.imageUrl = [resultSet stringForColumn:@"IMAGE"];
        model.imageDetail = [resultSet stringForColumn:@"DETAIL"];
        [dataArray addObject:model];
    }
    return dataArray;
}
@end
