//
//  lxyWeeklyView.h
//  EventController
//
//  Created by 刘翔宇 on 14-6-20.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class lxyCommonCell;

@interface lxyWeeklyView : UIView<UICollectionViewDataSource , UICollectionViewDelegateFlowLayout , UIGestureRecognizerDelegate>
{
    NSDate *dtForMonth;
    int originX,originY;
}

@property (nonatomic , strong) UIButton *monthlyButton1;

@property (nonatomic , strong) UIButton *weeklyButton2;

@property (nonatomic , strong) UIButton *dailyButton1;

@property (nonatomic , strong) UIButton *personDataButton1;

@property (nonatomic , strong) UIImageView *imageView;          //背景图片

@property (nonatomic , strong) UIImageView *imageViewTitle;     //title背景图片

@property (nonatomic, strong) UICollectionView *collection;

@property (nonatomic , strong) UICollectionViewFlowLayout *layout;

@property (nonatomic , strong) lxyCommonCell *commonCell;       //自定义cell

@property (nonatomic , strong) UISwipeGestureRecognizer *swipGesture;       //滑屏手势

@end
