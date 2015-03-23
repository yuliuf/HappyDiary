//
//  lxyEventViewController.h
//  EventController
//
//  Created by 刘翔宇 on 14-6-20.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class lxyMonthlyView;
@class lxyWeeklyView;
@class lxyDailyView;
@class lxyPersonDataView;
@class lxyBaseView;


@interface lxyEventViewController : LYBaseViewController <UICollectionViewDelegate>
{
    NSDate *dtForMonth;
    int originX,originY;
}

-(void)createCalendar;


@property (nonatomic , strong) lxyMonthlyView *monthlyView;
@property (nonatomic , strong) lxyWeeklyView *weeklyView;
@property (nonatomic , strong) lxyDailyView *dailyView;
@property (nonatomic , strong) lxyPersonDataView *personDataView;

@property (nonatomic , strong) lxyBaseView *baseView;


@property (nonatomic , assign) CGRect frame;        //保存frame
@property (nonatomic , assign) CGFloat height;
@property (nonatomic , assign) CGPoint touchPoint;  //点击屏幕的位置
@property (nonatomic , strong) UITapGestureRecognizer *tapHeadIcon;     //给头像图片添加一个轻拍手势

@end
