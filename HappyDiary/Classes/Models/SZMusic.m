//
//  SZMusic.m
//  MusicDemo
//
//  Created by 孙震 on 14-6-10.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import "SZMusic.h"

@implementation SZMusic


- (id)initWithName:(NSString *)name type:(NSString *)type
{
    self = [super init];
    if (self) {
        self.name = name;
        self.type = type;
    }
    return self;
}

@end
