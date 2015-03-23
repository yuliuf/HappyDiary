//
//  lxyWeeklyView.m
//  EventController
//
//  Created by 刘翔宇 on 14-6-20.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import "lxyWeeklyView.h"
#import "lxyWeeklyCell.h"
#import "lxyDiaryModel.h"
//#import "lxyDataBase.h"
#import "lxyCalendarCell.h"

#import "YCSmallCalendarView.h"
//#import "YCCalendarLabelView.h"

//#import "YCCalendarView.h"

#define WIDTHOFBUTTON 61.875
#define HEIGHTOFBUTTON1 30
#define HEIGHTOFBUTTON2 30
#define JIANJU 2
#define KONGBAI 5

static NSString *cell_id = @"cell_id";
static NSString *calendarCell = @"calendarCell";

@implementation lxyWeeklyView

- (void)dealloc
{
    [_monthlyButton1 release];
    [_weeklyButton2 release];
    [_dailyButton1 release];
    [_personDataButton1 release];
    [_imageView release];
    [_imageViewTitle release];
    [_collection release];
    [_layout release];
    [_commonCell release];
    [_swipGesture release];
    
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

//重写滑屏手势的getter方法
- (UISwipeGestureRecognizer *)swipGesture
{
    if (nil == _swipGesture) {
        self.swipGesture = [[[UISwipeGestureRecognizer alloc] init] autorelease];
        [self addGestureRecognizer:_swipGesture];
    }
    return _swipGesture;
}


- (void)addAllViews
{
    self.monthlyButton1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.weeklyButton2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.dailyButton1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.personDataButton1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    //设置button的位置和大小
    _monthlyButton1.frame = CGRectMake(49, 8, WIDTHOFBUTTON, HEIGHTOFBUTTON1);
    _weeklyButton2.frame = CGRectMake(_monthlyButton1.frame.origin.x + WIDTHOFBUTTON + JIANJU, _monthlyButton1.frame.origin.y, WIDTHOFBUTTON, HEIGHTOFBUTTON2);
    _dailyButton1.frame = CGRectMake(_weeklyButton2.frame.origin.x + WIDTHOFBUTTON + JIANJU, _weeklyButton2.frame.origin.y, WIDTHOFBUTTON, HEIGHTOFBUTTON1);
    _personDataButton1.frame = CGRectMake(_dailyButton1.frame.origin.x + WIDTHOFBUTTON + JIANJU, _dailyButton1.frame.origin.y, WIDTHOFBUTTON, HEIGHTOFBUTTON1 + 4);
    
    //设置每个button的背景图片
    [_monthlyButton1 setBackgroundImage:[UIImage imageNamed:@"menu_monthly_off"] forState:UIControlStateNormal];
    [_weeklyButton2 setBackgroundImage:[UIImage imageNamed:@"menu_weekly_on"] forState:UIControlStateNormal];
    [_dailyButton1 setBackgroundImage:[UIImage imageNamed:@"menu_daily_off"] forState:UIControlStateNormal];
    [_personDataButton1 setBackgroundImage:[UIImage imageNamed:@"menu_personal_off"] forState:UIControlStateNormal];
    
    //添加背景图片
    UIImage *img = [UIImage imageNamed:@"eventBackGround.png"];
    self.imageView = [[[UIImageView alloc] initWithImage:img] autorelease];
    _imageView.userInteractionEnabled = YES;
    _imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self addSubview:_imageView];
    
    UIImage *imgTitle = [UIImage imageNamed:@"eventControllerTitle.png"];
    self.imageViewTitle = [[[UIImageView alloc] initWithImage:imgTitle] autorelease];
    _imageViewTitle.userInteractionEnabled = YES;
    _imageViewTitle.frame = CGRectMake(0, 0, self.frame.size.width, 54);
    [self addSubview:_imageViewTitle];
    
    
    //把所有的button添加到背景图片上
    [_imageViewTitle addSubview:_monthlyButton1];
    [_imageViewTitle addSubview:_weeklyButton2];
    [_imageViewTitle addSubview:_dailyButton1];
    [_imageViewTitle addSubview:_personDataButton1];
    
    //初始化layout
    self.layout = [[[UICollectionViewFlowLayout alloc] init] autorelease];
    _layout.itemSize = CGSizeMake(77.8, 135.3);
    
    //初始化collectionView
    self.collection = [[[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:_layout] autorelease];
    _collection.frame = CGRectMake(40, 41, 253.5, 419.5);
    
    
    //给collectionView加背景view
    UIImage *collecImage = [UIImage imageNamed:@"weeklyBtn.png"];
    UIImageView *collecImageView = [[[UIImageView alloc] initWithImage:collecImage] autorelease];
    _collection.backgroundView = collecImageView;
    
    
    [_imageView addSubview:_collection];
    
    
    _collection.dataSource = self;
    
    //注册cell
    [_collection registerClass:[lxyWeeklyCell class] forCellWithReuseIdentifier:cell_id];
    [_collection registerClass:[lxyCalendarCell class] forCellWithReuseIdentifier:calendarCell];
    
}


//uicollectionView DataSource Method
//设置每个分组中有多少个item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    //获取diarytable的所有数据
    NSMutableArray *array = nil;
//    NSMutableArray *array = [[[NSMutableArray alloc] init] autorelease];
    array = [[lxyDataBase shareLxyDataBase] searchAllDataFromDiaryTable];
    
    NSMutableArray *arr = [NSMutableArray array];
    
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *today = [formatter stringFromDate:[NSDate date]];
    today = [today substringWithRange:NSMakeRange(8, 2)];
    
    for (int i = 0; i < array.count; i ++) {
        lxyDiaryModel *model = nil;
        model = [array objectAtIndex:i];
        NSString *time = model.diary_time;
        time = [time substringWithRange:NSMakeRange(8, 2)];
        if ([time isEqualToString:today]) {
            [arr addObject:model];
        }
    }
    
    
    return arr.count + 1;
}

#pragma mark -每个item上显示的内容
//设置每个item上显示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        lxyCalendarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cell_id forIndexPath:indexPath];
        if (nil == cell) {
            cell = [[[lxyCalendarCell alloc] init] autorelease];
        }
        dtForMonth = [NSDate date];
        UIView *calendarView = [self createCalendar];
        calendarView.frame = cell.frame;
        [cell addSubview:calendarView];
        cell.userInteractionEnabled = NO;
        return cell;
    } else {
        
        //获取diarytable中的所有数据
        NSMutableArray *array = nil;
        array = [[lxyDataBase shareLxyDataBase] searchAllDataFromDiaryTable];
        
        //取出当前所要显示的model
        lxyWeeklyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cell_id forIndexPath:indexPath];
        if (nil == cell) {
            cell = [[[lxyWeeklyCell alloc] init] autorelease];
        }
        
        //取出所有是今天的数据
        
//        YCCalendarView *calendar = [[YCCalendarView alloc] init];
//        [calendar setDayBlock:^(NSString *day) {
//            
//            
//            NSLog(@"%@", day);
//            NSLog(@"%@", day);
//        }];
        
        NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *day = [formatter stringFromDate:[NSDate date]];
        day = [day substringWithRange:NSMakeRange(8, 2)];
        NSMutableArray *arr = [NSMutableArray array];
        for (int i = 0; i < array.count; i ++) {
            lxyDiaryModel *model = nil;
            model = [array objectAtIndex:i];
            NSString *time = model.diary_time;
            time = [time substringWithRange:NSMakeRange(8, 2)];
            if ([time isEqualToString:day]) {
                [arr addObject:model];
            }
        }
        
        
        lxyDiaryModel *model = nil;
        model = [arr objectAtIndex:indexPath.row - 1];
        
        //由数据库中的路径获取该图片
        //内容图片
        NSString *imgPath = model.diary_content;
        WhatIsX(imgPath);
        UIImage *image = [[UIImage alloc] initWithContentsOfFile:imgPath];
        
        //title图片
        NSString *titleImgPath = model.diary_icon;
        UIImage *titleImage = [[UIImage alloc] initWithContentsOfFile:titleImgPath];
     
        NSString *time = model.diary_time;
        time = [time substringWithRange:NSMakeRange(8, 2)];
        
        cell.titleLabel.text = model.diary_title;
        cell.titleIcon.image = titleImage;
        [titleImage release];
        cell.titleDay.text = time;
        cell.contentImageView.image = image;
        [image release];

        return cell;
    }
    
}

//  创建日历
-(UIView *)createCalendar
{
    
    if ([self viewWithTag:1001])
    {
        [[self viewWithTag:1001] removeFromSuperview];
    }
    UIView *viewTmp = [[[UIView alloc] initWithFrame:CGRectMake(40, 41, 77.8, 135.3)] autorelease];
    
    //viewTmp.backgroundColor = [UIColor blackColor];
    viewTmp.tag=1001;
    [self addSubview:viewTmp];
    int X = 0;

    //  当前dtFormonth去创建日历
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:dtForMonth];
    NSInteger month = [components month];
    NSInteger year = [components year];
    NSInteger day = [components day];

    //  显示月份
    NSDateFormatter *dt = [[[NSDateFormatter alloc] init] autorelease];
    NSString *strMonthName = [[dt monthSymbols] objectAtIndex:month-1];//January,Febryary,March etc...
    strMonthName = [ strMonthName stringByAppendingString:[NSString  stringWithFormat:@"- %d",year]];
    
    //  日历的X坐标
    X = 20;
    //  日历的Y坐标
    originY = 80;
    
    YCSmallCalendarView  *vwCal = [[[YCSmallCalendarView alloc] initWithFrame:CGRectMake(1.5, 3, 77.8,127)] autorelease];
    X++;
    vwCal.tag = 100;
    vwCal.layer.masksToBounds = NO;
    
    vwCal.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"baiyun"]];
    vwCal = [vwCal createCalOfDay:day Month:month Year:year MonthName:strMonthName];
    [viewTmp addSubview:vwCal];
    return viewTmp;
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
