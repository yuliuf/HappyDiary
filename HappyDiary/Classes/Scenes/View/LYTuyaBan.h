//
//  LYTuyaBan.h
//  HappyDiary
//
//  Created by liuyu on 14-6-27.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYTuyaView.h"
#import "LYMoveImageView.h"
//#import "YCjiePingView.h"

@interface LYTuyaBan : LYMoveImageView


@property (nonatomic, retain)LYTuyaView *tuyaView;
@property (nonatomic, retain) UIButton *saveButton; //  保存涂鸦按钮
@property (nonatomic, retain) UIButton *cancleButton;//  取消按钮
@property (nonatomic, retain) UIButton *deleteButton;//  回删按钮
@property (nonatomic, retain) UIButton *editButton;//  编辑按钮


@end