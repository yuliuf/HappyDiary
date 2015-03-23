//
//  YCCalendar.m
//  TextCalender
//
//  Created by 孙震 on 14-6-21.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import "YCSmallCalendarView.h"
#import <QuartzCore/QuartzCore.h>
//#import "YCCalendarLabelView.h"
//#import "lxyDiaryModel.h"
//#import "lxyDataBase.h"

@interface YCSmallCalendarView ()
{
    NSMutableArray *_diaryArray;
}
@end

@implementation YCSmallCalendarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _diaryArray = [NSMutableArray array];
        _diaryArray = [lxyFunctionOfDataBase searchAllDataInTable:@"diaryTable"];
        //NSLog(@"diartArray:%@", _diaryArray);
    }
    return self;
}

#pragma mark - 创建每个月的日历
- (YCSmallCalendarView *)createCalOfDay:(int)currentDay Month:(int)currentMonth Year:(int)currentYear MonthName:(NSString *)name
{
    //  创建日历对象
    NSCalendar *gregorian = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    
    //  划分时区Time Zone： GMT，UTC，DST，CST
    [gregorian setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    
    NSDateComponents *comps = [gregorian components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:[NSDate date]];
    [comps setDay:1];
    [comps setMonth:currentMonth];
    [comps setYear:currentYear];
    
    //  获取第一天
    NSDate *firstDayOfMonthDate = [gregorian dateFromComponents:comps];
    NSDate *add1DayDate = firstDayOfMonthDate;
    NSRange range = [gregorian rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:[gregorian dateFromComponents:comps]];
    
    NSCalendar *cal1 = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    NSDateComponents *comps1 = [cal1 components:NSWeekdayCalendarUnit fromDate:firstDayOfMonthDate];
    
    // 1 for mon 8 for sun
    int startWithDay = [comps1 weekday] == 1 ? 8 : [comps1 weekday];
    int x = 2;
    int y = 75;
    
    //  月和年
    UILabel *lblMonthName = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 77.8, 22)] autorelease];
    lblMonthName.backgroundColor = [UIColor clearColor];
    lblMonthName.alpha = 0.2;
    lblMonthName.tag = 1999;
    lblMonthName.textAlignment = NSTextAlignmentCenter;
    lblMonthName.textColor = UIColorFromRGB(0xB94FFF);
    lblMonthName.font = [UIFont fontWithName:@"LiDeBiao-Xing-3.0" size:18.0];
    lblMonthName.text = name;
    [self addSubview:lblMonthName];
    
    for (int d = 1; d <= range.length; d ++)
    {
        
        while (d < 8) {
            
            [self createWeekDays:(int)d];
            break;
        }
        
        if (d-startWithDay >= 0)
        {
            [UIView animateWithDuration:0.5 animations:^{
                
            }completion:^(BOOL finished) {
                
            }];
            
            //  日期: 1 - 30
            UILabel *lblForDate = [[UILabel alloc] initWithFrame:CGRectMake((x - 2) * 2.05 / 3.7, y / 2.5, 43 / 3.7, 40 / 3.6)];
            //lblForDate.layer.borderWidth = .3;
            lblForDate.tag = d + 2000;
            lblForDate.layer.borderColor = [[UIColor orangeColor] CGColor];
            lblForDate.textAlignment = NSTextAlignmentCenter;
            lblForDate.text = [NSString stringWithFormat:@"%d",d-startWithDay + 1];
//            lblForDate.textColor = UIColorFromRGB(0xB94FFF);
            lblForDate.textColor = [UIColor blackColor];
            //lblForDate.labelCell.alpha = 0.3;
            lblForDate.userInteractionEnabled = YES;
            lblForDate.minimumScaleFactor = 0.2;
            lblForDate.adjustsFontSizeToFitWidth = YES;
            lblForDate.font = [UIFont fontWithName:@"LiDeBiao-Xing-3.0" size:15.0];
      
            //  当前日期
            BOOL isCurrentDay = [self checkDate:add1DayDate];
            if(isCurrentDay)
            {
                lblForDate.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:156.0/255.0 blue:120.0/255.0 alpha:1.0];
                lblForDate.clipsToBounds = YES;
            }
            else
            {
                lblForDate.backgroundColor = [UIColor clearColor];
            }
            [UIView animateWithDuration:0.5 animations:^{
                lblMonthName.alpha = 1.0;
                lblForDate.alpha = 1.0;
                
            }completion:^(BOOL finished) {
                lblForDate.alpha = 1.0;
                
            }];
            UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lblDateTapped:)];
            singleTap.numberOfTapsRequired = 1;
            singleTap.view.tag = d + 2000;
            
            //            NSLog(@"singtap:%d", singleTap.view.tag);
            //            NSLog(@"lbl:%d", lblForDate.tag);
            
            [lblForDate addGestureRecognizer:singleTap];
            [self addSubview:lblForDate];
            add1DayDate = [add1DayDate dateByAddingTimeInterval:24*60*60];
        }
        else
        {
            range.length = range.length +1;
        }
        if (d % 7 == 0)  // it will go to next line
        {
            x = 2;
            y += 40;
        }
        else
        {
            x += 20;
        }
    }
    return self;
}

#pragma mark - 点击某个日期
-(void)lblDateTapped:(UITapGestureRecognizer *)tap//called when any date will be tapped
{
    //  点击某个日期
    NSLog(@"tap %d",tap.view.tag);
}

/*
#pragma mark - 点击动画
//  点击某个日期时的动画
-(void)animationDrawCircleTime:(CGFloat)time label:(UILabel *)lbl completion:(void (^)(void))completion{
    
    if (time <= 0.0) {
        completion();
        return;
    }
    
    // Set up the shape of the circle
    int radius = lbl.frame.size.height/ 2;
    CAShapeLayer *circle = [CAShapeLayer layer];
    // Make a circular shape
    circle.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 2.0*radius, 2.0*radius)
                                             cornerRadius:radius].CGPath;
    // Center the shape in self.view
    circle.position =CGPointMake(lbl.frame.origin.x,lbl.frame.origin.y);
    
    // Configure the apperence of the circle
    circle.fillColor = [UIColor clearColor].CGColor;
    circle.strokeColor = [UIColor darkGrayColor].CGColor;
    circle.lineWidth = 2;
    circle.lineCap=kCALineCapRound;
    circle.lineJoin=kCALineJoinRound;
    
    
    //gradient color
    CAGradientLayer *gradientLayer=[CAGradientLayer layer];
    gradientLayer.startPoint=CGPointMake(0.5, 1.0);
    gradientLayer.endPoint=CGPointMake(0.5, 0.0);
    NSMutableArray *colors =[NSMutableArray array];
    for (int i=0; i<5; i++) {
        [colors addObject:(id)[UIColor colorWithHue:(0.1 * i) saturation:1 brightness:0.8 alpha:1.0].CGColor];
    }
    gradientLayer.colors=colors;
    [gradientLayer setMask:circle];
    
    // Add to parent layer
    [self.layer addSublayer:circle];
    
    // Configure animation
    CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    drawAnimation.duration            = time; // "animate over 10 seconds or so.."
    drawAnimation.repeatCount         = 1.0;  // Animate only once..
    drawAnimation.removedOnCompletion = YES;   // Remain stroked after the animation..
    [CATransaction setCompletionBlock:^{
        //        [circle removeAllAnimations];
        [circle removeFromSuperlayer];
        completion();
    }];
    
    // Animate from no part of the stroke being drawn to the entire stroke being drawn
    drawAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    drawAnimation.toValue   = [NSNumber numberWithFloat:1.0f];
    
    // Experiment with timing to get the appearence to look the way you want
    drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    // Add the animation to the circle
    [circle addAnimation:drawAnimation forKey:@"drawCircleAnimation"];
    
}
 */

#pragma mark - Formatting Date
+ (NSString *)buildRankString:(NSNumber *)rank//converting 1 to 1st, 2 to 2nd, and so on
{
    NSString *suffix = nil;
    int rankInt = [rank intValue];
    int ones = rankInt % 10;
    int tens = floor(rankInt / 10);
    tens = tens % 10;
    if (tens == 1) {
        suffix = @"th";
    } else {
        switch (ones) {
            case 1 : suffix = @"st"; break;
            case 2 : suffix = @"nd"; break;
            case 3 : suffix = @"rd"; break;
            default : suffix = @"th";
        }
    }
    NSString *rankString = [NSString stringWithFormat:@"%@%@", rank, suffix];
    return rankString;
}
#pragma mark - 显示星期
//  创建星期一到星期日
-(void)createWeekDays:(int)d // for creating view of weekdays as well as weekends
{
    /*
    NSArray *arrNames = [NSArray arrayWithObjects:@"Sun",@"Mon",@"Tue",@"Wed",@"Thu",@"Fri",@"Sat",nil];
    UILabel *lblNameOfDay = [[UILabel alloc] initWithFrame:CGRectMake(2*((d-1.2)*21), 50, 50, day_label_height)];
    lblNameOfDay.text = [arrNames objectAtIndex:d-1];
    lblNameOfDay.font = [UIFont fontWithName:@"LiDeBiao-Xing-3.0" size:19.0];
    lblNameOfDay.textAlignment = NSTextAlignmentCenter;
    lblNameOfDay.backgroundColor = [UIColor clearColor];
    lblNameOfDay.textColor = UIColorFromRGB(0xB94FFF);
    [self addSubview:lblNameOfDay];
    */
    
}

#pragma mark - 检查当前日期
-(BOOL)checkDate:(NSDate *)currentDate//for checking current date.....
{
    // NSLog(@"currentDate %@",currentDate);
    NSDate *dtToday = [NSDate date];
    NSDateFormatter *dtFormatter = [[[NSDateFormatter alloc] init] autorelease];
    
    [dtFormatter setDateFormat:@"yyyy"];
    int CurrentYear = [[dtFormatter stringFromDate:currentDate]integerValue];
    int todayYear = [[dtFormatter stringFromDate:dtToday]integerValue];
    if(todayYear == CurrentYear)
    {
        [dtFormatter setDateFormat:@"MM"];
        int CurrentMonth = [[dtFormatter stringFromDate:currentDate]integerValue];
        int todayMonth = [[dtFormatter stringFromDate:dtToday]integerValue];
        if(todayMonth == CurrentMonth)
        {
            [dtFormatter setDateFormat:@"dd"];
            int currentDay = [[dtFormatter stringFromDate:currentDate]integerValue];
            int todayDay = [[dtFormatter stringFromDate:dtToday]integerValue];
            if(todayDay == currentDay)
                return YES;
            else
                return NO;
        }
        
    }
    return NO;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end


