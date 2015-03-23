//
//  YCWeeklyDetailView.m
//  HappyDiary
//
//  Created by 刘翔宇 on 14-6-30.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "YCWeeklyDetailView.h"

#define kongXi 20
#define widthOfIcon 40

@implementation YCWeeklyDetailView

-(void)dealloc
{
    [_iconImageView release];
    [_title release];
    [_day release];
    
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
//        self.backgroundColor = [UIColor magentaColor];
        [self addAllViews];
        
    }
    return self;
}

- (void)addAllViews
{
    
    //设置背景图片
    UIImageView *backImage = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"book"]] autorelease];
    backImage.frame = self.frame;
//    backImage.alpha = .4f;
    [self addSubview:backImage];
    
    //  标题底色label
    UIView *view = [[[UIView alloc] initWithFrame:Rect(20, 50, ScreenWidth - 20 - 15, 30)] autorelease];
    view.backgroundColor = [UIColor whiteColor];
    view.alpha = 0.8f;
    [self addSubview:view];
    
    //加载icon
    self.iconImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(kongXi, kongXi,widthOfIcon , widthOfIcon)] autorelease];
    [self addSubview:_iconImageView];
    
    
    //加载title
    self.title = [[[UILabel alloc] initWithFrame:CGRectMake(_iconImageView.frame.origin.x + _iconImageView.frame.size.width, _iconImageView.frame.origin.y, self.frame.size.width - widthOfIcon * 2 - kongXi * 2, _iconImageView.frame.size.height)] autorelease];
    _title.font = [UIFont fontWithName:@"LiDeBiao-Xing-3.0" size:20.f];
    _title.textAlignment = NSTextAlignmentCenter;
    _title.tintColor = [UIColor orangeColor];
    [self addSubview:_title];
    
    //加载day
    self.day = [[[UILabel alloc] initWithFrame:CGRectMake(_title.frame.origin.x + _title.frame.size.width, _title.frame.origin.y, widthOfIcon, widthOfIcon)] autorelease];
    _day.font = [UIFont fontWithName:@"LiDeBiao-Xing-3.0" size:22.f];
    _day.tintColor = [UIColor orangeColor];
    [self addSubview:_day];
    
    //加载contentImageView
    self.contentImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(kongXi, _title.frame.origin.y + _title.frame.size.height, self.frame.size.width - kongXi * 2, self.frame.size.height - kongXi * 3 - widthOfIcon)] autorelease];
//    _contentImageView.backgroundColor = [UIColor redColor];
    [self addSubview:_contentImageView];
    
    
    
    
    
}

//该view轻怕事件的懒加载
- (UITapGestureRecognizer *)tap
{
    if (nil == _tap) {
        self.tap = [[[UITapGestureRecognizer alloc] init] autorelease];
        [self addGestureRecognizer:_tap];
    }
    return _tap;
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
