//
//  lxyIntroduceViewController.m
//  Introduce
//
//  Created by 刘翔宇 on 14-6-22.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import "lxyIntroduceViewController.h"
#include "lxyIntroduce.h"
#import "LYRoomViewViewController.h"

@interface lxyIntroduceViewController ()

@end

@implementation lxyIntroduceViewController

- (void)dealloc
{
    [_introduceView release];
    
    [super dealloc];
}

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
    self.introduceView = [[[lxyIntroduce alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.view = _introduceView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //立即体验按钮的监听事件
    [_introduceView.loginBtn addTarget:self action:@selector(loginBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

//立即体验按钮的监听事件
- (void)loginBtnAction:(UIButton *)sender
{
    NSLog(@"jjdlfj");
    
    LYRoomViewViewController *rootVC = [[LYRoomViewViewController alloc] init];
//    self.window.rootViewController = rootVC;
//    rootVC.modalPresentationStyle = UIModalPresentationPageSheet;
    rootVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self presentViewController:rootVC animated:YES completion:nil];
    [rootVC release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
