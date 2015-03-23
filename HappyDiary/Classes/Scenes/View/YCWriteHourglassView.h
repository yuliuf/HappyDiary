//
//  YCWriteHourglassView.h
//  HappyDiary
//
//  Created by 孙震 on 14-6-20.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCWriteHourglassView : UIView

@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, strong) UITapGestureRecognizer *tapGR;
@property (nonatomic, strong) UIButton *changeImageButton;
@property (nonatomic, strong) UIImageView *bgImageView;

@property (nonatomic, strong) UIImageView *backImageView;

@end
