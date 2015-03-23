//
//  YCWeeklyDetailView.h
//  HappyDiary
//
//  Created by 刘翔宇 on 14-6-30.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCWeeklyDetailView : UIView

@property (nonatomic , strong) UITapGestureRecognizer *tap;     //该view的轻怕事件

@property (nonatomic , strong) UIImageView *iconImageView;
@property (nonatomic , strong) UILabel *title;
@property (nonatomic , strong) UILabel *day;
@property (nonatomic , strong) UIImageView *contentImageView;

@end
