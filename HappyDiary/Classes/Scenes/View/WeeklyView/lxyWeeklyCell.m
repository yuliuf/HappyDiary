//
//  lxyWeeklyCell.m
//  EventController
//
//  Created by 刘翔宇 on 14-6-21.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "lxyWeeklyCell.h"

#define ICONBORDER 15
#define KONGBAI 5
#define ALPHA .6f

@implementation lxyWeeklyCell

- (void)dealloc
{
    [_titleIcon release];
    [_titleLabel release];
    [_titleDay release];
    
    [_contentImageView release];
    
    
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


//布局视图
- (void)addAllViews
{
    //titleIcon
    self.titleIcon = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ICONBORDER, ICONBORDER)] autorelease];
//    _titleIcon.backgroundColor = [UIColor redColor];
//    _titleIcon.alpha = ALPHA;
    [self addSubview:_titleIcon];
    
    
    //titleLabel
    self.titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(_titleIcon.frame.origin.x + ICONBORDER, _titleIcon.frame.origin.y, self.frame.size.width - ICONBORDER * 2, ICONBORDER)] autorelease];
    _titleLabel.font = [UIFont fontWithName:@"LiDeBiao-Xing-3.0" size:5.f];
//    _titleLabel.alpha = ALPHA;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_titleLabel];
    
    
    //titleDay
    self.titleDay = [[[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - ICONBORDER, _titleIcon.frame.origin.y, ICONBORDER, ICONBORDER)] autorelease];
//    _titleDay.backgroundColor = [UIColor magentaColor];
    _titleDay.font = [UIFont fontWithName:@"LiDeBiao-Xing-3.0" size:5.f];
//    _titleDay.alpha = ALPHA;
    [self addSubview:_titleDay];
    
    
    //contentImageView
    self.contentImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(KONGBAI, ICONBORDER, self.frame.size.width - 2 * KONGBAI, self.frame.size.height - ICONBORDER - KONGBAI)] autorelease];
    [self addSubview:_contentImageView];
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
