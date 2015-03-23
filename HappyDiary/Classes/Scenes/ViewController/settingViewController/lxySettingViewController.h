//
//  lxySettingViewController.h
//  SettingView
//
//  Created by 刘翔宇 on 14-6-22.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class lxySettingView;

@interface lxySettingViewController : LYBaseViewController

@property (nonatomic , strong) lxySettingView *stView;          //设置页面

@property (nonatomic , strong) UILabel *oldPwdLabel;            //原密码label
@property (nonatomic , strong) UITextField *oldPwdText;         //原密码text

//@property (nonatomic , retain) UILabel *newPwd;            //新密码label
//@property (nonatomic , retain) UITextField *newPwdField;         //新密码text

@property (nonatomic , strong) UIButton *confirmBtn;            //保存按钮
@property (nonatomic , strong) UIButton *concelBtn;             //取消按钮

@property (nonatomic , strong) UIView *alertPwdView;            //修改密码的view
@property (nonatomic , strong) UIView *setPwdView;              //设置密码的view

@property (nonatomic , strong) UIImageView *xiaoxiongImageView; //小熊ImageView



@end
