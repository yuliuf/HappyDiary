//
//  YCHourglassView.h
//  HappyDiary
//
//  Created by 孙震 on 14-6-20.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCHourglassView : UIView

@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, retain) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, retain) UIButton *addButton;
@property (nonatomic, retain) UIButton *deleteButton;
@property (nonatomic, retain) UIImageView *imageView;

@end
