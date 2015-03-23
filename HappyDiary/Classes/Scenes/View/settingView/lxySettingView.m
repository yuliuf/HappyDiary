//
//  lxySettingView.m
//  SettingView
//
//  Created by 刘翔宇 on 14-6-22.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import "lxySettingView.h"

#define WIDTHOFLABEL 60
#define HEIGHTOFLABEL 30

@implementation lxySettingView

- (void)dealloc
{
    [_pwdSwitch release];
    
    [_versionsLabel release];
    [_pwdLabel release];
    [_backupLabel release];
    
    [_alertPwdBtn release];
//    [_setPwdBtn release];
    [_backUpBtn release];
    
    [_mimaImageView release];
    [_xiaoxiongImageView release];
    [_backImgView release];
    [_aboutLable release];
    [_aboutTextView release];
    [_aboutButton release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self addAllViews];
        
    }
    return self;
}

//tap手势的懒加载方法
-(UITapGestureRecognizer *)tap
{
    if (nil == _tap) {
        _tap = [[UITapGestureRecognizer alloc] init];
        [self addGestureRecognizer:_tap];
    }
    return _tap;
}

- (void)addAllViews
{
    //初始化密码imageView
    NSString *imagePathGai = [[NSBundle mainBundle] pathForResource:@"mima" ofType:@"png"];
    UIImage *img = [[[UIImage alloc] initWithContentsOfFile:imagePathGai] autorelease];
    self.mimaImageView = [[[UIImageView alloc] initWithImage:img] autorelease];
    _mimaImageView.frame = CGRectMake(_versionsLabel.frame.origin.x, _versionsLabel.frame.origin.y + _versionsLabel.frame.size.height, WIDTHOFLABEL, HEIGHTOFLABEL + 50);
    [self addSubview:_mimaImageView];
    
    //给该设置页面添加背景图片
    imagePathGai = [[NSBundle mainBundle] pathForResource:@"blueSky" ofType:@"png"];
    UIImage *backImg = [[[UIImage alloc] initWithContentsOfFile:imagePathGai] autorelease];
    self.backImgView = [[[UIImageView alloc] initWithImage:backImg] autorelease];
    _backImgView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    [self addSubview:_backImgView];
    _backImgView.userInteractionEnabled = YES;

//  密码
    UIImageView *pwdImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"diary_setting_password_bg_lockicon"]];
    pwdImageView.frame = Rect(50, 80, 30, 25);
    pwdImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:pwdImageView];
    [pwdImageView release];
    
    UILabel *pwdLabel = [[UILabel alloc] initWithFrame:Rect(MaxX(pwdImageView.frame) + 10, MinY(pwdImageView.frame), 40, 25)];
    pwdLabel.text = @"密码";

    pwdLabel.font = myZiti;
    [self addSubview:pwdLabel];
    [pwdLabel release];
    
    
    //版本
    UIImageView *versionImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"deco_sticker_mygom_tap_on"]];
    versionImageView.frame = Rect(MinX(pwdImageView.frame), MaxY(pwdImageView.frame) + 20, 30, 25);
    [self addSubview:versionImageView];
    [versionImageView release];

    
    self.versionsLabel = [self createLabelWithName:@"版本 rainbowYu 1.0.0.1" andFrame:CGRectMake(MinX(pwdLabel.frame) , MinY(versionImageView.frame) , 200 , 25)];
    self.versionsLabel.numberOfLines = 0;
    _versionsLabel.textAlignment= NSTextAlignmentLeft;
    self.versionsLabel.font = myZiti;
    [self addSubview:_versionsLabel];
    
    
    //  新手指引
    
    UIImageView *fresherImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xinshou"]];
    fresherImageView.frame = Rect(MinX(pwdImageView.frame), MaxY(versionImageView.frame) + 20, 30, 25);
    fresherImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:fresherImageView];
    [fresherImageView release];
    
    
    self.aboutButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.aboutButton.frame = CGRectMake(MaxX(fresherImageView.frame), MinY(fresherImageView.frame), 100, 25);
    [self.aboutButton setTitle:@"新手指引" forState:UIControlStateNormal];
    self.aboutButton.titleLabel.font = [UIFont fontWithName:ziti size:17.f];
    self.aboutButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.aboutButton.tintColor = [UIColor blackColor];
    [self addSubview:_aboutButton];


    

    
    //初始化密码开关
    self.pwdSwitch = [[[UISwitch alloc] initWithFrame:CGRectMake(self.bounds.size.width - 80, MinY(pwdLabel.frame), 40, 25)] autorelease];
    [_pwdSwitch setOn:NO];
    [self addSubview:_pwdSwitch];
    
//    self.pwdButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    _pwdButton.frame = Rect(self.bounds.size.width - 80, MinY(pwdLabel.frame), 40, 25);
//    [_pwdButton setBackgroundImage:[UIImage imageNamed:@"diary_setting_switch_off"] forState:UIControlStateNormal];
//    [self addSubview:_pwdButton];
    
    

//    
//    //初始化备份button
//    self.backUpBtn = [self createButtonWithName:@"备份" andFrame:CGRectMake(_setPwdBtn.frame.origin.x, _setPwdBtn.frame.origin.y + _setPwdBtn.frame.size.height, _setPwdBtn.frame.size.width, _setPwdBtn.frame.size.height)];
////    _backUpBtn.hidden = YES;
//    [self addSubview:_backUpBtn];
    
    
    //初始化修改密码button
    self.alertPwdBtn = [self createButtonWithName:@"修改密码" andFrame:CGRectMake(MaxX(pwdLabel.frame) + 10 , MinY(pwdLabel.frame) , 80 ,30)];
    self.alertPwdBtn.tintColor = [UIColor blackColor];
    self.alertPwdBtn.hidden = YES;
    [_backImgView addSubview:_alertPwdBtn];
    
//    //初始化设置密码button
//    self.setPwdBtn = [self createButtonWithName:@"设置密码" andFrame: _alertPwdBtn.frame];
//    NSLog(@"%@", NSStringFromCGRect(self.setPwdBtn.frame));
//    self.setPwdBtn.tintColor = [UIColor blackColor];
//    [_backImgView addSubview:_setPwdBtn];
    
    
    //添加旁边的小熊图片
    imagePathGai = [[NSBundle mainBundle] pathForResource:@"xiaoxiaong" ofType:@"png"];
    UIImage *imageGai = [[[UIImage alloc] initWithContentsOfFile:imagePathGai] autorelease];
    self.xiaoxiongImageView = [[[UIImageView alloc] initWithImage:imageGai] autorelease];
    self.xiaoxiongImageView.frame = CGRectMake(0, 180, 0, 100);
    [self.backImgView addSubview:_xiaoxiongImageView];
    
    
    self.aboutLable = [[UILabel alloc] initWithFrame:CGRectMake(120, self.bounds.size.height - 120, 80, 30)];
    self.aboutLable.text = @"关于我们";
    self.aboutLable.font = myZiti;
    [self addSubview:_aboutLable];
    [_aboutLable release];
    
    
    
    
    self.aboutTextView = [[UITextView alloc] initWithFrame:CGRectMake(100, self.bounds.size.height - 90, 120, 80)];
    self.aboutTextView.text = @"QQ:979511280\nPhone:18511288089\nCopy right:rainbowYu";
    self.aboutTextView.textAlignment = NSTextAlignmentCenter;
    self.aboutTextView.textColor = [UIColor blackColor];
    self.aboutTextView.backgroundColor = [UIColor clearColor];
    self.aboutTextView.userInteractionEnabled = NO;
    self.aboutTextView.font = myZiti;
    [self addSubview:_aboutTextView];
    [_aboutTextView release];

}

#pragma mark -动画延迟

//创建label
- (UILabel *)createLabelWithName:(NSString *)name
                        andFrame:(CGRect)frame
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = name;
    label.textAlignment = NSTextAlignmentCenter;
    return [label autorelease];
}
//创建button
- (UIButton *)createButtonWithName:(NSString *)name
                          andFrame:(CGRect)frame
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = frame;
    [button setTitle:name forState:UIControlStateNormal];
    button.hidden = YES;
    button.titleLabel.font = [UIFont fontWithName:@"LiDeBiao-Xing-3.0" size:17.f];
    return button;
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
