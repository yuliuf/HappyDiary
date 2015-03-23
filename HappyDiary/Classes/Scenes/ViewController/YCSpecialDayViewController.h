//
//  YCSpecialDayViewController.h
//  HappyDiary
//
//  Created by 孙震 on 14-6-25.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCSpecialDayViewController : UIViewController

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UITextView *detailTextView;
@property (nonatomic, strong) UITextField *timeTextField;
@property (nonatomic, strong) UIButton *saveButton;
@property (nonatomic, strong) UIButton *cancleButton;

@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UIButton *leftButton;

@end
