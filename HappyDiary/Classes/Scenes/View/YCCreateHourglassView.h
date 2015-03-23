//
//  YCCreateHourglassView.h
//  HappyDiary
//
//  Created by 孙震 on 14-6-20.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCCreateHourglassView : UIView

@property (nonatomic, strong) UILabel *headerLable;
@property (nonatomic, strong) UISegmentedControl *segment;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *saveButton;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, strong) UIButton *playButton;
@property (nonatomic, strong) UISlider *volumeSlider;
@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UIButton *voice;

@end
