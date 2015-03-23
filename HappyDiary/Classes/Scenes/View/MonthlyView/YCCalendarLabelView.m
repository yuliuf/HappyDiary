//
//  YCCalendarLabelView.m
//  EventController
//
//  Created by 孙震 on 14-6-22.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "YCCalendarLabelView.h"

@implementation YCCalendarLabelView

- (void)dealloc
{
    [_imageViewCell release];
    [_labelCell release];
    [_label release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //  label
        self.label = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)] autorelease];
        [self addSubview:_label];
//        [_label release];
        
        //  labelCell加载到label上
        self.labelCell = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width / 5 * 2, frame.size.height / 2)] autorelease];
        _labelCell.textAlignment = NSTextAlignmentRight;
        [self.label addSubview:_labelCell];
//        [_labelCell release];
        
        //  imageViewCell加载到label上
        self.imageViewCell = [[[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width / 5 * 2, 0, frame.size.width / 5 * 3, frame.size.height)] autorelease];
        [self.label addSubview:_imageViewCell];
//        [_imageViewCell release];
    }
    return self;
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
