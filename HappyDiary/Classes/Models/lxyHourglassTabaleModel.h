//
//  lxyHourglassTabaleModel.h
//  Model
//
//  Created by 刘翔宇 on 14-6-24.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface lxyHourglassTabaleModel : NSObject

@property (nonatomic , assign) NSInteger hg_id;
@property (nonatomic , retain) NSString *hg_name;
@property (nonatomic , retain) NSString *hg_time;
@property (nonatomic , retain) NSString *hg_image;
@property (nonatomic , retain) NSString *hg_music;

- (instancetype)initWithID:(NSInteger)ID
                   andName:(NSString *)name
                   andTime:(NSString *)time
                  andImage:(NSString *)image
                  andMusic:(NSString *)music;

@end
