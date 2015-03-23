//
//  YCWriteHourglassViewController.h
//  Diary
//
//  Created by 孙震 on 14-6-19.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class lxySandTimerModel;

@interface YCWriteHourglassViewController : UIViewController

@property (nonatomic, strong) lxySandTimerModel *sandModel;

@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UIButton *leftButton;

@end
