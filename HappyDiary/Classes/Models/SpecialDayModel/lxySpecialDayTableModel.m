//
//  lxySpecialDayTableModel.m
//  Model
//
//  Created by 刘翔宇 on 14-6-24.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "lxySpecialDayTableModel.h"

@implementation lxySpecialDayTableModel

- (void)dealloc
{
    [_sd_icon release];
    [_sd_time release];
    [_sd_title release];
    
    [super dealloc];
}

- (instancetype)initWithID:(NSInteger)ID
                   andTime:(NSString *)time
                  andTitle:(NSString *)title
                   andIcon:(NSString *)icon
{
    if (self = [super init]) {
        self.sd_icon = icon;
        self.sd_id = ID;
        self.sd_time = time;
        self.sd_title = title;
    }
    return self;
}

@end
