//
//  YCDetailHourglassViewController.h
//  Diary
//
//  Created by 孙震 on 14-6-19.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class lxySandTimerModel;
@class SZMusic;

@interface YCDetailHourglassViewController : UIViewController

@property (nonatomic, retain) lxySandTimerModel *sandModel;

@property (nonatomic, retain) UIButton *rightButton;
@property (nonatomic, retain) UIButton *leftButton;

@property (nonatomic, retain) SZMusic *music;

@end
