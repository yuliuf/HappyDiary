//
//  lxySpecialDayTableModel.h
//  Model
//
//  Created by 刘翔宇 on 14-6-24.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface lxySpecialDayTableModel : NSObject

@property (nonatomic , assign) NSInteger sd_id;
@property (nonatomic , retain) NSString *sd_time;
@property (nonatomic , retain) NSString *sd_title;
@property (nonatomic , retain) NSString *sd_icon;

- (instancetype)initWithID:(NSInteger)ID
                   andTime:(NSString *)time
                  andTitle:(NSString *)title
                   andIcon:(NSString *)icon;

@end
