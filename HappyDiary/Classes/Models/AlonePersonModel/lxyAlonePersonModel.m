//
//  lxyAlonePersonModel.m
//  DataBase
//
//  Created by 刘翔宇 on 14-6-17.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "lxyAlonePersonModel.h"

@implementation lxyAlonePersonModel

//初始化方法（姓名、记录时间、历史记录内容、当时的心情、当时的天气）
- (instancetype)initWithName:(NSString *)name
                       andID:(NSString *)ID
                     andTime:(NSString *)time
                  andContent:(NSString *)content
                     andbackGroundImage:(NSString *)backGroundImage
                  andWeather:(NSString *)weather
{
    if (self = [super init]) {
        self.ID = ID;
        self.name = name;
        self.content = content;
        self.time = time;
        self.backGroundImage = backGroundImage;
        self.weather = weather;
    }
    return self;
}

@end
