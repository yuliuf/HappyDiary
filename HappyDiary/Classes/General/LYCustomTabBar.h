//
//  LYCustomTabBar.h
//  YuGeV5
//
//  Created by liuyu on 14-6-23.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYCustomTabBar : UITabBarController


@property (nonatomic,assign) int currentSelectedIndex;

@property (nonatomic,strong) NSMutableArray *buttons;


- (void)hideRealTabBar;
- (void)customTabBar;
- (void)selectedTab:(UIButton *)button;
- (void)setIfHidden:(BOOL)ifHidden;


@end
