//
//  YCDetailCell.m
//  Diary
//
//  Created by 孙震 on 14-6-19.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import "YCDetailCell.h"
//#define kMargin 10
#define kWidth 200
#define kHeight 30

@implementation YCDetailCell
@synthesize iconView = _iconView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addAllViews];
    }
    return self;
}

- (void)addAllViews
{
    self.contentLabel = [[[UILabel alloc] initWithFrame:CGRectMake(kMargin + 45, kMargin / 2, kWidth, kHeight)] autorelease];
    self.contentLabel.font = [UIFont fontWithName:@"LiDeBiao-Xing-3.0" size:19.f];
    self.contentLabel.textColor = UIColorFromRGB(0xFFAA33);
    [self addSubview:_contentLabel];
    
    self.iconView = [[[UIImageView alloc] initWithFrame:CGRectMake(kMargin, 0, 34.3, 40)] autorelease];
    [self addSubview:_iconView];
    
//    self.yearLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMargin, kMargin / 2, 20, 20)];
//    self.yearLabel.backgroundColor = [UIColor yellowColor];
//    [self addSubview:_yearLabel];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
