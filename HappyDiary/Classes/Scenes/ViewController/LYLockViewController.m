//
//  LYLockViewController.m
//  HappyDiary
//
//  Created by liuyu on 14-7-1.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import "LYLockViewController.h"
#import "LYLockView.h"
#import "lxyUserTableModel.h"
#import "LYRoomViewViewController.h"

@interface LYLockViewController () <UITextFieldDelegate>
@property (nonatomic, strong)LYLockView *lockView;
@end

@implementation LYLockViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)loadView
{
    self.lockView = [[LYLockView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.lockView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self.lockView.lockImageView addTarget:self action:@selector(lockAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.lockView.tap addTarget:self action:@selector(tapAction:)];
}
- (void)tapAction:(UITapGestureRecognizer *)sender
{
    [self.lockView endEditing:YES];
}
#pragma mark 获取用户密码

- (NSString *)getPwd
{
    NSMutableArray *array = [[lxyDataBase shareLxyDataBase] searchAllDataFromUserTable];
    lxyUserTableModel *model = array[0];
    if (![model.user_pwd isEqualToString:@"(null)"]) {
        return model.user_pwd;
    }
    return @"no pwd";
}
- (void)lockAction:(UIButton *)sender
{
    if ([self.lockView.pwdTextField.text isEqualToString:[self getPwd]]) {
        self.lockView.lockImageView.image = [UIImage imageNamed:@"unlock"];
        LYRoomViewViewController *roomVC = [[LYRoomViewViewController alloc] init];
        [self presentViewController:roomVC animated:YES completion:nil];
    } else {
        self.lockView.alertLabel.alpha = 1.f;
        self.lockView.alertLabel.text = @"密码不正确！";
        self.lockView.pwdTextField.text = @"";
//        [self shakeAnimationForView:self.lockView.lockImageView];
        [LYHelper shakeAnimationForView:self.lockView.lockImageView];
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
