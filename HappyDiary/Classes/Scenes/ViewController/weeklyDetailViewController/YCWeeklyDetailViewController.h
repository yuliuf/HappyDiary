//
//  YCWeeklyDetailViewController.h
//  HappyDiary
//
//  Created by 刘翔宇 on 14-6-30.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YCWeeklyDetailView;

@interface YCWeeklyDetailViewController : UIViewController

@property (nonatomic ,strong) YCWeeklyDetailView *weeklyDetailView;

@property (nonatomic , strong) UIImage *iconImage;
@property (nonatomic , copy) NSString *Mytitle;
@property (nonatomic , copy) NSString *day;
@property (nonatomic , strong) UIImage *contentImage;

@end
