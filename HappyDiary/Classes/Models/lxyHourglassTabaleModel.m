//
//  lxyHourglassTabaleModel.m
//  Model
//
//  Created by 刘翔宇 on 14-6-24.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import "lxyHourglassTabaleModel.h"

@implementation lxyHourglassTabaleModel


- (instancetype)initWithID:(NSInteger)ID
                   andName:(NSString *)name
                   andTime:(NSString *)time
                  andImage:(NSString *)image
                  andMusic:(NSString *)music
{
    if (self = [super init]) {
        self.hg_id = ID;
        self.hg_image = image;
        self.hg_music = music;
        self.hg_name = name;
        self.hg_time = time;
    }
    return self;
}

@end
