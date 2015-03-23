//
//  lxyFunctionOfDataBase.m
//  DataBase
//
//  Created by 刘翔宇 on 14-6-17.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "lxyFunctionOfDataBase.h"

#import "lxyDataBase.h"
#import "lxyBackGroundImageModel.h"
#import "lxySandTimerModel.h"
#import "lxyCommonDiaryModel.h"
#import "lxyAlonePersonModel.h"
#import "YCSpecialDayTable.h"
#import <sqlite3.h>

@implementation lxyFunctionOfDataBase

//查询一个表中的所有数据并返回到一个数组中
+ (NSMutableArray *)searchAllDataInTable:(NSString *)tableName
{
    NSMutableArray *array = [NSMutableArray array];
    
    //如果查询的是沙漏表
    if ([tableName isEqualToString:@"sandTimerTable"]) {
        
        array = [[lxyDataBase shareLxyDataBase] searchAllDataFromSandTimerTable];
    }
    
    //如果查询的是背景图片表
    if ([tableName isEqualToString:@"backGroundImageTable"]) {
        array = [[lxyDataBase shareLxyDataBase] searchAllDataFrombackGroundImageTable];
    }
    
    //如果查询的是个人历史记录表
    if ([tableName isEqualToString:@"alonePersonTable"]) {
        array = [[lxyDataBase shareLxyDataBase] searchAllDataFromalonePersonTable];
    }
    
    //如果查询的是普通日记表
    if ([tableName isEqualToString:@"diaryTable"]) {
        array = [[lxyDataBase shareLxyDataBase] searchAllDataFromDiaryTable];
    }
    
    //如果查询的是特殊日表
    if ([tableName isEqualToString:@"specialDayTable"]) {
        array = [[lxyDataBase shareLxyDataBase] searchAllDataFromSpecialDayTable];
    }
    
    return array;
}

//向一个表中插入一条数据
+ (void)insertToTabel:(NSString *)tableName withObject:(id)object
{
    //如果查询的是沙漏表
    if ([tableName isEqualToString:@"sandTimerTable"]) {
        
        [[lxyDataBase shareLxyDataBase] insertToSandTimerTableWithOneSandTimerModel:((lxySandTimerModel *)object)];
    }
    
    //如果查询的是背景图片表
    if ([tableName isEqualToString:@"backGroundImageTable"]) {
        [[lxyDataBase shareLxyDataBase] insertToBackGroundImageTableWithOneImage:(lxyBackGroundImageModel *)object];
    }
    
    //如果查询的是个人历史记录表
    if ([tableName isEqualToString:@"alonePersonTable"]) {
        [[lxyDataBase shareLxyDataBase] insertToAlonePersonTableWithOneAlonePersonModel:(lxyAlonePersonModel *)object];
    }
    
    //如果查询的是普通日记表
    if ([tableName isEqualToString:@"diaryTable"]) {
        [[lxyDataBase shareLxyDataBase] insertToDiaryTableWithOneDiaryModel:(lxyDiaryModel *)object];
    }
    
    //如果查询的是用户表
    if ([tableName isEqualToString:@"userTable"]) {
        [[lxyDataBase shareLxyDataBase] insertToUserTableWithOneUserTableModel:(lxyUserTableModel *)object];
    }
    
    //如果查询的时特殊日表
    if ([tableName isEqualToString:@"specialDayTable"]) {
        [[lxyDataBase shareLxyDataBase] insertToSpecialDayTableWithOneSpecialDayModel:(YCSpecialDayTable *)object];
    }
}

//在一个表中删除一条数据
+ (void)deleteOneDataBy:(id)object fromTable:(NSString *)tableName
{
    //如果查询的是沙漏表
    if ([tableName isEqualToString:@"sandTimerTable"]) {
        
        [[lxyDataBase shareLxyDataBase] deleteOneSandTimerModel:(lxySandTimerModel *)object];
    }
    
    //如果查询的是背景图片表
    if ([tableName isEqualToString:@"backGroundImageTable"]) {
        [[lxyDataBase shareLxyDataBase] deleteOneImageWithImageName:(lxyBackGroundImageModel *)object];
    }
    
    //如果查询的是个人历史记录表
    if ([tableName isEqualToString:@"alonePersonTable"]) {
        [[lxyDataBase shareLxyDataBase] deleteOneAlonePersonModel:(lxyAlonePersonModel *)object];
    }
    
    //如果查询的是普通日记表
    if ([tableName isEqualToString:@"diaryTable"]) {
        [[lxyDataBase shareLxyDataBase] deleteOneDiaryModel:(lxyDiaryModel *)object];
    }
    
    //如果查询的是用户表
    if ([tableName isEqualToString:@"userTable"]) {
        [[lxyDataBase shareLxyDataBase] deleteAllDataFromUserTable];
    }
    
    //如果查询的时特殊日表
    if ([tableName isEqualToString:@"specialDayTable"]) {
        [[lxyDataBase shareLxyDataBase] deleteOneSpecialDayModel:(YCSpecialDayTable *)object];
    }
}

//在一个表中修改一条数据
+ (void)alertOneDataBy:(id)object fromTable:(NSString *)tableName
{
    //如果查询的是沙漏表
    if ([tableName isEqualToString:@"sandTimerTable"]) {
        
        [[lxyDataBase shareLxyDataBase] alertOneSandTimerModelByStyle:(lxySandTimerModel *)object];
    }
    
    //如果查询的是用户表
    if ([tableName isEqualToString:@"userTable"]) {
        [[lxyDataBase shareLxyDataBase] alertPassWordWithNewPassWord:(NSString *)object];
    }
    
    if (![tableName isEqualToString:@"sandTimerTable"] && ![tableName isEqualToString:@"userTable"]) {
        NSLog(@"只能修改沙漏表中的style和用户表中的密码");
    }
}

//在一个表中查询一条数据
+ (id)searchOneDataFromTable:(NSString *)tableName byID:(NSInteger)ID orAlonePersonModelName:(NSString *)alonePersonModelName orCommonDiaryModelTime:(NSString *)time
{
    //如果查询的是沙漏表
    if ([tableName isEqualToString:@"sandTimerTable"]) {
        return [[lxyDataBase shareLxyDataBase] searchOneSandTimerModel:(NSInteger)ID];
    }
    
    //如果查询的是背景图片表
    if ([tableName isEqualToString:@"backGroundImageTable"]) {
        return [[lxyDataBase shareLxyDataBase] searchOneDataFromBackGroundImageTableByID:(NSInteger)ID];
    }
    
    //如果查询的是个人历史记录表
    if ([tableName isEqualToString:@"alonePersonTable"]) {
        return [[lxyDataBase shareLxyDataBase] searchOneAlonePersonModelByAlonePersonModelName:(NSString *)alonePersonModelName];
    }
    
    //如果查询的是普通日记表
    if ([tableName isEqualToString:@"diaryTable"]) {
        return [[lxyDataBase shareLxyDataBase] searchOneDiaryModelByTime:(NSString *)time];
    }
    
    return [NSString stringWithFormat:@"error"];
    
}

//创建数据表
+ (void)createOneTable:(NSString *)tableName
{
    //如果查询的是沙漏表
    if ([tableName isEqualToString:@"sandTimerTable"]) {
        
        [[lxyDataBase shareLxyDataBase] createSandTimerTable];
    }
    
    //如果查询的是背景图片表
    if ([tableName isEqualToString:@"backGroundImageTable"]) {
        [[lxyDataBase shareLxyDataBase] createBackGroundImageTable];
    }
    
    //如果查询的是个人历史记录表
    if ([tableName isEqualToString:@"alonePersonTable"]) {
        [[lxyDataBase shareLxyDataBase] createAlonePersonTable];
    }
    
    //如果查询的是普通日记表
    if ([tableName isEqualToString:@"diaryTable"]) {
        [[lxyDataBase shareLxyDataBase] createDiaryTable];
    }
    
    //如果查询的是用户表
    if ([tableName isEqualToString:@"passWordTable"]) {
        [[lxyDataBase shareLxyDataBase] createUserTable];
    }
    
    //如果查询的是特殊日表
    if ([tableName isEqualToString:@"specialDayTable"]) {
        [[lxyDataBase shareLxyDataBase] createSpecialDayTable];
    }
}

@end
