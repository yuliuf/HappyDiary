//
//  YCDetailHourglassView.m
//  HappyDiary
//
//  Created by 孙震 on 14-6-20.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import "YCDetailHourglassView.h"

@implementation YCDetailHourglassView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addAllViews];
    }
    return self;
}

- (void)addAllViews
{
    self.backImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    NSLog(@"bounds:%@", NSStringFromCGRect(self.bounds));
    _backImageView.image = [UIImage imageNamed:@"blueSky"];
    [self addSubview:_backImageView];
//    [_backImageView release];
    
    self.hgStyleImageView = [[UIImageView alloc] initWithFrame:Rect(0, 50, 100, 100)];
    //_hgStyleImageView.backgroundColor = myYellow;
    _hgStyleImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_hgStyleImageView];
//    [_hgStyleImageView release];
    
    self.introduceLabel = [[UILabel alloc] initWithFrame:Rect(MaxX(_hgStyleImageView.frame) - 10, MinY(_hgStyleImageView.frame), 170, Height(_hgStyleImageView.frame))];
    self.introduceLabel.numberOfLines = 0;
    [self addSubview:_introduceLabel];
    
    self.tableView = [[UITableView alloc] initWithFrame:Rect(10, MaxY(_hgStyleImageView.frame) + 10, ScreenWidth - 20 , ScreenHeight - Height(_hgStyleImageView.frame) - 74) style:UITableViewStylePlain];

    _tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fy"]];
    self.tableView.layer.cornerRadius = 5;
    [self addSubview:_tableView];
//    [_tableView release];
    
    self.playButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _playButton.frame = CGRectMake(265, 60, 32, 32);
    [_playButton setBackgroundImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
    [self addSubview:_playButton];
    
    self.voice = [UIButton buttonWithType:UIButtonTypeSystem];
    self.voice.frame = CGRectMake(266, 110, 32, 32);
    [self.voice setBackgroundImage:[UIImage imageNamed:@"voice"] forState:UIControlStateNormal];
    [self addSubview:_voice];
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
