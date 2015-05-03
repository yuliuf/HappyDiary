//
//  LYBaseViewController.m
//  HappyDiary
//
//  Created by liuyu on 14-6-23.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import "LYBaseViewController.h"

@interface LYBaseViewController ()

@property (nonatomic, strong) UIButton *backButton;

@end

@implementation LYBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _backButton.frame = CGRectMake(0, 5, 40, 40);
    [_backButton setBackgroundImage:[UIImage imageNamed:@"diary_out"] forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:_backButton];
}

#pragma mark 返回按钮事件
- (void)backButtonAction:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)hiddenBackButton:(BOOL)isHidden
{
    self.backButton.hidden = isHidden;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
