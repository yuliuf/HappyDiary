//
//  YCSpecialDayTable.m
//  HappyDiary
//
//  Created by 孙震 on 14-6-26.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import "YCSpecialDayTable.h"

@implementation YCSpecialDayTable


- (instancetype)initWithID:(NSString *)ID time:(NSString *)time title:(NSString *)title icon:(NSString *)icon
{
    self = [super init];
    if (self) {
        self.sd_icon = icon;
        self.sd_id = ID;
        self.sd_time = time;
        self.sd_title = title;
    }
    return self;
}

@end
