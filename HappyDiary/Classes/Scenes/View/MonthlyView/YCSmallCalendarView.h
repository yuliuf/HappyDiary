//
//  YCSmallCalendarView.h
//  HappyDiary
//
//  Created by 孙震 on 14-6-28.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#define day_label_width 18
#define day_label_height 18

@interface YCSmallCalendarView : UIView

- (YCSmallCalendarView *)createCalOfDay:(int)currentDay Month:(int)currentMonth Year:(int)currentYear MonthName:(NSString *)name;

@end
