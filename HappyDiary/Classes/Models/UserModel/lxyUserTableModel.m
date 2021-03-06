//
//  lxyUserTableModel.m
//  Model
//
//  Created by 刘翔宇 on 14-6-24.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "lxyUserTableModel.h"

@implementation lxyUserTableModel

- (void)dealloc
{
    [_user_birthday release];
    [_user_headerImage release];
    [_user_introduce release];
    [_user_name release];
    [_user_pwd release];
    
    [super dealloc];
}

- (instancetype)initWithID:(NSInteger)ID
                   andName:(NSString *)name
                    andPWD:(NSString *)pwd
               andBirthday:(NSString *)birthday
            andHeaderImage:(NSString *)headerImage
              andIntroduce:(NSString *)introduce
{
    if (self = [super init]) {
        self.user_birthday = birthday;
        self.user_headerImage = headerImage;
        self.user_id = ID;
        self.user_introduce = introduce;
        self.user_name = name;
        self.user_pwd = pwd;
    }
    return self;
}

@end
