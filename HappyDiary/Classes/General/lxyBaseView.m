//
//  lxyBaseView.m
//  EventController
//
//  Created by 刘翔宇 on 14-6-20.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "lxyBaseView.h"

@implementation lxyBaseView

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
    self.showStatusBarLabel = [[[UILabel alloc] initWithFrame:Rect(0, 0, 320, 20)] autorelease];
    self.backgroundColor = [UIColor yellowColor];
    [self addSubview:_showStatusBarLabel];
    
}

#pragma mark 重写手势getter
- (UITapGestureRecognizer *)doubleTapGR
{
    if (_doubleTapGR == nil) {
        _doubleTapGR = [[UITapGestureRecognizer alloc] init];
        [self.showStatusBarLabel addGestureRecognizer:_doubleTapGR];
    }
    return _doubleTapGR;
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
