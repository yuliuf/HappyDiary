//
//  lxyPersonDataView.h
//  EventController
//
//  Created by 刘翔宇 on 14-6-20.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface lxyPersonDataView : UIView

@property (nonatomic , strong) UIButton *monthlyButton1;

@property (nonatomic , strong) UIButton *weeklyButton1;

@property (nonatomic , strong) UIButton *dailyButton1;

@property (nonatomic , strong) UIButton *personDataButton2;

@property (nonatomic , strong) UIImageView *imageView;

@property (nonatomic , strong) UIImageView *imageViewTitle;

//@property (nonatomic , retain) UIScrollView *scroller;


@property (nonatomic, strong) UIButton *editBtn;  // 编辑按钮
@property (nonatomic, strong) UIImageView *headerIcon; // 头像
@property (nonatomic, strong) UITextField *name;  // 姓名
@property (nonatomic, strong) UITextField *birthday; // 生日
@property (nonatomic, strong) UITextView *introduce; //  个人介绍

@property (nonatomic , strong) UITapGestureRecognizer *tap;     //轻拍事件
@property (nonatomic , strong) UITapGestureRecognizer *tapHeadIcon;     //给头像图片添加一个轻拍手势

@property (nonatomic , strong) UIButton *personDataBackButton;




@end
