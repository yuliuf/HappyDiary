//
//  lxyDailyView.h
//  EventController
//
//  Created by 刘翔宇 on 14-6-20.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface lxyDailyView : UIView

@property (nonatomic , strong) UIButton *monthlyButton1;

@property (nonatomic , strong) UIButton *weeklyButton1;

@property (nonatomic , strong) UIButton *dailyButton2;

@property (nonatomic , strong) UIButton *personDataButton1;

@property (nonatomic , strong) UIImageView *imageView;

@property (nonatomic , strong) UIImageView *imageViewTitle;

@property (nonatomic , strong) UIScrollView *scroller;




@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UIImageView *titleView;

@property (nonatomic , strong) UIButton *dailyBackButton;   //返回按钮

@end
