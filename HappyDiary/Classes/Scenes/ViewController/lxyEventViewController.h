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


@property (nonatomic , retain) lxyMonthlyView *monthlyView;
@property (nonatomic , retain) lxyWeeklyView *weeklyView;
@property (nonatomic , retain) lxyDailyView *dailyView;
@property (nonatomic , retain) lxyPersonDataView *personDataView;

@property (nonatomic , retain) lxyBaseView *baseView;


@property (nonatomic , assign) CGRect frame;        //保存frame
@property (nonatomic , assign) CGFloat height;
@property (nonatomic , assign) CGPoint touchPoint;  //点击屏幕的位置
@property (nonatomic , retain) UITapGestureRecognizer *tapHeadIcon;     //给头像图片添加一个轻拍手势

@end
