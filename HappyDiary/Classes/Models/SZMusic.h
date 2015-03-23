//
//  SZMusic.h
//  MusicDemo
//
//  Created by 孙震 on 14-6-10.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SZMusic : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *type;

- (id)initWithName:(NSString *)name type:(NSString *)type;
@end
