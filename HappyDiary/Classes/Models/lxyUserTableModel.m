//
//  lxyUserTableModel.m
//  Model
//
//  Created by 刘翔宇 on 14-6-24.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import "lxyUserTableModel.h"

@implementation lxyUserTableModel


- (instancetype)initWithID:(NSInteger)ID
                   andName:(NSString *)name
                    andPWD:(NSString *)pwd
               andBirthday:(NSString *)birthday
            andHeaderImage:(NSString *)headerImage
              andIntroduce:(NSString *)introduce
                 andPhoto1:(NSString *)photo1
                 andPhoto2:(NSString *)photo2
{
    if (self = [super init]) {
        self.user_birthday = birthday;
        self.user_headerImage = headerImage;
        self.user_id = ID;
        self.user_introduce = introduce;
        self.user_name = name;
        self.user_pwd = pwd;
        self.user_photo1 = photo1;
        self.user_photo2 = photo2;
    }
    return self;
}

@end
