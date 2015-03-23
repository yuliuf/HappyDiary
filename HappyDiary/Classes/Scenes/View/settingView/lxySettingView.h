//
//  lxySettingView.h
//  SettingView
//
//  Created by 刘翔宇 on 14-6-22.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface lxySettingView : UIView

@property (nonatomic , strong) UISwitch *pwdSwitch;         //密码开关switch
//@property (nonatomic, retain) UIButton *pwdButton;

@property (nonatomic , strong) UILabel *versionsLabel;           //版本label
@property (nonatomic , strong) UILabel *pwdLabel;                //密码label
@property (nonatomic , strong) UILabel *backupLabel;            //备份label

@property (nonatomic , strong) UIButton *alertPwdBtn;           //修改密码button
//@property (nonatomic , retain) UIButton *setPwdBtn;             //设置密码button
@property (nonatomic , strong) UIButton *backUpBtn;             //备份button

@property (nonatomic , strong) UIImageView *mimaImageView;

@property (nonatomic , strong) UITapGestureRecognizer *tap;     //添加轻怕的监听手势

@property (nonatomic , strong) UIImageView *xiaoxiongImageView; //旁边的小熊图片

@property (nonatomic , strong) UIImageView *backImgView;        //背景图片


@property (nonatomic, strong) UILabel *aboutLable;
@property (nonatomic, strong) UITextView *aboutTextView;
@property (nonatomic, strong) UIButton *aboutButton;

@end
