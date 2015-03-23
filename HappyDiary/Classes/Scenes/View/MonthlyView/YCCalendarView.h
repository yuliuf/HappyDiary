//
//  YCCalendarView.h
//  EventController
//
//  Created by 孙震 on 14-6-22.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import <UIKit/UIKit.h>
#define day_label_width 18
#define day_label_height 18

@interface YCCalendarView : UIView

- (YCCalendarView *)createCalOfDay:(int)currentDay Month:(int)currentMonth Year:(int)currentYear MonthName:(NSString *)name;

//@property (nonatomic , copy) void(^dayBlock)(NSString *);

@end
