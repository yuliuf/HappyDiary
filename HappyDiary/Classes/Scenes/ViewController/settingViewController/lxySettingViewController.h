//
//  lxySettingViewController.h
//  SettingView
//
//  Created by 刘翔宇 on 14-6-22.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

@class lxySettingView;

@interface lxySettingViewController : LYBaseViewController

@property (nonatomic , retain) lxySettingView *stView;          //设置页面

@property (nonatomic , retain) UILabel *oldPwdLabel;            //原密码label
@property (nonatomic , retain) UITextField *oldPwdText;         //原密码text

@property (nonatomic , retain) UILabel *newPwdLabel;            //新密码label
@property (nonatomic , retain) UITextField *newPwdText;         //新密码text

@property (nonatomic , retain) UIButton *confirmBtn;            //保存按钮
@property (nonatomic , retain) UIButton *concelBtn;             //取消按钮

@property (nonatomic , retain) UIView *alertPwdView;            //修改密码的view
@property (nonatomic , retain) UIView *setPwdView;              //设置密码的view

@property (nonatomic , retain) UIImageView *xiaoxiongImageView; //小熊ImageView



@end
