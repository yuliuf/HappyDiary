//
//  lxyDailyView.m
//  EventController
//
//  Created by 刘翔宇 on 14-6-20.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import "lxyDailyView.h"

#define WIDTHOFBUTTON 61.875
#define HEIGHTOFBUTTON1 30
#define HEIGHTOFBUTTON2 30
#define JIANJU 2


@implementation lxyDailyView

- (void)dealloc
{
    [_searchBar release];
    [_tableView release];
    [_titleView release];
    [_monthlyButton1 release];
    [_weeklyButton1 release];
    [_dailyButton2 release];
    [_personDataButton1 release];
    [_imageView release];
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
    self.monthlyButton1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.weeklyButton1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.dailyButton2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.personDataButton1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    //设置button的位置和大小
    _monthlyButton1.frame = CGRectMake(49, 8, WIDTHOFBUTTON, HEIGHTOFBUTTON1);
    _weeklyButton1.frame = CGRectMake(_monthlyButton1.frame.origin.x + WIDTHOFBUTTON + JIANJU, _monthlyButton1.frame.origin.y, WIDTHOFBUTTON, HEIGHTOFBUTTON1);
    _dailyButton2.frame = CGRectMake(_weeklyButton1.frame.origin.x + WIDTHOFBUTTON + JIANJU, _weeklyButton1.frame.origin.y, WIDTHOFBUTTON, HEIGHTOFBUTTON2);
    _personDataButton1.frame = CGRectMake(_dailyButton2.frame.origin.x + WIDTHOFBUTTON + JIANJU, _dailyButton2.frame.origin.y, WIDTHOFBUTTON, HEIGHTOFBUTTON1 + 4);
    
    //自动释放池————————————————————————————————————————————
    @autoreleasepool {
        //设置每个button的背景图片
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"menu_monthly_off" ofType:@"png"];
        UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
        [_monthlyButton1 setBackgroundImage:image forState:UIControlStateNormal];
        
        imagePath = [[NSBundle mainBundle] pathForResource:@"menu_weekly_off" ofType:@"png"];
        image = [UIImage imageWithContentsOfFile:imagePath];
        [_weeklyButton1 setBackgroundImage:image forState:UIControlStateNormal];
        
        imagePath = [[NSBundle mainBundle] pathForResource:@"menu_daily_on" ofType:@"png"];
        image = [UIImage imageWithContentsOfFile:imagePath];
        [_dailyButton2 setBackgroundImage:image forState:UIControlStateNormal];
        
        imagePath = [[NSBundle mainBundle] pathForResource:@"menu_personal_off" ofType:@"png"];
        image = [UIImage imageWithContentsOfFile:imagePath];
        [_personDataButton1 setBackgroundImage:image forState:UIControlStateNormal];
        
        //添加背景图片
        imagePath = [[NSBundle mainBundle] pathForResource:@"eventBackGround" ofType:@"png"];
        UIImage *img = [[[UIImage alloc] initWithContentsOfFile:imagePath] autorelease];
        self.imageView = [[[UIImageView alloc] initWithImage:img] autorelease];
        _imageView.userInteractionEnabled = YES;
        _imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        [self addSubview:_imageView];
        
        imagePath = [[NSBundle mainBundle] pathForResource:@"eventControllerTitle" ofType:@"png"];
        UIImage *imgTitle = [[[UIImage alloc] initWithContentsOfFile:imagePath] autorelease];
        self.imageViewTitle = [[[UIImageView alloc] initWithImage:imgTitle] autorelease];
        _imageViewTitle.userInteractionEnabled = YES;
        _imageViewTitle.frame = CGRectMake(0, 0, self.frame.size.width, 54);
        [self addSubview:_imageViewTitle];
    }
    
    
    //给每个button设置阴影效果
    _monthlyButton1.layer.shadowColor = [[UIColor grayColor] CGColor];
    _monthlyButton1.layer.shadowOffset = CGSizeMake(3.f, 3.f);
    _monthlyButton1.layer.shadowOpacity = 2.f;
    _monthlyButton1.layer.shadowRadius = 3.f;
    
    _weeklyButton1.layer.shadowColor = [[UIColor grayColor] CGColor];
    _weeklyButton1.layer.shadowOffset = CGSizeMake(3.f, 3.f);
    _weeklyButton1.layer.shadowOpacity = 2.f;
    _weeklyButton1.layer.shadowRadius = 3.f;
    
    _dailyButton2.layer.shadowColor = [[UIColor grayColor] CGColor];
    _dailyButton2.layer.shadowOffset = CGSizeMake(3.f, 3.f);
    _dailyButton2.layer.shadowOpacity = 2.f;
    _dailyButton2.layer.shadowRadius = 3.f;
    
    _personDataButton1.layer.shadowColor = [[UIColor grayColor] CGColor];
    _personDataButton1.layer.shadowOffset = CGSizeMake(3.f, 3.f);
    _personDataButton1.layer.shadowOpacity = 2.f;
    _personDataButton1.layer.shadowRadius = 3.f;
     
    
    //把所有的button添加到背景图片上
    [_imageViewTitle addSubview:_monthlyButton1];
    [_imageViewTitle addSubview:_weeklyButton1];
    [_imageViewTitle addSubview:_dailyButton2];
    [_imageViewTitle addSubview:_personDataButton1];
    
    //自动释放池————————————————————————————————————————————————
    @autoreleasepool {
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"title_book" ofType:@"png"];
        UIImage *image = [[[UIImage alloc] initWithContentsOfFile:imagePath] autorelease];
        self.titleView = [[[UIImageView alloc] initWithImage:image] autorelease];
        _titleView.frame = CGRectMake(45, 40, 50, 50);
        [_imageView addSubview:_titleView];
        //    [_imageView release];
        
        self.searchBar = [[[UISearchBar alloc] initWithFrame:CGRectMake(100, 50, 180, 30)] autorelease];
        self.searchBar.backgroundColor = [UIColor orangeColor];
        self.searchBar.barStyle = UIBarStyleDefault;
    }
    
    //self.searchBar.showsBookmarkButton = YES;
    self.searchBar.searchResultsButtonSelected = YES;
    //self.searchBar.showsSearchResultsButton = YES;
    self.searchBar.tintColor = [UIColor orangeColor];
    self.searchBar.translucent = YES;
    
    self.searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [_imageView addSubview:_searchBar];
//    [_searchBar release];
    
    
    self.tableView = [[[UITableView alloc] initWithFrame:CGRectMake(40, 87.5, 263.5, self.bounds.size.height - 125) style:UITableViewStylePlain] autorelease];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 87.5, 263.5, self.bounds.size.height - 125)];
    imageView.image = [UIImage imageNamed:@"fy"];
    self.tableView.backgroundView = imageView;
    [imageView release];
    [_imageView addSubview:_tableView];
    
    //添加返回按钮
    //添加自动释放池——————————————————————————————————————————————
    @autoreleasepool {
        self.dailyBackButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.dailyBackButton setFrame:CGRectMake(0, 5, 40, 40)];
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"diary_out" ofType:@"png"];
        UIImage *image = [[[UIImage alloc] initWithContentsOfFile:imagePath] autorelease];
        [self.dailyBackButton setBackgroundImage:image forState:UIControlStateNormal];
        [self addSubview:self.dailyBackButton];
    }
    
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
