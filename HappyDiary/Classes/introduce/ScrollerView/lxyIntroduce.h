//
//  lxyIntroduce.h
//  Introduce
//
//  Created by 刘翔宇 on 14-6-22.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EmitterView;

@interface lxyIntroduce : UIView<UIScrollViewDelegate>

@property (nonatomic , retain) UIScrollView *scroller;

@property (nonatomic , retain) UIButton *loginBtn;          //登录按钮

@property (nonatomic , retain) UIPageControl *pageControll; //页面控制器

@property (nonatomic , retain) EmitterView *boom;           //button的爆咋效果

@end
