//
//  lxyWeeklyView.h
//  EventController
//
//  Created by 刘翔宇 on 14-6-20.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
@class lxyCommonCell;

@interface lxyWeeklyView : UIView<UICollectionViewDataSource , UICollectionViewDelegateFlowLayout , UIGestureRecognizerDelegate>
{
    NSDate *dtForMonth;
    int originX,originY;
}

@property (nonatomic , retain) UIButton *monthlyButton1;

@property (nonatomic , retain) UIButton *weeklyButton2;

@property (nonatomic , retain) UIButton *dailyButton1;

@property (nonatomic , retain) UIButton *personDataButton1;

@property (nonatomic , retain) UIImageView *imageView;          //背景图片

@property (nonatomic , retain) UIImageView *imageViewTitle;     //title背景图片

@property (nonatomic, retain) UICollectionView *collection;

@property (nonatomic , retain) UICollectionViewFlowLayout *layout;

@property (nonatomic , retain) lxyCommonCell *commonCell;       //自定义cell

@property (nonatomic , retain) UISwipeGestureRecognizer *swipGesture;       //滑屏手势

@end
