//
//  lxyPersonDataView.h
//  EventController
//
//  Created by 刘翔宇 on 14-6-20.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface lxyPersonDataView : UIView

@property (nonatomic , retain) UIButton *monthlyButton1;

@property (nonatomic , retain) UIButton *weeklyButton1;

@property (nonatomic , retain) UIButton *dailyButton1;

@property (nonatomic , retain) UIButton *personDataButton2;

@property (nonatomic , retain) UIImageView *imageView;

@property (nonatomic , retain) UIImageView *imageViewTitle;

//@property (nonatomic , retain) UIScrollView *scroller;


@property (nonatomic, retain) UIButton *editBtn;  // 编辑按钮
@property (nonatomic, retain) UIImageView *headerIcon; // 头像
@property (nonatomic, retain) UITextField *name;  // 姓名
@property (nonatomic, retain) UITextField *birthday; // 生日
@property (nonatomic, retain) UITextView *introduce; //  个人介绍

@property (nonatomic , retain) UITapGestureRecognizer *tap;     //轻拍事件
@property (nonatomic , retain) UITapGestureRecognizer *tapHeadIcon;     //给头像图片添加一个轻拍手势

@property (nonatomic , retain) UIButton *personDataBackButton;




@end
