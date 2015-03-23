//
//  lxyNoteTableModel.m
//  Model
//
//  Created by 刘翔宇 on 14-6-24.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "lxyNoteTableModel.h"

@implementation lxyNoteTableModel

-(void)dealloc
{
    [_note_content release];
    [_note_icon release];
    [_note_image release];
    [_note_time release];
    
    [super dealloc];
}

- (instancetype)initWithNoteID:(NSInteger)noteID
                andHourglassID:(NSInteger)hourglassID
                       andTime:(NSString *)time
                    andContent:(NSString *)content
                       andIcon:(NSString *)icon
                      andImage:(NSString *)image
{
    if (self = [super init]) {
        self.note_content = content;
        self.note_icon = icon;
        self.note_id = noteID;
        self.note_image = image;
        self.note_time = time;
        self.hg_id = hourglassID;
    }
    return self;
}

@end
