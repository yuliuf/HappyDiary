//
//  lxyDailyView.h
//  EventController
//
//  Created by 刘翔宇 on 14-6-20.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface lxyDailyView : UIView

@property (nonatomic , retain) UIButton *monthlyButton1;

@property (nonatomic , retain) UIButton *weeklyButton1;

@property (nonatomic , retain) UIButton *dailyButton2;

@property (nonatomic , retain) UIButton *personDataButton1;

@property (nonatomic , retain) UIImageView *imageView;

@property (nonatomic , retain) UIImageView *imageViewTitle;

@property (nonatomic , retain) UIScrollView *scroller;




@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UISearchBar *searchBar;
@property (nonatomic, retain) UIImageView *titleView;

@property (nonatomic , retain) UIButton *dailyBackButton;   //返回按钮

@end
