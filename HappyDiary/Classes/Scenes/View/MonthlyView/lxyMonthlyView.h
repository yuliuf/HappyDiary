//
//  lxyMonthlyView.h
//  EventController
//
//  Created by 刘翔宇 on 14-6-20.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YCCalendarView.h"

#define Width_View 320
#define Height_View 480
#define Static_Y_Space 80
#define Width_calendarView 144
#define Height_calendarView 144
#define Minus_month_for_Previous_Action 1
#define Seconds_of_Minute 60
#define Minutes_of_Hour 60
#define Hours_of_Day 24
#define Origin_of_calendarView 78
#define Width_Allocated_for_CalendarViews 290

@interface lxyMonthlyView : UIView

@property (nonatomic , strong) UIButton *monthlyButton2;

@property (nonatomic , strong) UIButton *weeklyButton1;

@property (nonatomic , strong) UIButton *dailyButton1;

@property (nonatomic , strong) UIButton *personDataButton1;

@property (nonatomic , strong) UIImageView *imageView;

@property (nonatomic , strong) UIImageView *imageViewTitle;

@property (nonatomic , strong) UIScrollView *scroller;


@property (nonatomic, strong) UIButton *previousButton;
@property (nonatomic, strong) UIButton *nextButton;

@property (nonatomic , strong) UIButton *monthlyBackButton; //返回按钮

@end
