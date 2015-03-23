//
//  lxyDiaryModel.m
//  Model
//
//  Created by 刘翔宇 on 14-6-24.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import "lxyDiaryModel.h"

@implementation lxyDiaryModel

- (void)dealloc
{
    [_diary_content release];
    [_diary_icon release];
    [_diary_time release];
    [_diary_title release];
    
    [super dealloc];
}

- (instancetype)initWithID:(NSInteger)ID
                   andIcon:(NSString *)icon
                  andTitle:(NSString *)title
                andContent:(NSString *)content
                   andTime:(NSString *)time
{
    if (self = [super init]) {
        self.diary_content = content;
        self.diary_icon = icon;
        self.diary_id = ID;
        self.diary_time = time;
        self.diary_title = title;
    }
    return self;
}


@end
