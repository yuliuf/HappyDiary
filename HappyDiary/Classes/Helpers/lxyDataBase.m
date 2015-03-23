//
//  lxyDataBase.m
//  DataBase
//
//  Created by 刘翔宇 on 14-6-17.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "lxyDataBase.h"
#import <sqlite3.h>

#import "lxySandTimerModel.h"
#import "lxyCommonDiaryModel.h"
#import "lxyAlonePersonModel.h"
#import "lxyBackGroundImageModel.h"
#import "YCSpecialDayTable.h"
#import "lxyUserTableModel.h"
#import "lxyDiaryModel.h"

static sqlite3 *db;
lxyDataBase *_dataBase = nil;

@implementation lxyDataBase

//获得类对象
+ (lxyDataBase *)shareLxyDataBase
{
    if (nil == _dataBase) {
        _dataBase = [[lxyDataBase alloc] init];
    }
    return _dataBase;
}




//打开数据库
- (void)openDataBase
{
    //获取document路径
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    
    //获取该document文件下数据库的路径
    self.dataPath = [documentPath stringByAppendingString:@"/data.sqlite"];
    
    
    //打开数据库（判断数据库的状态）
    sqlite3_open(_dataPath.UTF8String, &db);
    
    /*
    if (result == SQLITE_OK) {
        NSLog(@"数据库代开成功");
    } else {
        NSLog(@"数据库代开失败");
    }
     */
}
//关闭数据库
- (void)closeDataBase
{
    sqlite3_close(db);
    
    /*
    if (result == SQLITE_OK) {
        NSLog(@"关闭数据库成功");
    } else {
        NSLog(@"关闭数据库失败");
    }
     */
}







#pragma mark - 沙漏表的创建和操作(sandTimerTable)
//字段（ID：ID  风格：style   背景音乐:backGroundMusic     人名：peopleName）

//创建一个沙漏表（sandTimerTable）
- (void)createSandTimerTable
{
    [self openDataBase];
    
    //创建的sql语句
    NSString *sql = @"create table sandTimerTable (ID integer primary key autoincrement,style text, backGroundMusic text, peopleName text, time text, introduce text)";
    
    sqlite3_exec(db, sql.UTF8String, NULL, NULL, NULL);
    
    /*
    if (result == SQLITE_OK) {
        NSLog(@"数据表sandTimerTable创建成功");
    } else {
        NSLog(@"数据表sandTimerTable创建失败");
    }
     */
    
    [self closeDataBase];
}

//在沙漏表（sandTimerTable）中添加一个沙漏（sandTimerModel）
- (void)insertToSandTimerTableWithOneSandTimerModel:(lxySandTimerModel *)sandTimerModel
{
    [self openDataBase];
    
    NSString *style = sandTimerModel.style;
    NSString *backGroundMusic = sandTimerModel.backGroundMusic;
    NSString *peopleName = sandTimerModel.peopleName;
    NSString *time = sandTimerModel.time;
    NSString *introduce = sandTimerModel.introduce;
    
    NSString *sql = [NSString stringWithFormat:@"insert into sandTimerTable(style, backGroundMusic, peopleName, time, introduce) values('%@', '%@', '%@', '%@', '%@')", style , backGroundMusic , peopleName , time, introduce];
    
    sqlite3_exec(db, sql.UTF8String, NULL, NULL, NULL);
    
    /*
    if (result == SQLITE_OK) {
        NSLog(@"插入sandTimerModel成功");
    } else {
        NSLog(@"插入sandTimerModel失败");
    }
    */
    
    [self closeDataBase];
}

//在沙漏表（sandTimerTable）中删除一个沙漏（sandTimerModel）
- (void)deleteOneSandTimerModel:(lxySandTimerModel *)sandTimerModel
{
    [self openDataBase];
    
    NSInteger ID = [sandTimerModel.ID integerValue];
    
    NSString *sql = [NSString stringWithFormat:@"delete from sandTimerTable where ID = '%ld'", (long)ID];
    
    sqlite3_exec(db, sql.UTF8String, NULL, NULL, NULL);
    
    /*
    if (result == SQLITE_OK) {
        NSLog(@"删除sandTimerModel成功");
    } else {
        NSLog(@"删除sandTimerTable失败");
    }
    */
    
    [self closeDataBase];
}

//在沙漏表（sandTimerTable）中修改一个沙漏（sandTimerModel）
- (void)alertOneSandTimerModelByStyle:(lxySandTimerModel *)sandTimerModel
{
    [self openDataBase];
    
    NSString *style = sandTimerModel.style;
    NSInteger ID = [sandTimerModel.ID integerValue];
    
    NSString *sql = [NSString stringWithFormat:@"update sandTimerTable set style = '%@' where ID = '%d'", style , ID];
    
    sqlite3_exec(db, sql.UTF8String, NULL, NULL, NULL);
    
    /*
    if (result == SQLITE_OK) {
        NSLog(@"修改sandTimerModel的style成功");
    } else {
        NSLog(@"修改sandTimerModel的style失败");
    }
    */
    
    [self closeDataBase];
}

//在沙漏表（sandTimerTable）中查询一个沙漏（sandTimerModel）
- (lxySandTimerModel *)searchOneSandTimerModel:(NSInteger)sandTimerModelID
{
    [self openDataBase];
    
    //创建一个lxySandTimerModel对象
    lxySandTimerModel *sandTimerModel = [[[lxySandTimerModel alloc] init] autorelease];
    
    //准备存储值的对象
    sqlite3_stmt *stmt = nil;
    
    //准备sql语句
    NSString *sql = [NSString stringWithFormat:@"select ID, style, backGroundMusic, peopleName, introduce from sandTimerTable where ID = ?"];
    
    //判断sql语句是否正确
    int result = sqlite3_prepare_v2(db, sql.UTF8String, -1, &stmt, NULL);
    
    if (result == SQLITE_OK) {
        
        //绑定要查找的ID
        sqlite3_bind_int(stmt, 1, sandTimerModelID);
        
        //单步执行，查询表
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            //取ID
            NSInteger ID = sqlite3_column_int(stmt, 0);
            
            //取style
            NSString *style = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
            
            //取backGroundMusic
            NSString *backGroundMusic = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];
            
            //取peopleName
            NSString *peopleName = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 3)];
            
            //取time
            NSString *time = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 4)];
            
            //取introduce
            NSString *introduce = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 5)];
            
            sandTimerModel.ID = [NSString stringWithFormat:@"%d", ID];
            sandTimerModel.style = style;
            sandTimerModel.backGroundMusic = backGroundMusic;
            sandTimerModel.peopleName = peopleName;
            sandTimerModel.time = time;
            sandTimerModel.introduce = introduce;
            
            //清空存值对象
            sqlite3_finalize(stmt);
        }
    }
    
    //清空存值对象
    sqlite3_finalize(stmt);
    
    
    [self closeDataBase];
    
    return sandTimerModel;
}

//查询表（sandTimerTable）中的所有数据
- (NSMutableArray *)searchAllDataFromSandTimerTable
{
    [self openDataBase];
    
    //准备返回的可变数组
    NSMutableArray *array = [ NSMutableArray array];
    
    //准备sql语句
    NSString *sql = @"select * from sandTimerTable";
    
    //准备存储值对象
    sqlite3_stmt *stmt = nil;
    
    sqlite3_prepare(db, sql.UTF8String, -1, &stmt, NULL);
    
    //判断是否可以往下读取
    while (sqlite3_step(stmt) == SQLITE_ROW) {
        
        //准备sandTimerModel对象
        lxySandTimerModel *sandTimerModel = [[[lxySandTimerModel alloc] init] autorelease];
        
        //获取ID
        NSInteger ID = sqlite3_column_int(stmt, 0);
        
        //获取style
        NSString *style = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
        
        //取backGroundMusic
        NSString *backGroundMusic = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];
        
        //取peopleName
        NSString *peopleName = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 3)];
        
        //取time
        NSString *time = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 4)];
        
        //取introduce
        NSString *introduce = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 5)];
        
        sandTimerModel.ID = [NSString stringWithFormat:@"%d", ID];
        sandTimerModel.style = style;
        sandTimerModel.backGroundMusic = backGroundMusic;
        sandTimerModel.peopleName = peopleName;
        sandTimerModel.time = time;
        sandTimerModel.introduce = introduce;
        
        [array addObject:sandTimerModel];
    }
    
    //清空存储值对象
    sqlite3_finalize(stmt);
    
    [self closeDataBase];
    
    return array;
}









#pragma mark - 用户表的创建和操作（userTable）
//字段（user_id, user_name, user_pwd, user_birthday, user_headerImage, user_introduction）

//  创建用户表
- (void)createUserTable
{
    [self openDataBase];
    
    //创建的sql语句
    NSString *sql = @"create table userTable (user_id integer primary key not null,user_name text not null,user_pwd text not null,user_birthday text,user_headerImage text,user_introduce text,user_photo1 text,user_photo2 text)";
    
    sqlite3_exec(db, sql.UTF8String, NULL, NULL, NULL);
    
    /*
    if (result == SQLITE_OK) {
        NSLog(@"数据表userTable创建成功");
    } else {
        NSLog(@"数据表userTable创建失败");
    }
    */
    
    [self closeDataBase];
}

//插入数据
- (void)insertToUserTableWithOneUserTableModel:(lxyUserTableModel *)userTableModel
{
    [self openDataBase];
    
    NSInteger ID = userTableModel.user_id;
    NSString *name = userTableModel.user_name;
    NSString *pwd = userTableModel.user_pwd;
    NSString *birthday = userTableModel.user_birthday;
    NSString *headerImage = userTableModel.user_headerImage;
    NSString *introduce = userTableModel.user_introduce;
    NSString *photo1 = userTableModel.user_photo1;
    NSString *photo2 = userTableModel.user_photo2;
    
    NSString *sql = [NSString stringWithFormat:@"insert into userTable(user_id,user_name,user_pwd,user_birthday,user_headerImage,user_introduce , user_photo1 , user_photo2) values('%d','%@','%@','%@','%@','%@' , '%@' , '%@')", ID, name, pwd, birthday, headerImage, introduce , photo1 , photo2];
    
    sqlite3_exec(db, sql.UTF8String, NULL, NULL, NULL);
    
    /*
    if (result == SQLITE_OK) {
        NSLog(@"插入userTableModel成功");
    } else {
        NSLog(@"插入userTableModel失败");
    }
     */
    
    [self closeDataBase];
}

//删除数据
- (void)deleteAllDataFromUserTable
{
    [self openDataBase];
    
    NSString *sql = [NSString stringWithFormat:@"delete from userTable where ID = 0"];
    
    sqlite3_exec(db, sql.UTF8String, NULL, NULL, NULL);
    
    /*
    if (result == SQLITE_OK) {
        NSLog(@"删除userTableModel成功");
    } else {
        NSLog(@"删除userTableModel失败");
    }
     */
    
    [self closeDataBase];
}

//修改密码
- (void)alertPassWordWithNewPassWord:(NSString *)passWord
{
    [self openDataBase];
    
    NSInteger i = 0;
    
    NSString *sql = [NSString stringWithFormat:@"update userTable set user_pwd = '%@' where user_id = '%d'", passWord, i];
    
    sqlite3_exec(db, sql.UTF8String, NULL, NULL, NULL);
    
    /*
    if (result == SQLITE_OK) {
        NSLog(@"修改密码成功");
    } else {
        NSLog(@"修改密码失败");
    }
     */
    
    
    [self closeDataBase];
    
}

//修改姓名
- (void)alertNameWithNewName:(NSString *)name
{
    [self openDataBase];
    
    NSInteger i = 0;
    
    NSString *sql = [NSString stringWithFormat:@"update userTable set user_name = '%@' where user_id = '%d'", name, i];
    
    sqlite3_exec(db, sql.UTF8String, NULL, NULL, NULL);
    
    /*
    if (result == SQLITE_OK) {
        NSLog(@"修改姓名成功");
    } else {
        NSLog(@"修改姓名失败");
    }
     */
    
    
    [self closeDataBase];
}
//修改生日
- (void)alertBirthdayWithNewBirthday:(NSString *)birthday
{
    [self openDataBase];
    
    NSInteger i = 0;
    
    NSString *sql = [NSString stringWithFormat:@"update userTable set user_birthday = '%@' where user_id = '%d'", birthday, i];
    
    sqlite3_exec(db, sql.UTF8String, NULL, NULL, NULL);
    
    /*
    if (result == SQLITE_OK) {
        NSLog(@"修改生日成功");
    } else {
        NSLog(@"修改生日失败");
    }
     */
    
    
    [self closeDataBase];
}
//修改头像
- (void)alertHeadImageWithHeadImage:(NSString *)headImage
{
    [self openDataBase];
    
    NSInteger i = 0;
    
    NSString *sql = [NSString stringWithFormat:@"update userTable set user_headerImage = '%@' where user_id = '%d'", headImage, i];
    
    sqlite3_exec(db, sql.UTF8String, NULL, NULL, NULL);
    
    /*
    if (result == SQLITE_OK) {
        NSLog(@"修改头像成功");
    } else {
        NSLog(@"修改头像失败");
    }
     */
    
    
    [self closeDataBase];
}

//修改介绍
- (void)alertContentWithNewContent:(NSString *)content
{
    [self openDataBase];
    
    NSInteger i = 0;
    
    NSString *sql = [NSString stringWithFormat:@"update userTable set user_introduce = '%@' where user_id = '%d'", content, i];
    
    sqlite3_exec(db, sql.UTF8String, NULL, NULL, NULL);
    
    /*
    if (result == SQLITE_OK) {
        NSLog(@"修改介绍成功");
    } else {
        NSLog(@"修改介绍失败");
    }
     */
    
    
    [self closeDataBase];
}


//修改photo1
- (void)alertPhoto1WithPhoto:(NSString *)name
{
    [self openDataBase];
    
    NSInteger i = 0;
    
    NSString *sql = [NSString stringWithFormat:@"update userTable set user_photo1 = '%@' where user_id = '%d'", name, i];
    
    sqlite3_exec(db, sql.UTF8String, NULL, NULL, NULL);
    
    /*
    if (result == SQLITE_OK) {
        NSLog(@"修改photo1成功");
    } else {
        NSLog(@"修改photo1失败");
    }
     */
    
    
    [self closeDataBase];
}

//修改photo2
- (void)alertPhoto2WithPhoto:(NSString *)name
{
    [self openDataBase];
    
    NSInteger i = 0;
    
    NSString *sql = [NSString stringWithFormat:@"update userTable set user_photo2 = '%@' where user_id = '%d'", name, i];
    
    sqlite3_exec(db, sql.UTF8String, NULL, NULL, NULL);
    
    /*
    if (result == SQLITE_OK) {
        NSLog(@"修改photo2成功");
    } else {
        NSLog(@"修改photo2失败");
    }
     */
    
    
    [self closeDataBase];
}



//查询用户表中的数据
- (NSMutableArray *)searchAllDataFromUserTable
{
    [self openDataBase];
    
    NSString *sql = @"select * from userTable";
    NSMutableArray *array = [NSMutableArray array];
    
    sqlite3_stmt *stmt = nil;
    
    sqlite3_prepare(db, sql.UTF8String, -1, &stmt, NULL);
    
    //判断是否可以往下读取
    while (sqlite3_step(stmt) == SQLITE_ROW) {
        //准备userMode对象
        lxyUserTableModel *model = [[[lxyUserTableModel alloc] init] autorelease];
        
        //字段（user_id, user_name, user_pwd, user_birthday, user_headerImage, user_introduction）
        
        //获取ID
        NSInteger ID = sqlite3_column_int(stmt, 0);
        
        //获取user_name
        NSString *name = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
        
        //获取user_pwd
        NSString *pwd = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];
        
        //获取user_birthday
        NSString *birthday = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 3)];
        
        //获取user_headImage
        NSString *headImage = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 4)];
        
        //获取user_introduce
        NSString *introduce = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 5)];
        
        //获取photo0
        NSString *photo0 = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 6) == NULL ? "":(const char *)sqlite3_column_text(stmt, 6)];
        
        //获取photo1
        NSString *photo1 = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 7) == NULL ? "":(const char *)sqlite3_column_text(stmt, 7)];
        
        model.user_id = ID;
        model.user_name = name;
        model.user_introduce = introduce;
        model.user_headerImage = headImage;
        model.user_birthday = birthday;
        model.user_pwd = pwd;
        model.user_photo1 = photo0;
        model.user_photo2 = photo1;
        
        [array addObject:model];
    }
    
    //清空存储值对象
    sqlite3_finalize(stmt);
    
    [self closeDataBase];
    
    return array;
}






#pragma mark - 背景图片表的创建和操作(backGroundImageTable)
//字段（ID:ID    图片路径：imagePath）

//创建一个背景图片表（backGroundImageTable）
- (void)createBackGroundImageTable
{
    [self openDataBase];
    
    //创建的sql语句
    NSString *sql = @"create table backGroundImageTable (ID integer primary key autoincrement,imagePath text not null)";
    
    sqlite3_exec(db, sql.UTF8String, NULL, NULL, NULL);
    
    /*
    if (result == SQLITE_OK) {
        NSLog(@"数据表backGroundImageTable创建成功");
    } else {
        NSLog(@"数据表backGroundImageTable创建失败");
    }
    */
    
    [self closeDataBase];
}

//在背景图片表（backGroundImageTable）中插入一张图片
- (void)insertToBackGroundImageTableWithOneImage:(lxyBackGroundImageModel *)backGroundImageModel
{
    [self openDataBase];
    
    NSInteger ID = [backGroundImageModel.ID integerValue];
    NSString *imagePath = backGroundImageModel.imagePath;
    
    NSString *sql = [NSString stringWithFormat:@"insert into backGroundImageTable (imagePath, ID)values('%@', '%d')", imagePath , ID];
    
    sqlite3_exec(db, sql.UTF8String, NULL, NULL, NULL);
    
    /*
    if (result == SQLITE_OK) {
        NSLog(@"插入imagePath成功");
    } else {
        NSLog(@"插入imagePath失败");
    }
    */
    
    [self closeDataBase];
}

//在背景图片表（backGroundImageTable）中删除一张图片
- (void)deleteOneImageWithImageName:(lxyBackGroundImageModel *)backGroundImageModel
{
    [self openDataBase];
    
    NSInteger ID = [backGroundImageModel.ID integerValue];
    
    NSString *sql = [NSString stringWithFormat:@"delete from backGroundImageModel where ID = '%d'", ID];
    
    sqlite3_exec(db, sql.UTF8String, NULL, NULL, NULL);
    
    /*
    if (result == SQLITE_OK) {
        NSLog(@"删除backGroundImageModel成功");
    } else {
        NSLog(@"删除backGroundImageModel失败");
    }
     */
    
    [self closeDataBase];
}

//查询表（backGroundImageTable）中的所有数据
- (NSMutableArray *)searchAllDataFrombackGroundImageTable
{
    [self openDataBase];
    
    //准备返回的可变数组
    NSMutableArray *array = [ NSMutableArray array];
    
    //准备sql语句
    NSString *sql = @"select * from backGroundImageTable";
    
    //准备存储值对象
    sqlite3_stmt *stmt = nil;
    
    sqlite3_prepare(db, sql.UTF8String, -1, &stmt, NULL);
    
    //判断是否可以往下读取
    while (sqlite3_step(stmt) == SQLITE_ROW) {
        
        //准备backGroundImageModel对象
        lxyBackGroundImageModel *backGroundImageModel = [[[lxyBackGroundImageModel alloc] init] autorelease];
        
        //获取ID
        NSInteger ID = sqlite3_column_int(stmt, 0);
        
        //获取style
        NSString *imagePath = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
        
        backGroundImageModel.ID = [NSString stringWithFormat:@"%d", ID];
        backGroundImageModel.imagePath = imagePath;
        
        [array addObject:backGroundImageModel];
    }
    
    //清空存储值对象
    sqlite3_finalize(stmt);
    
    [self closeDataBase];
    
    return array;

}

- (lxyBackGroundImageModel *)searchOneDataFromBackGroundImageTableByID:(NSInteger)ID
{
    [self openDataBase];
    
    //创建一个lxyBackGroundImageModel对象
    lxyBackGroundImageModel *backGroundImageModel = [[[lxyBackGroundImageModel alloc] init] autorelease];
    
    //准备存储值的对象
    sqlite3_stmt *stmt = nil;
    
    //准备sql语句
    NSString *sql = [NSString stringWithFormat:@"select ID, imagePath from backGroundImageTable where ID = ?"];
    
    //判断sql语句是否正确
    int result = sqlite3_prepare_v2(db, sql.UTF8String, -1, &stmt, NULL);
    
    if (result == SQLITE_OK) {
        
        //绑定要查找的ID
        sqlite3_bind_int(stmt, 1, ID);
        
        //单步执行，查询表
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            //取ID
            NSInteger ID = sqlite3_column_int(stmt, 0);
            
            //取imagePath
            NSString *imagePath = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
            
            backGroundImageModel.ID = [NSString stringWithFormat:@"%d", ID];
            backGroundImageModel.imagePath = imagePath;
            
            //清空存值对象
            sqlite3_finalize(stmt);
        }
    }
    
    //清空存值对象
    sqlite3_finalize(stmt);
    
    
    [self closeDataBase];
    
    return backGroundImageModel;

}








#pragma mark - 创建一个个人记录表（alonePersonTable）
//字段（ID:ID  人名：name    记录的时间：time  记录的内容：content   背景图片：backGroundImage  记录时的天气：weather）

//创建一个个人记录表（alonePersonTable）
- (void)createAlonePersonTable
{
    [self openDataBase];
    
    //创建的sql语句
    NSString *sql = @"create table alonePersonTable (ID integer primary key autoincrement not null,name text not null,time text not null,content text,backGroundImage text,weather text)";
    
    sqlite3_exec(db, sql.UTF8String, NULL, NULL, NULL);
    
    /*
    if (result == SQLITE_OK) {
        NSLog(@"数据表alonePersonTable创建成功");
    } else {
        NSLog(@"数据表alonePersonTable创建失败");
    }
     */
    
    [self closeDataBase];
}

//在该个人记录表（alonePersonTable）中插入一条数据
- (void)insertToAlonePersonTableWithOneAlonePersonModel:(lxyAlonePersonModel *)alonePersonModel
{
    [self openDataBase];
    
    NSString *name = alonePersonModel.name;
    NSInteger ID = [alonePersonModel.ID integerValue];
    NSString *time = alonePersonModel.time;
    NSString *content = alonePersonModel.content;
    NSString *backGroundImage = alonePersonModel.backGroundImage;
    NSString *weather = alonePersonModel.weather;
    
    NSString *sql = [NSString stringWithFormat:@"insert into alonePersonTable (ID, name, time, content, backGroundImage, weather)values('%d', '%@', '%@', '%@', '%@', '%@')", ID , name , time , content , backGroundImage , weather];
    
    sqlite3_exec(db, sql.UTF8String, NULL, NULL, NULL);
    
    /*
    if (result == SQLITE_OK) {
        NSLog(@"插入alonePersonModel成功");
    } else {
        NSLog(@"插入alonePersonModel失败");
    }
     */
    
    [self closeDataBase];
}

//在该个人记录表（alonePersonTable）中删除一条数据
- (void)deleteOneAlonePersonModel:(lxyAlonePersonModel *)alonePersonModel
{
    [self openDataBase];
    
    NSInteger ID = [alonePersonModel.ID integerValue];
    
    NSString *sql = [NSString stringWithFormat:@"delete from alonePersonTable where ID = '%d'", ID];
    
    sqlite3_exec(db, sql.UTF8String, NULL, NULL, NULL);
    
    /*
    if (result == SQLITE_OK) {
        NSLog(@"删除alonePersonModel成功");
    } else {
        NSLog(@"删除alonePersonModel失败");
    }
     */
    
    [self closeDataBase];
}

//在该个人记录表（alonePersonTable）中查询一条数据
- (lxyAlonePersonModel *)searchOneAlonePersonModelByAlonePersonModelName:(NSString *)name
{
    [self openDataBase];
    
    //创建一个lxySandTimerModel对象
    lxyAlonePersonModel *alonePersonModel = [[[lxyAlonePersonModel alloc] init] autorelease];
    
    //准备存储值的对象
    sqlite3_stmt *stmt = nil;
    
    //准备sql语句
    NSString *sql = [NSString stringWithFormat:@"select ID, name, time, content, backGroundImage, weather from %@ where name = ?", name];
    
    //判断sql语句是否正确
    int result = sqlite3_prepare_v2(db, sql.UTF8String, -1, &stmt, NULL);
    
    if (result == SQLITE_OK) {
        
        //绑定要查找的ID
        sqlite3_bind_text(stmt, 1, name.UTF8String, strlen(name.UTF8String), SQLITE_STATIC);
        
        //单步执行，查询表
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            //取ID
            NSInteger ID = sqlite3_column_int(stmt, 0);
            
            //取name
            NSString *name = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
            
            //取time
            NSString *time = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];
            
            //取content
            NSString *content = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 3)];
            
            //取backGroundImage
            NSString *backGroundImage = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 4)];
            
            //取weather
            NSString *weather = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 5)];
            
            alonePersonModel.ID = [NSString stringWithFormat:@"%d", ID];
            alonePersonModel.name = name;
            alonePersonModel.time = time;
            alonePersonModel.content = content;
            alonePersonModel.backGroundImage = backGroundImage;
            alonePersonModel.weather = weather;
            
            //清空存值对象
            sqlite3_finalize(stmt);
        }
    }
    
    //清空存值对象
    sqlite3_finalize(stmt);
    
    
    [self closeDataBase];
    
    return alonePersonModel;

}

//查询表（alonePersonTable）中的所有数据
- (NSMutableArray *)searchAllDataFromalonePersonTable
{
    [self openDataBase];
    
    //准备返回的可变数组
    NSMutableArray *array = [ NSMutableArray array];
    
    //准备sql语句
    NSString *sql = [NSString stringWithFormat:@"select * from alonePersonTable"];
    
    //准备存储值对象
    sqlite3_stmt *stmt = nil;
    
    sqlite3_prepare(db, sql.UTF8String, -1, &stmt, NULL);
    
    //判断是否可以往下读取
    while (sqlite3_step(stmt) == SQLITE_ROW) {
        
        //准备backGroundImageModel对象
        lxyAlonePersonModel *alonePersonModel = [[[lxyAlonePersonModel alloc] init] autorelease];
        
        //获取ID
        NSInteger ID = sqlite3_column_int(stmt, 0);
        
        //获取name
        NSString *name = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
        
        //获取time
        NSString *time = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];
        
        //获取content
        NSString *content = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 3)];
        
        //获取backGroundImage
        NSString *backGroundImage = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 4)];
        
        //获取weather
        NSString *weather = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 5)];
        
        alonePersonModel.ID = [NSString stringWithFormat:@"%d", ID];
        alonePersonModel.name = name;
        alonePersonModel.time = time;
        alonePersonModel.content = content;
        alonePersonModel.backGroundImage = backGroundImage;
        alonePersonModel.weather = weather;
        
        [array addObject:alonePersonModel];
    }
    
    //清空存储值对象
    sqlite3_finalize(stmt);
    
    [self closeDataBase];
    
    return array;
}









#pragma mark - 创建一个存放普通日记的表（diaryTable）
//字段（diary_id, diary_time, diary_icon, diary_title, diary_content）

//创建一个普通日记表（diaryTable）
- (void)createDiaryTable
{
    [self openDataBase];
    
    //创建的sql语句
    NSString *sql = @"create table diaryTable (diary_id integer primary key autoincrement not null,diary_time text not null,diary_icon text, diary_title text, diary_content text)";
    
    sqlite3_exec(db, sql.UTF8String, NULL, NULL, NULL);
    
    /*
    if (result == SQLITE_OK) {
        NSLog(@"数据表diaryTable创建成功");
    } else {
        NSLog(@"数据表diaryTable创建失败");
    }
    */
    
    [self closeDataBase];
}

//在该普通日记表（diaryTable）中插入一条数据
- (void)insertToDiaryTableWithOneDiaryModel:(lxyDiaryModel *)diaryModel
{
    [self openDataBase];
    
//    NSInteger ID = diaryModel.diary_id;
    NSString *content = diaryModel.diary_content;
    NSString *time = diaryModel.diary_time;
    NSString *title = diaryModel.diary_title;
    NSString *icon = diaryModel.diary_icon;
    
    NSString *sql = [NSString stringWithFormat:@"insert into diaryTable (diary_time, diary_icon, diary_title, diary_content) values('%@', '%@', '%@', '%@')", time, icon, title, content];
    
    sqlite3_exec(db, sql.UTF8String, NULL, NULL, NULL);
    
    /*
    if (result == SQLITE_OK) {
        NSLog(@"插入diaryModel成功");
    } else {
        NSLog(@"插入diaryModel失败");
    }
     */
    
    [self closeDataBase];
}

//在该普通日记表（diaryTable）中删除一条数据
- (void)deleteOneDiaryModel:(lxyDiaryModel *)diaryModel
{
    [self openDataBase];
    
    NSInteger ID = diaryModel.diary_id;
    
    NSString *sql = [NSString stringWithFormat:@"delete from diaryTable where ID = '%d'", ID];
    
    sqlite3_exec(db, sql.UTF8String, NULL, NULL, NULL);
    
    /*
    if (result == SQLITE_OK) {
        NSLog(@"删除diaryModel成功");
    } else {
        NSLog(@"删除diaryModel失败");
    }
     */
    
    [self closeDataBase];
}

//在该普通日记表（diaryTable）中查询一条数据
- (lxyDiaryModel *)searchOneDiaryModelByTime:(NSString *)time
{
    [self openDataBase];
    
    //创建一个lxySandTimerModel对象
    lxyDiaryModel *diaryModel = [[[lxyDiaryModel alloc] init] autorelease];
    
    //准备存储值的对象
    sqlite3_stmt *stmt = nil;
    
    //准备sql语句
    NSString *sql = [NSString stringWithFormat:@"select diary_id, diary_time, diary_icon, diary_title, diary_content from diaryTable where time = ?"];
    
    //判断sql语句是否正确
    int result = sqlite3_prepare_v2(db, sql.UTF8String, -1, &stmt, NULL);
    
    if (result == SQLITE_OK) {
        
        //绑定要查找的ID
        sqlite3_bind_text(stmt, 1, time.UTF8String, strlen(time.UTF8String), SQLITE_STATIC);
        
        //单步执行，查询表
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            //取ID
            NSInteger ID = sqlite3_column_int(stmt, 0);
            
            //取content
            NSString *content = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 4)];
            
            //取time
            NSString *time = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
            
            //取weather
            NSString *icon = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];
            
            //取mood
            NSString *title = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 3)];
            
            diaryModel.diary_id = ID;
            diaryModel.diary_time = time;
            diaryModel.diary_content = content;
            diaryModel.diary_icon = icon;
            diaryModel.diary_title = title;
            
            //清空存值对象
            sqlite3_finalize(stmt);
        }
    }
    
    //清空存值对象
    sqlite3_finalize(stmt);
    
    
    [self closeDataBase];
    
    return diaryModel;
}

//查询表（diaryTable）中的所有数据
- (NSMutableArray *)searchAllDataFromDiaryTable
{
    [self openDataBase];
    
    //准备返回的可变数组
    NSMutableArray *array = [ NSMutableArray array];
    
    //准备sql语句
    NSString *sql = @"select * from diaryTable";
    
    //准备存储值对象
    sqlite3_stmt *stmt = nil;
    
    sqlite3_prepare(db, sql.UTF8String, -1, &stmt, NULL);
    
    //判断是否可以往下读取
    while (sqlite3_step(stmt) == SQLITE_ROW) {
        
        //准备backGroundImageModel对象
        lxyDiaryModel *diaryModel = [[[lxyDiaryModel alloc] init] autorelease];
        
        //获取ID
        NSInteger ID = sqlite3_column_int(stmt, 0);
        
        //获取time
        NSString *time = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
        
        //获取content
        NSString *content = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 4)];
        
        //获取weather
        NSString *icon = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];
        
        //获取mood
        NSString *title = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 3)];
        
        
        diaryModel.diary_id = ID;
        diaryModel.diary_time = time;
        diaryModel.diary_title = title;
        diaryModel.diary_icon = icon;
        diaryModel.diary_content = content;
        
        [array addObject:diaryModel];
    }
    
    //清空存储值对象
    sqlite3_finalize(stmt);
    
    [self closeDataBase];
    
    return array;
}




#pragma mark - 创建个人沙漏信息表
- (void)createTableWithPeopleNameForTableName:(NSString *)tableName
{
    [self openDataBase];
    
    //创建的sql语句
    NSString *sql = [NSString stringWithFormat:@"create table %@ (ID integer primary key autoincrement,name text not null,time text not null,content text,backGroundImage text,weather text)", tableName];
    
    sqlite3_exec(db, sql.UTF8String, NULL, NULL, NULL);
    
    /*
    if (result == SQLITE_OK) {
        NSLog(@"数据表alonePersonTable创建成功");
    } else {
        NSLog(@"数据表alonePersonTable创建失败");
    }
     */
    
    [self closeDataBase];
}

//在该个个人表中插入一条数据
- (void)insertToAlonePersonTableWithOneAlonePersonModel:(lxyAlonePersonModel *)alonePersonModel
                                                 byName:(NSString *)tableName
{
    [self openDataBase];
    
    NSString *name = tableName;
    NSInteger ID = [alonePersonModel.ID integerValue];
    NSString *time = alonePersonModel.time;
    NSString *content = alonePersonModel.content;
    NSString *backGroundImage = alonePersonModel.backGroundImage;
    NSString *weather = alonePersonModel.weather;
    
    NSString *sql = [NSString stringWithFormat:@"insert into %@ (ID, name, time, content, backGroundImage, weather)values('%d', '%@', '%@', '%@', '%@', '%@')", tableName , ID , name , time , content , backGroundImage , weather];
    
    sqlite3_exec(db, sql.UTF8String, NULL, NULL, NULL);
    
    /*
    if (result == SQLITE_OK) {
        NSLog(@"插入成功");
    } else {
        NSLog(@"插入失败");
    }
     */
    
    [self closeDataBase];

}

//在该个人记录表中删除一条数据
- (void)deleteOneAlonePersonModel:(lxyAlonePersonModel *)alonePersonModel
                           byName:(NSString *)tableName
{
    [self openDataBase];
    
    NSInteger ID = [alonePersonModel.ID integerValue];
    
    NSString *sql = [NSString stringWithFormat:@"delete from %@ where ID = '%d'", tableName , ID];
    
    sqlite3_exec(db, sql.UTF8String, NULL, NULL, NULL);
    
    /*
    if (result == SQLITE_OK) {
        NSLog(@"删除成功");
    } else {
        NSLog(@"删除失败");
    }
     */
    
    [self closeDataBase];
}

//查询表中的所有数据
- (NSMutableArray *)searchAllDataFromalonePersonTableByPersonName:(NSString *)name
{
    [self openDataBase];
    
    //准备返回的可变数组
    NSMutableArray *array = [ NSMutableArray array];
    
    //准备sql语句
    NSString *sql = [NSString stringWithFormat:@"select * from %@", name];
    
    //准备存储值对象
    sqlite3_stmt *stmt = nil;
    
    sqlite3_prepare(db, sql.UTF8String, -1, &stmt, NULL);
    
    //判断是否可以往下读取
    while (sqlite3_step(stmt) == SQLITE_ROW) {
        
        //准备backGroundImageModel对象
        lxyAlonePersonModel *alonePersonModel = [[[lxyAlonePersonModel alloc] init] autorelease];
        
        //获取ID
        NSInteger ID = sqlite3_column_int(stmt, 0);
        
        //获取name
        NSString *name = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
        
        //获取time
        NSString *time = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];
        
        //获取content
        NSString *content = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 3)];
        
        //获取backGroundImage
        NSString *backGroundImage = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 4)];
        
        //获取weather
        NSString *weather = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 5)];
        
        alonePersonModel.ID = [NSString stringWithFormat:@"%d", ID];
        alonePersonModel.name = name;
        alonePersonModel.time = time;
        alonePersonModel.content = content;
        alonePersonModel.backGroundImage = backGroundImage;
        alonePersonModel.weather = weather;
        
        [array addObject:alonePersonModel];
    }
    
    //清空存储值对象
    sqlite3_finalize(stmt);
    
    [self closeDataBase];
    
    return array;
}


#pragma mark - 创建特殊日表
//  字段(sd_id, sd_time, sd_title, sd_icon)

//  创建表
- (void)createSpecialDayTable
{
    [self openDataBase];
    
    //创建的sql语句
    NSString *sql = [NSString stringWithFormat:@"create table specialDayTable (sd_id integer primary key not null,sd_time text not null,sd_title text not null,sd_icon text)"];
    
    sqlite3_exec(db, sql.UTF8String, NULL, NULL, NULL);
    
    /*
    if (result == SQLITE_OK) {
        NSLog(@"数据表specialDayTable创建成功");
    } else {
        NSLog(@"数据表specialDayTable创建失败");
    }
    */
    
    [self closeDataBase];

}

//  插入表数据
- (void)insertToSpecialDayTableWithOneSpecialDayModel:(YCSpecialDayTable *)specialDayModel
{
    [self openDataBase];
    
    NSInteger ID = [specialDayModel.sd_id integerValue];
    NSString *content = specialDayModel.sd_title;
    NSString *time = specialDayModel.sd_time;
    NSString *icon = specialDayModel.sd_icon;
    
    NSString *sql = [NSString stringWithFormat:@"insert into specialDayTable (sd_id, sd_time, sd_title, sd_icon) values('%d', '%@', '%@', '%@')", ID , time , content, icon];
    
    sqlite3_exec(db, sql.UTF8String, NULL, NULL, NULL);
    
    /*
    if (result == SQLITE_OK) {
        NSLog(@"插入specialDayModel成功");
    } else {
        NSLog(@"插入specialDayModel失败");
    }
     */
    
    [self closeDataBase];
}

//  删除表数据
- (void)deleteOneSpecialDayModel:(YCSpecialDayTable *)specialDayModel
{
    [self openDataBase];
    
    NSInteger ID = [specialDayModel.sd_id integerValue];
    
    NSString *sql = [NSString stringWithFormat:@"delete from specialDayTable where sd_id = '%d'", ID];
    
    sqlite3_exec(db, sql.UTF8String, NULL, NULL, NULL);
    
    /*
    if (result == SQLITE_OK) {
        NSLog(@"删除specialDayModel成功");
    } else {
        NSLog(@"删除specialDayModel失败");
    }
     */
    
    [self closeDataBase];
}

//  查询表中的所有数据
- (NSMutableArray *)searchAllDataFromSpecialDayTable
{
    [self openDataBase];
    
    //准备返回的可变数组
    NSMutableArray *array = [ NSMutableArray array];
    
    //准备sql语句
    NSString *sql = @"select * from specialDayTable";
    
    //准备存储值对象
    sqlite3_stmt *stmt = nil;
    
    sqlite3_prepare(db, sql.UTF8String, -1, &stmt, NULL);
    
    //判断是否可以往下读取
    while (sqlite3_step(stmt) == SQLITE_ROW) {
        
        //准备backGroundImageModel对象
        YCSpecialDayTable *specoalDayModel = [[[YCSpecialDayTable alloc] init] autorelease];
        
        //获取ID
        NSInteger ID = sqlite3_column_int(stmt, 0);
        
        //获取time
        NSString *time = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
        
        //获取content
        NSString *content = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];
        
        //获取weather
        NSString *icon = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 3)];
        
        specoalDayModel.sd_id = [NSString stringWithFormat:@"%d", ID];
        specoalDayModel.sd_time = time;
        specoalDayModel.sd_title = content;
        specoalDayModel.sd_icon = icon;
        
        [array addObject:specoalDayModel];
    }
    
    //清空存储值对象
    sqlite3_finalize(stmt);
    
    [self closeDataBase];
    
    return array;
}



@end
