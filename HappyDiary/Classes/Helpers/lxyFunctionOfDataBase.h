//
//  lxyFunctionOfDataBase.h
//  DataBase
//
//  Created by 刘翔宇 on 14-6-17.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface lxyFunctionOfDataBase : NSObject

//查询一个表中的所有数据并返回到一个数组中
+ (NSMutableArray *)searchAllDataInTable:(NSString *)tableName;

//向一个表中插入一条数据
+ (void)insertToTabel:(NSString *)tableName withObject:(id)object;

//在一个表中删除一条数据
+ (void)deleteOneDataBy:(id)object fromTable:(NSString *)tableName;

//在一个表中修改一条数据
+ (void)alertOneDataBy:(id)object fromTable:(NSString *)tableName;

//在一个表中查询一条数据
+ (id)searchOneDataFromTable:(NSString *)tableName byID:(NSInteger)ID orAlonePersonModelName:(NSString *)alonePersonModelName orCommonDiaryModelTime:(NSString *)time;

//创建数据表
+ (void)createOneTable:(NSString *)tableName;

@end
