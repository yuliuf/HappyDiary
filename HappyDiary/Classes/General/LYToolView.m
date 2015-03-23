//
//  LYToolView.m
//  HappyDiary
//
//  Created by liuyu on 14-6-20.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import "LYToolView.h"

@implementation LYToolView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.shadowColor = [UIColor grayColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(10, 10);
        self.layer.cornerRadius = 5;
        self.layer.shadowOpacity = 0.8f;
        self.titleLbl = [[UILabel alloc] initWithFrame: Rect(0, 0, frame.size.width, 30)];
        self.titleLbl.textAlignment = NSTextAlignmentCenter;
        self.titleLbl.backgroundColor = myGreen;
        [self addSubview:_titleLbl];
        
        self.closeBtn = [[UIButton alloc] initWithFrame:Rect(frame.size.width - 25, 5, 20, 20)];
        [self.closeBtn setBackgroundImage:[UIImage imageNamed:@"decolayer_tap_x"] forState:UIControlStateNormal];
        [self addSubview:_closeBtn];

        
    }
    return self;
}

#pragma mark title的setter
- (void)setTitle:(NSString *)title
{
    _titleLbl.text = title;
}
- (NSString *)title
{
    return _titleLbl.text;
}

- (LYToolView *)initWithTitle:(NSString *)title withFrame:(CGRect)frame
{
    if (self = [self initWithFrame:frame]) {
        self.titleLbl.text = title;
        
    }
    return self;
}


@end
