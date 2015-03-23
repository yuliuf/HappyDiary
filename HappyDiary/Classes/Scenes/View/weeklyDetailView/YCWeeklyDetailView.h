//
//  YCWeeklyDetailView.h
//  HappyDiary
//
//  Created by 刘翔宇 on 14-6-30.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCWeeklyDetailView : UIView

@property (nonatomic , retain) UITapGestureRecognizer *tap;     //该view的轻怕事件

@property (nonatomic , retain) UIImageView *iconImageView;
@property (nonatomic , retain) UILabel *title;
@property (nonatomic , retain) UILabel *day;
@property (nonatomic , retain) UIImageView *contentImageView;

@end
