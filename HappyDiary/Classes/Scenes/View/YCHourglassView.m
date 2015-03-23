//
//  YCHourglassView.m
//  HappyDiary
//
//  Created by 孙震 on 14-6-20.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import "YCHourglassView.h"
#define kWidth 100
#define kHeight 30

@implementation YCHourglassView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addAllViews];
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"shalou4"]];
    }
    return self;
}

- (void)addAllViews
{
    /*
    //  初始化nameLabel
    self.nameLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, kHeight)] autorelease];
    //self.nameLabel.text = @"点点滴滴在心间";
    self.nameLabel.font = [UIFont fontWithName:@"LiDeBiao-Xing-3.0" size:22.f];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel.textColor = UIColorFromRGB(0xAA7700);
    self.nameLabel.backgroundColor = UIColorFromRGB(0x77FFCC);
    [self addSubview:_nameLabel];
     */
    
    self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    _imageView.image = [UIImage imageNamed:@"blueSky"];
    [self addSubview:_imageView];
    
    //  初始化flowLayout
    self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.flowLayout.itemSize = CGSizeMake(100, 100);
    self.flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    //  初始化collectionView
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(40, 195, 240, (self.bounds.size.height - 360) * self.bounds.size.height / 568) collectionViewLayout:_flowLayout];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 240, 220)];
    backImageView.image = [UIImage imageNamed:@"blue"];
    self.collectionView.backgroundView = backImageView;
    [self addSubview:_collectionView];
    
    /*
    //  初始化addButton
    self.addButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.addButton.frame = CGRectMake(20, 0, 60, 30);
    [self.addButton setTitle:@"添加" forState:UIControlStateNormal];
    self.addButton.titleLabel.font = [UIFont fontWithName:@"LiDeBiao-Xing-3.0" size:20.f];
    [self addSubview:_addButton];
    
    //  初始化deleteButton
    self.deleteButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.deleteButton.frame = CGRectMake(250, 0, 60, 30);
    [self.deleteButton setTitle:@"删除" forState:UIControlStateNormal];
    self.deleteButton.titleLabel.font = [UIFont fontWithName:@"LiDeBiao-Xing-3.0" size:20.f];
    [self addSubview:_deleteButton];
     */
    
    self.addButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _addButton.frame = Rect(60, ScreenHeight - 55, 60, 30);
    [_addButton setTitle:@"添加" forState:UIControlStateNormal];
    _addButton.tintColor = [UIColor whiteColor];
    _addButton.titleLabel.font = myZiti;
    [_addButton setBackgroundImage:[UIImage imageNamed:@"intro_menu_brown"] forState:UIControlStateNormal];
    [self addSubview:_addButton];
    
    
    self.deleteButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _deleteButton.frame = Rect(200, ScreenHeight - 55, 60, 30);
    [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
    _deleteButton.tintColor = [UIColor whiteColor];
    _deleteButton.titleLabel.font = myZiti;
    [_deleteButton setBackgroundImage:[UIImage imageNamed:@"intro_menu_brown"] forState:UIControlStateNormal];
    [self addSubview:_deleteButton];
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
