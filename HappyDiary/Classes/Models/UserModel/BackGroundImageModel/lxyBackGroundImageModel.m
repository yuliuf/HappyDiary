//
//  lxyBackGroundImageModel.m
//  DataBase
//
//  Created by 刘翔宇 on 14-6-17.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "lxyBackGroundImageModel.h"

@implementation lxyBackGroundImageModel

- (instancetype)initWithID:(NSString *)ID andImagePath:(NSString *)imagePath
{
    if (self = [super init]) {
        self.ID = ID;
        self.imagePath = imagePath;
    }
    return self;
}

@end
