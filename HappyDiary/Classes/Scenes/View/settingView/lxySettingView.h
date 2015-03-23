//
//  lxySettingView.h
//  SettingView
//
//  Created by 刘翔宇 on 14-6-22.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface lxySettingView : UIView

@property (nonatomic , retain) UISwitch *pwdSwitch;         //密码开关switch
//@property (nonatomic, retain) UIButton *pwdButton;

@property (nonatomic , retain) UILabel *versionsLabel;           //版本label
@property (nonatomic , retain) UILabel *pwdLabel;                //密码label
@property (nonatomic , retain) UILabel *backupLabel;            //备份label

@property (nonatomic , retain) UIButton *alertPwdBtn;           //修改密码button
//@property (nonatomic , retain) UIButton *setPwdBtn;             //设置密码button
@property (nonatomic , retain) UIButton *backUpBtn;             //备份button

@property (nonatomic , retain) UIImageView *mimaImageView;

@property (nonatomic , assign) UITapGestureRecognizer *tap;     //添加轻怕的监听手势

@property (nonatomic , retain) UIImageView *xiaoxiongImageView; //旁边的小熊图片

@property (nonatomic , retain) UIImageView *backImgView;        //背景图片


@property (nonatomic, retain) UILabel *aboutLable;
@property (nonatomic, retain) UITextView *aboutTextView;
@property (nonatomic, retain) UIButton *aboutButton;

@end
