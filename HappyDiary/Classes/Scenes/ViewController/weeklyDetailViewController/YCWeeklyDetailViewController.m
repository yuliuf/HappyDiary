//
//  YCWeeklyDetailViewController.m
//  HappyDiary
//
//  Created by 刘翔宇 on 14-6-30.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import "YCWeeklyDetailViewController.h"
#import "YCWeeklyDetailView.h"
//#import "LYCustomTabBar.h"

@interface YCWeeklyDetailViewController ()

@end

@implementation YCWeeklyDetailViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    self.weeklyDetailView = [[YCWeeklyDetailView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view = _weeklyDetailView;
    
    _weeklyDetailView.iconImageView.image = _iconImage;
    _weeklyDetailView.title.text = _Mytitle;
    _weeklyDetailView.day.text = _day;
    _weeklyDetailView.contentImageView.image = _contentImage;
   
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //view上轻怕事件的代理
    [_weeklyDetailView.tap addTarget:self action:@selector(tapAction:)];
    
    
    
}

//view上轻怕事件的监听方法
- (void)tapAction:(UITapGestureRecognizer *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
 
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//隐藏网络和时间等信息
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
