//
//  lxyNoteTableModel.h
//  Model
//
//  Created by 刘翔宇 on 14-6-24.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface lxyNoteTableModel : NSObject

@property (nonatomic , assign) NSInteger note_id;
@property (nonatomic , retain) NSString *note_time;
@property (nonatomic , retain) NSString *note_content;
@property (nonatomic , retain) NSString *note_icon;
@property (nonatomic , retain) NSString *note_image;
@property (nonatomic , assign) NSInteger hg_id;

- (instancetype)initWithNoteID:(NSInteger)noteID
                andHourglassID:(NSInteger)hourglassID
                       andTime:(NSString *)time
                    andContent:(NSString *)content
                       andIcon:(NSString *)icon
                      andImage:(NSString *)image;

@end
