//
//  YCSpecialDayTable.h
//  HappyDiary
//
//  Created by 孙震 on 14-6-26.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YCSpecialDayTable : NSObject

@property (nonatomic, strong) NSString *sd_id;
@property (nonatomic, strong) NSString *sd_time;
@property (nonatomic, strong) NSString *sd_title;
@property (nonatomic, strong) NSString *sd_icon;

- (instancetype)initWithID:(NSString *)ID time:(NSString *)time title:(NSString *)title icon:(NSString *)icon;

@end
