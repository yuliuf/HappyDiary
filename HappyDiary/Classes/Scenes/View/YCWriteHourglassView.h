//
//  YCWriteHourglassView.h
//  HappyDiary
//
//  Created by 孙震 on 14-6-20.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCWriteHourglassView : UIView

@property (nonatomic, retain) UITextView *textView;

@property (nonatomic, assign) UITapGestureRecognizer *tapGR;
@property (nonatomic, retain) UIButton *changeImageButton;
@property (nonatomic, retain) UIImageView *bgImageView;

@property (nonatomic, retain) UIImageView *backImageView;

@end
