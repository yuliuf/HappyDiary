//
//  lxyDiaryModel.h
//  Model
//
//  Created by 刘翔宇 on 14-6-24.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface lxyDiaryModel : NSObject

@property (nonatomic , assign) NSInteger diary_id;
@property (nonatomic , strong) NSString *diary_icon;
@property (nonatomic , strong) NSString *diary_title;
@property (nonatomic , strong) NSString *diary_content;
@property (nonatomic , strong) NSString *diary_time;

- (instancetype)initWithID:(NSInteger)ID
                   andIcon:(NSString *)icon
                  andTitle:(NSString *)title
                andContent:(NSString *)content
                   andTime:(NSString *)time;


@end
