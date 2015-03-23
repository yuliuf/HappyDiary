//
//  YCSpecialDayTable.h
//  HappyDiary
//
//  Created by 孙震 on 14-6-26.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YCSpecialDayTable : NSObject

@property (nonatomic, retain) NSString *sd_id;
@property (nonatomic, retain) NSString *sd_time;
@property (nonatomic, retain) NSString *sd_title;
@property (nonatomic, retain) NSString *sd_icon;

- (instancetype)initWithID:(NSString *)ID time:(NSString *)time title:(NSString *)title icon:(NSString *)icon;

@end
