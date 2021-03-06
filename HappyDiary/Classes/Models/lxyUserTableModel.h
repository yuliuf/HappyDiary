//
//  lxyUserTableModel.h
//  Model
//
//  Created by 刘翔宇 on 14-6-24.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface lxyUserTableModel : NSObject

@property (nonatomic , assign) NSInteger user_id;
@property (nonatomic , strong) NSString *user_name;
@property (nonatomic , strong) NSString *user_pwd;
@property (nonatomic , strong) NSString *user_birthday;
@property (nonatomic , strong) NSString *user_headerImage;
@property (nonatomic , strong) NSString *user_introduce;
@property (nonatomic , strong) NSString *user_photo1;
@property (nonatomic, strong) NSString *user_photo2;


- (instancetype)initWithID:(NSInteger)ID
                   andName:(NSString *)name
                    andPWD:(NSString *)pwd
               andBirthday:(NSString *)birthday
            andHeaderImage:(NSString *)headerImage
              andIntroduce:(NSString *)introduce
                 andPhoto1:(NSString *)photo1
                 andPhoto2:(NSString *)photo2;


@end
