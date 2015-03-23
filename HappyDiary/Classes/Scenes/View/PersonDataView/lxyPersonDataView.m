//
//  lxyPersonDataView.m
//  EventController
//
//  Created by 刘翔宇 on 14-6-20.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import "lxyPersonDataView.h"
#import "lxyUserTableModel.h"

#define WIDTHOFBUTTON 61.875
#define HEIGHTOFBUTTON1 30
#define HEIGHTOFBUTTON2 30
#define JIANJU 2
#define NameTag 202
#define BirthdayTag 203
#define IntroduceTag 204


@implementation lxyPersonDataView

-(void)dealloc
{
    [_monthlyButton1 release];
    [_weeklyButton1 release];
    [_dailyButton1 release];
    [_personDataButton2 release];
    [_imageView release];
    [_imageViewTitle release];
    [_tap release];
    //    [_scroller release];
    
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

//轻拍属性的懒加载
- (UITapGestureRecognizer *)tap
{
    if (nil == _tap) {
        self.tap = [[[UITapGestureRecognizer alloc] init] autorelease];
        [self addGestureRecognizer:_tap];
    }
    return _tap;
}

#pragma mark 头像图片轻怕手势的懒加载
- (UITapGestureRecognizer *)tapHeadIcon
{
    if (nil == _tapHeadIcon) {
        _tapHeadIcon = [[UITapGestureRecognizer alloc] init];
        //把该轻怕手势加到头像图片上
        [self.headerIcon addGestureRecognizer:_tapHeadIcon];
    }
    return _tapHeadIcon;
}

- (void)addAllViews
{
    self.monthlyButton1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.weeklyButton1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.dailyButton1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.personDataButton2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    //设置button的位置和大小
    _monthlyButton1.frame = CGRectMake(49, 8, WIDTHOFBUTTON, HEIGHTOFBUTTON1);
    _weeklyButton1.frame = CGRectMake(_monthlyButton1.frame.origin.x + WIDTHOFBUTTON + JIANJU, _monthlyButton1.frame.origin.y, WIDTHOFBUTTON, HEIGHTOFBUTTON1);
    _dailyButton1.frame = CGRectMake(_weeklyButton1.frame.origin.x + WIDTHOFBUTTON + JIANJU, _weeklyButton1.frame.origin.y, WIDTHOFBUTTON, HEIGHTOFBUTTON1);
    _personDataButton2.frame = CGRectMake(_dailyButton1.frame.origin.x + WIDTHOFBUTTON + JIANJU, _dailyButton1.frame.origin.y, WIDTHOFBUTTON, HEIGHTOFBUTTON2 + 4);
    
    //设置每个button的背景图片
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"menu_monthly_off" ofType:@"png"];
    UIImage *image = [[[UIImage alloc] initWithContentsOfFile:imagePath] autorelease];
    [_monthlyButton1 setBackgroundImage:image forState:UIControlStateNormal];
    imagePath = [[NSBundle mainBundle] pathForResource:@"menu_weekly_off" ofType:@"png"];
    image = [[[UIImage alloc] initWithContentsOfFile:imagePath] autorelease];
    [_weeklyButton1 setBackgroundImage:image forState:UIControlStateNormal];
    imagePath = [[NSBundle mainBundle] pathForResource:@"menu_daily_off" ofType:@"png"];
    image = [[[UIImage alloc] initWithContentsOfFile:imagePath] autorelease];
    [_dailyButton1 setBackgroundImage:image forState:UIControlStateNormal];
    imagePath = [[NSBundle mainBundle] pathForResource:@"menu_personal_on" ofType:@"png"];
    image = [[[UIImage alloc] initWithContentsOfFile:imagePath] autorelease];
    [_personDataButton2 setBackgroundImage:image forState:UIControlStateNormal];
    
//    //设置每个button的文字
//    [_monthlyButton1 setTitle:@"monthly" forState:UIControlStateNormal];
//    [_weeklyButton1 setTitle:@"weekly" forState:UIControlStateNormal];
//    [_dailyButton1 setTitle:@"daily" forState:UIControlStateNormal];
//    [_personDataButton2 setTitle:@"person" forState:UIControlStateNormal];
//    
//    
//    //设置每个button的字体样式
//    _monthlyButton1.titleLabel.font = [UIFont fontWithName:@"LiDeBiao-Xing-3.0" size:19.f];
//    _weeklyButton1.titleLabel.font = [UIFont fontWithName:@"LiDeBiao-Xing-3.0" size:19.f];
//    _dailyButton1.titleLabel.font = [UIFont fontWithName:@"LiDeBiao-Xing-3.0" size:19.f];
//    _personDataButton2.titleLabel.font = [UIFont fontWithName:@"LiDeBiao-Xing-3.0" size:19.f];
    
    
    
    
    //添加背景图片
    imagePath = [[NSBundle mainBundle] pathForResource:@"book" ofType:@"png"];
    UIImage *img = [[[UIImage alloc] initWithContentsOfFile:imagePath] autorelease];
    self.imageView = [[[UIImageView alloc] initWithImage:img] autorelease];
    _imageView.userInteractionEnabled = YES;
    _imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self addSubview:_imageView];
    
    imagePath = [[NSBundle mainBundle] pathForResource:@"title" ofType:@"png"];
    UIImage *imgTitle = [[[UIImage alloc] initWithContentsOfFile:imagePath] autorelease];
    self.imageViewTitle = [[[UIImageView alloc] initWithImage:imgTitle] autorelease];
    _imageViewTitle.userInteractionEnabled = YES;
    _imageViewTitle.frame = CGRectMake(0, 0, self.frame.size.width, 54);
    [self addSubview:_imageViewTitle];
    
    
    //把所有的button添加到背景图片上
    [_imageViewTitle addSubview:_monthlyButton1];
    [_imageViewTitle addSubview:_weeklyButton1];
    [_imageViewTitle addSubview:_dailyButton1];
    [_imageViewTitle addSubview:_personDataButton2];
    
    //  添加编辑按钮
    self.editBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _editBtn.frame = CGRectMake(230,ScreenHeight - 80, 60, 30);
    imagePath = [[NSBundle mainBundle] pathForResource:@"intro_menu_brown" ofType:@"png"];
    image = [[[UIImage alloc] initWithContentsOfFile:imagePath] autorelease];
    [self.editBtn setBackgroundImage:image forState:UIControlStateNormal];
    [self.editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    self.editBtn.titleLabel.font = myZiti;
    [self.editBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:_editBtn];
    
    //  头像
    UIImage *imageTou = nil;
    //判断数据库中是否有数据
    NSMutableArray *array = nil;
    array = [[lxyDataBase shareLxyDataBase] searchAllDataFromUserTable];
    if (0 == array.count) {     //如果数据库中没有数据
        NSString *imagePathGai = [[NSBundle mainBundle] pathForResource:@"headIcon" ofType:@"png"];
        imageTou = [[[UIImage alloc] initWithContentsOfFile:imagePathGai] autorelease];
    } else {            //如果数据库中有数据
        //判断头像的图片路径是否为空
        lxyUserTableModel *model = nil;
        model = [array objectAtIndex:0];
        NSString *imagePath = model.user_headerImage;
        if ([imagePath isEqualToString:@"(null)"]) {
            NSString *imagePathGai = [[NSBundle mainBundle] pathForResource:@"headIcon" ofType:@"png"];
            imageTou = [[[UIImage alloc] initWithContentsOfFile:imagePathGai] autorelease];
        } else {
            imageTou = [[[UIImage alloc] initWithContentsOfFile:imagePath] autorelease];
        }
    }
    self.headerIcon = [[[UIImageView alloc] initWithImage:imageTou] autorelease];
    self.headerIcon.frame = Rect(50, 60, 120, 120);
    [self addSubview:self.headerIcon];
    
    // 姓名 生日
    self.name = [[[UITextField alloc] initWithFrame:Rect(MaxX(_headerIcon.frame) + 10, MinY(_headerIcon.frame) + 50, 100, 40)] autorelease];
    self.name.text = @"熊博士";
    self.name.textAlignment = NSTextAlignmentCenter;
    self.name.font = myZiti;
    self.name.enabled = NO;
    self.name.tag = NameTag;
    [self addSubview:self.name];
    
    self.birthday = [[[UITextField alloc] initWithFrame:Rect(MinX(_name.frame), MaxY(_name.frame), 100, 30)] autorelease];
    self.birthday.text = @"1992.3.24";
    self.birthday.textAlignment = NSTextAlignmentCenter;
    self.birthday.font = myZiti;
    self.birthday.enabled = NO;
    self.birthday.tag = BirthdayTag;
    [self addSubview:self.birthday];
    
    // 介绍
    self.introduce = [[[UITextView alloc] initWithFrame:Rect(MinX(_headerIcon.frame), MaxY(_headerIcon.frame) + 30, 220, ScreenHeight * 0.36)] autorelease];
    self.introduce.font = myZiti;
    self.introduce.editable = NO;
    self.introduce.text = @"好简单的愿望，我们小时候，愿望也是好简单，但是不能说。我们只能在作文里写到，我的愿望是做一个科学家······从小，我们就已经不单纯了。英文老师教小朋友们念社会栋梁一段，向，CEO，便是社会栋。";
    self.introduce.bounces = NO;
    self.introduce.tag = IntroduceTag;
    [self addSubview:self.introduce];
    
    //添加返回按钮
    self.personDataBackButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.personDataBackButton setFrame:CGRectMake(0, 5, 40, 40)];
    NSString *imagePathGai = [[NSBundle mainBundle] pathForResource:@"diary_out" ofType:@"png"];
    UIImage *imageGai = [[[UIImage alloc] initWithContentsOfFile:imagePathGai] autorelease];
    [self.personDataBackButton setBackgroundImage:imageGai forState:UIControlStateNormal];
    [self addSubview:self.personDataBackButton];
    
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
