//
//  LYLockView.m
//  HappyDiary
//
//  Created by liuyu on 14-7-1.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "LYLockView.h"

@implementation LYLockView
-(void)dealloc
{
    [_lockImageView release];
    [_pwdTextField release];
    [_backgroundImageView release];
    [_alertLabel release];
    
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        [self addAllViews];
    }
    return self;
}

- (void)addAllViews
{
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"cover" ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    self.backgroundImageView = [[[UIImageView alloc] initWithImage:image] autorelease];
    _backgroundImageView.userInteractionEnabled = YES;
    _backgroundImageView.frame = self.bounds;
    [self addSubview:_backgroundImageView];
    
    NSString *imagePath1 = [[NSBundle mainBundle] pathForResource:@"lock" ofType:@"png"];
    self.lockImageView = [[[LYButtonImageView alloc] initWithFrame:Rect(ScreenWidth - 50, ScreenHeight / 2, 50, 50)] autorelease];
    _lockImageView.image = [UIImage imageWithContentsOfFile:imagePath1];
    [self addSubview:_lockImageView];
    
    
    self.pwdTextField = [[[UITextField alloc] initWithFrame:Rect(85, 100, 130, 30)] autorelease];
    _pwdTextField.borderStyle = UITextBorderStyleRoundedRect;
    _pwdTextField.secureTextEntry = YES;
    _pwdTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self addSubview:_pwdTextField];
    
    self.alertLabel = [[[UILabel alloc] initWithFrame:Rect(MinX(_pwdTextField.frame), MaxY(_pwdTextField.frame) + 10, 150, 20)] autorelease];
    self.alertLabel.font = myZiti;
    self.alertLabel.alpha = 0.f;
    [self addSubview:_alertLabel];
    
}

-(UITapGestureRecognizer *)tap
{
    if (_tap == nil) {
        _tap = [[UITapGestureRecognizer alloc] init];
        [self.backgroundImageView addGestureRecognizer:_tap];
    }
    return _tap;
}

@end
