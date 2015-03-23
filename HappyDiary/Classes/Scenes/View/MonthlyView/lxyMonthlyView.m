//
//  lxyMonthlyView.m
//  EventController
//
//  Created by 刘翔宇 on 14-6-20.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "lxyMonthlyView.h"


//#import "YCCalendarView.h"
#import <QuartzCore/QuartzCore.h>


#define WIDTHOFBUTTON 61.875
#define HEIGHTOFBUTTON1 30
#define HEIGHTOFBUTTON2 30
#define JIANJU 2


@implementation lxyMonthlyView

- (void)dealloc
{
    [_monthlyButton2 release];
    [_weeklyButton1 release];
    [_dailyButton1 release];
    [_personDataButton1 release];
    [_imageView release];
    [_imageViewTitle release];
    [_scroller release];
    
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self addAllViews];
        
    }
    return self;
}

- (void)addAllViews
{
    self.monthlyButton2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.weeklyButton1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.dailyButton1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.personDataButton1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    //设置button的位置和大小
    _monthlyButton2.frame = CGRectMake(49, 8, WIDTHOFBUTTON, HEIGHTOFBUTTON2);
    _weeklyButton1.frame = CGRectMake(_monthlyButton2.frame.origin.x + WIDTHOFBUTTON + JIANJU, _monthlyButton2.frame.origin.y, WIDTHOFBUTTON, HEIGHTOFBUTTON1);
    _dailyButton1.frame = CGRectMake(_weeklyButton1.frame.origin.x + WIDTHOFBUTTON + JIANJU, _weeklyButton1.frame.origin.y, WIDTHOFBUTTON, HEIGHTOFBUTTON1);
    _personDataButton1.frame = CGRectMake(_dailyButton1.frame.origin.x + WIDTHOFBUTTON + JIANJU, _dailyButton1.frame.origin.y, WIDTHOFBUTTON, HEIGHTOFBUTTON1 + 4);
    
    //添加自动释放池————————————————————————————
    @autoreleasepool {
        //设置每个button的背景图片
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"menu_monthly_on" ofType:@"png"];
        UIImage *image = [[[UIImage alloc] initWithContentsOfFile:imagePath] autorelease];
        [_monthlyButton2 setBackgroundImage:image forState:UIControlStateNormal];
        imagePath = [[NSBundle mainBundle] pathForResource:@"menu_weekly_off" ofType:@"png"];
        image = [[[UIImage alloc] initWithContentsOfFile:imagePath] autorelease];
        [_weeklyButton1 setBackgroundImage:image forState:UIControlStateNormal];
        imagePath = [[NSBundle mainBundle] pathForResource:@"menu_daily_off" ofType:@"png"];
        image = [[[UIImage alloc] initWithContentsOfFile:imagePath] autorelease];
        [_dailyButton1 setBackgroundImage:image forState:UIControlStateNormal];
        imagePath = [[NSBundle mainBundle] pathForResource:@"menu_personal_off" ofType:@"png"];
        image = [[[UIImage alloc] initWithContentsOfFile:imagePath] autorelease];
        [_personDataButton1 setBackgroundImage:image forState:UIControlStateNormal];
    }
    
    //添加自动释放池————————————————————————————————
    @autoreleasepool {
        //添加背景图片
        NSString *iamgePath = [[NSBundle mainBundle] pathForResource:@"eventBackGround" ofType:@"png"];
        UIImage *img = [[[UIImage alloc] initWithContentsOfFile:iamgePath] autorelease];
        self.imageView = [[[UIImageView alloc] initWithImage:img] autorelease];
        _imageView.userInteractionEnabled = YES;
        _imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        [self addSubview:_imageView];
    }
    
    //添加自动释放池————————————————————————————————————
    @autoreleasepool {
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"eventControllerTitle" ofType:@"png"];
        UIImage *imgTitle = [[[UIImage alloc] initWithContentsOfFile:imagePath] autorelease];
        self.imageViewTitle = [[[UIImageView alloc] initWithImage:imgTitle] autorelease];
        _imageViewTitle.userInteractionEnabled = YES;
        _imageViewTitle.frame = CGRectMake(0, 0, self.frame.size.width, 54);
        [self addSubview:_imageViewTitle];
    }
    
    
    //把所有的button添加到背景图片上
    [_imageViewTitle addSubview:_monthlyButton2];
    [_imageViewTitle addSubview:_weeklyButton1];
    [_imageViewTitle addSubview:_dailyButton1];
    [_imageViewTitle addSubview:_personDataButton1];
    
    
    //添加自动释放池——————————————————————————————
    @autoreleasepool {
        self.monthlyBackButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.monthlyBackButton setFrame:CGRectMake(0, 5, 40, 40)];
        NSString *iamgePath = [[NSBundle mainBundle] pathForResource:@"diary_out" ofType:@"png"];
        UIImage *img = [[[UIImage alloc] initWithContentsOfFile:iamgePath] autorelease];
        [self.monthlyBackButton setBackgroundImage:img forState:UIControlStateNormal];
        [self addSubview:self.monthlyBackButton];
    }
    //添加返回按钮
    
    
    //  加载调整月份的按钮
    self.previousButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.previousButton.frame = CGRectMake(100, self.bounds.size.height - 100, 20, 18);
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"left" ofType:@"png"];
    UIImage *image = [[[UIImage alloc] initWithContentsOfFile:imagePath] autorelease];
    [self.previousButton setBackgroundImage:image forState:UIControlStateNormal];
    self.previousButton.titleLabel.font = [UIFont fontWithName:@"LiDeBiao-Xing-3.0" size:19.f];
    [self addSubview:_previousButton];
    
    self.nextButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.nextButton.frame = CGRectMake(200, self.bounds.size.height - 100, 20, 18);
    imagePath = [[NSBundle mainBundle] pathForResource:@"right" ofType:@"png"];
    image = [[[UIImage alloc] initWithContentsOfFile:imagePath] autorelease];
    [self.nextButton setBackgroundImage:image forState:UIControlStateNormal];
    self.nextButton.titleLabel.font = [UIFont fontWithName:@"LiDeBiao-Xing-3.0" size:19.f];
    [self addSubview:_nextButton];
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
