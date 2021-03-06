//
//  YCSpecialDayView.m
//  HappyDiary
//
//  Created by 孙震 on 14-6-25.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import "YCSpecialDayView.h"

@implementation YCSpecialDayView


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
    _backImageView.image = [UIImage imageNamed:@"blueSky"];
    [self addSubview:_backImageView];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(-20, 40, 320, 100)];
    self.imageView.image = [UIImage imageNamed:@"deco_sticker_mygom9"];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_imageView];
//    [_imageView release];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 149, 300, self.bounds.size.height - 164) style:UITableViewStylePlain];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 149, 300, self.bounds.size.height - 164)];
    imageView.image = [UIImage imageNamed:@"fy"];
    self.tableView.backgroundView = imageView;
    [self addSubview:_tableView];
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
