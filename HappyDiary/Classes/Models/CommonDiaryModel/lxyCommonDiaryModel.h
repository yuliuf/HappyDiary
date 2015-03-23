//
//  lxyCommonDiaryModel.h
//  DataBase
//
//  Created by 刘翔宇 on 14-6-17.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface lxyCommonDiaryModel : NSObject

@property (nonatomic , copy) NSString *content;     //日记内容
@property (nonatomic , copy) NSString *time;        //写日记时间
@property (nonatomic , copy) NSString *ID;          //ID
@property (nonatomic , copy) NSString *weather;     //天气
@property (nonatomic , copy) NSString *backGroundImage;     //背景图片
@property (nonatomic , copy) NSString *mood;        //心情



//初始化方法(时间、内容)
- (instancetype)initWithContent:(NSString *)content
                          andID:(NSString *)ID
                        andTime:(NSString *)time
                     andWeather:(NSString *)weather
             andBackGroundImage:(NSString *)backGroundImage
                        andMood:(NSString *)mood;

@end
