//
//  LYTuyaBan.m
//  HappyDiary
//
//  Created by liuyu on 14-6-27.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import "LYTuyaBan.h"

@implementation LYTuyaBan

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addAllViews];
        self.tuyaView = [[LYTuyaView alloc] initWithFrame:Rect(0, 0, frame.size.width, frame.size.height - 20)];
        self.tuyaView.layer.borderColor = [[UIColor redColor] CGColor];
        self.tuyaView.layer.borderWidth = .9;
        self.userInteractionEnabled = YES;
        [self addSubview:_tuyaView];
        
    }
    return self;
}

- (void) addAllViews
{
    self.cancleButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _cancleButton.frame = CGRectMake(0 ,self.bounds.size.height - 20, 20, 20);
    [_cancleButton setTitle:@"×" forState:UIControlStateNormal];
    [self addSubview:_cancleButton];
    
    self.saveButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _saveButton.frame = CGRectMake(MaxX(_cancleButton.frame) ,self.bounds.size.height - 20, 20, 20);
    [_saveButton setTitle:@"√" forState:UIControlStateNormal];
    [self addSubview:_saveButton];
    
    self.deleteButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _deleteButton.frame = CGRectMake(MaxX(_saveButton.frame) ,self.bounds.size.height - 20, 20, 20);
    [_deleteButton setTitle:@"<-" forState:UIControlStateNormal];
    [self addSubview:_deleteButton];
    
    self.editButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _editButton.frame = CGRectMake(self.bounds.size.width - 15 ,self.bounds.size.height - 20, 15, 20);
    [_editButton setTitle:@"*" forState:UIControlStateNormal];
    _editButton.hidden = YES;
    [self addSubview:_editButton];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
