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

@property (nonatomic, strong) lxySandTimerModel *sandModel;

@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UIButton *leftButton;

@property (nonatomic, strong) SZMusic *music;

@end
