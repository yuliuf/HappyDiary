//
//  lxyAlonePersonModel.h
//  DataBase
//
//  Created by 刘翔宇 on 14-6-17.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface lxyAlonePersonModel : NSObject

@property (nonatomic , copy) NSString *name;        //姓名
@property (nonatomic , copy) NSString *time;        //记录时间
@property (nonatomic , copy) NSString *content;     //历史日记内容
@property (nonatomic , copy) NSString *backGroundImage;        //当时的心情
@property (nonatomic , copy) NSString *weather;     //当时的天气
@property (nonatomic , copy) NSString *ID;           //ID


//初始化方法（姓名、记录时间、历史记录内容、当时的心情、当时的天气）
- (instancetype)initWithName:(NSString *)name
                       andID:(NSString *)ID
                     andTime:(NSString *)time
                  andContent:(NSString *)content
                     andbackGroundImage:(NSString *)backGroundImage
                  andWeather:(NSString *)weather;

@end
