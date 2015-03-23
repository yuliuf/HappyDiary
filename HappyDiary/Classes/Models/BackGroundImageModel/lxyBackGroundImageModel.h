//
//  lxyBackGroundImageModel.h
//  DataBase
//
//  Created by 刘翔宇 on 14-6-17.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface lxyBackGroundImageModel : NSObject

@property (nonatomic , copy) NSString *ID;      //ID
@property (nonatomic , copy) NSString *imagePath;       //图片路径


- (instancetype)initWithID:(NSString *)ID
              andImagePath:(NSString *)imagePath;

@end
