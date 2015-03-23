//
//  LYCustomCell.m
//  HappyDiary
//
//  Created by liuyu on 14-6-25.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import "LYCustomCell.h"
#import "LYMoveImageView.h"

@implementation LYCustomCell

- (void)dealloc
{
    [_image release];
    
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.image = [[[UIImageView alloc] initWithFrame:Rect(0, 5, 40, 50)] autorelease];
        self.image.backgroundColor = [UIColor clearColor];
        self.image.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_image];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
