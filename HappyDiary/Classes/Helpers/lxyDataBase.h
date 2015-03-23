//
//  lxyDataBase.h
//  DataBase
//
//  Created by 刘翔宇 on 14-6-17.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@class lxySandTimerModel;
@class lxyAlonePersonModel;
@class lxyCommonDiaryModel;
@class lxyBackGroundImageModel;
@class YCSpecialDayTable;
@class lxyUserTableModel;
@class lxyDiaryModel;

@interface lxyDataBase : NSObject


@property (nonatomic , copy) NSString *dataPath;        //存放数据库路径


//获得类对象
+ (lxyDataBase *)shareLxyDataBase;


//打开数据库
- (void)openDataBase;
//关闭数据库
- (void)closeDataBase;






#pragma mark - 沙漏表的创建和操作(sandTimerTable)
//字段（ID：ID  风格：style   背景音乐:backGroundMusic     人名：peopleName）

//创建一个沙漏表（sandTimerTable）
- (void)createSandTimerTable;

//在沙漏表（sandTimerTable）中添加一个沙漏（sandTimerModel）
- (void)insertToSandTimerTableWithOneSandTimerModel:(lxySandTimerModel *)sandTimerModel;

//在沙漏表（sandTimerTable）中删除一个沙漏（sandTimerModel）
- (void)deleteOneSandTimerModel:(lxySandTimerModel *)sandTimerModel;

//在沙漏表（sandTimerTable）中修改一个沙漏（sandTimerModel）
- (void)alertOneSandTimerModelByStyle:(lxySandTimerModel *)sandTimerModel;

//在沙漏表（sandTimerTable）中查询一个沙漏（sandTimerModel）
- (lxySandTimerModel *)searchOneSandTimerModel:(NSInteger)sandTimerModelID;

//查询表（sandTimerTable）中的所有数据
- (NSMutableArray *)searchAllDataFromSandTimerTable;












#pragma mark - 用户表的创建和操作（userTable）
//字段（user_id, user_name, user_pwd, user_birthday, user_headerImage, user_introduction）

//创建用户表（userTable）
- (void)createUserTable;

//插入数据
- (void)insertToUserTableWithOneUserTableModel:(lxyUserTableModel *)userTableModel;

//删除数据
- (void)deleteAllDataFromUserTable;

//修改密码
- (void)alertPassWordWithNewPassWord:(NSString *)passWord;
//修改姓名
- (void)alertNameWithNewName:(NSString *)name;
//修改生日
- (void)alertBirthdayWithNewBirthday:(NSString *)birthday;
//修改头像
- (void)alertHeadImageWithHeadImage:(NSString *)headImage;
//修改介绍
- (void)alertContentWithNewContent:(NSString *)content;

- (void)alertPhoto1WithPhoto:(NSString *)name;

- (void)alertPhoto2WithPhoto:(NSString *)name;


//查询用户表中的数据
- (NSMutableArray *)searchAllDataFromUserTable;







#pragma mark - 背景图片表的创建和操作(backGroundImageTable)
//字段（ID:ID    图片路径：imagePath）

//创建一个背景图片表（backGroundImageTable）
- (void)createBackGroundImageTable;

//在背景图片表（backGroundImageTable）中插入一张图片
- (void)insertToBackGroundImageTableWithOneImage:(lxyBackGroundImageModel *)backGroundImageModel;

//在背景图片表（backGroundImageTable）中删除一张图片
- (void)deleteOneImageWithImageName:(lxyBackGroundImageModel *)backGroundImageModel;

//查询表（backGroundImageTable）中的所有数据
- (NSMutableArray *)searchAllDataFrombackGroundImageTable;

//根据ID查询背景图片表中的一条数据
- (lxyBackGroundImageModel *)searchOneDataFromBackGroundImageTableByID:(NSInteger)ID;









#pragma mark - 创建一个个人记录表（alonePersonTable）
//字段（ID:ID  人名：name    记录的时间：time  记录的内容：content   背景图片：backGroundImage  记录时的天气：weather）

//创建一个个人记录表（alonePersonTable）
- (void)createAlonePersonTable;

//在该个人记录表（alonePersonTable）中插入一条数据
- (void)insertToAlonePersonTableWithOneAlonePersonModel:(lxyAlonePersonModel *)alonePersonModel;

//在该个人记录表（alonePersonTable）中删除一条数据
- (void)deleteOneAlonePersonModel:(lxyAlonePersonModel *)alonePersonModel;

//在该个人记录表（alonePersonTable）中查询一条数据
- (lxyAlonePersonModel *)searchOneAlonePersonModelByAlonePersonModelName:(NSString *)name;

//查询表（alonePersonTable）中的所有数据
- (NSMutableArray *)searchAllDataFromalonePersonTable;












#pragma mark - 创建一个存放普通日记的表（diaryTable）
//字段（diary_id, diary_time, diary_icon, diary_title, diary_content）

//创建一个普通日记表（diaryTable）
- (void)createDiaryTable; 

//在该普通日记表（diaryTable）中插入一条数据
- (void)insertToDiaryTableWithOneDiaryModel:(lxyDiaryModel *)diaryModel;

//在该普通日记表（diaryTable）中删除一条数据
- (void)deleteOneDiaryModel:(lxyDiaryModel *)diaryModel;

//在该普通日记表（diaryTable）中查询一条数据
- (lxyDiaryModel *)searchOneDiaryModelByTime:(NSString *)time;

//查询表（diaryTable）中的所有数据
- (NSMutableArray *)searchAllDataFromDiaryTable;






#pragma mark - 创建个人沙漏信息表
- (void)createTableWithPeopleNameForTableName:(NSString *)tableName;

//在该个个人表中插入一条数据
- (void)insertToAlonePersonTableWithOneAlonePersonModel:(lxyAlonePersonModel *)alonePersonModel
                                                 byName:(NSString *)tableName;

//在该个人记录表中删除一条数据
- (void)deleteOneAlonePersonModel:(lxyAlonePersonModel *)alonePersonModel
                           byName:(NSString *)tableName;

//查询表中的所有数据
- (NSMutableArray *)searchAllDataFromalonePersonTableByPersonName:(NSString *)name;





#pragma mark - 创建特殊日表
//  字段(sd_id, sd_time, sd_title, sd_icon)

//  创建表
- (void)createSpecialDayTable;

//  插入一条表数据
- (void)insertToSpecialDayTableWithOneSpecialDayModel:(YCSpecialDayTable *)specialDayModel;

//  删除一条表数据
- (void)deleteOneSpecialDayModel:(YCSpecialDayTable *)specialDayModel;

//  查询表中的所有数据
- (NSMutableArray *)searchAllDataFromSpecialDayTable;


@end
