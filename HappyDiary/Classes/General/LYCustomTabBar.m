//
//  LYCustomTabBar.m
//  YuGeV5
//
//  Created by liuyu on 14-6-23.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "LYCustomTabBar.h"

#import "YCDiaryViewController.h"
//#import "YCSetttingViewController.h"
//#import "YCSetttingViewController.h"
#import "lxyEventViewController.h"
#import "YCHourglassViewController.h"
#import "lxySettingViewController.h"

@interface LYCustomTabBar ()

@end

@implementation LYCustomTabBar
- (void)dealloc
{
    [_buttons release];    
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [self hideRealTabBar];
    [self customTabBar];
}

#pragma mark 设置自定义tabBar是否隐藏
- (void)setIfHidden:(BOOL)ifHidden
{
//    for(UIView *view in self.view.subviews){
//        
//        if([view isMemberOfClass:[UIButton class]]){
//            view.hidden = YES;
//            break;
//            
//        }
//    }
    
    
//    NSLog(@"%d", _buttons.count);
//    for (int i = 0; i < _buttons.count; i ++) {
//        UIButton *btn = (UIButton *)[self.view viewWithTag:i];
//        btn.hidden = YES;
//    }

}
#pragma mark 隐藏原来的tabBar
- (void)hideRealTabBar{
    
    for(UIView *view in self.view.subviews){
        
        if([view isKindOfClass:[UITabBar class]]){
            
            view.hidden = YES;
            
            break;
            
        }
        
    }
}
#pragma mark 显示自定义的
- (void)customTabBar{
    
    
    
    YCDiaryViewController *diaryVC = [YCDiaryViewController new];
    
    lxyEventViewController *eventVC = [lxyEventViewController new];
    
    YCHourglassViewController *hourglassVC = [YCHourglassViewController new];
    
//    YCSetttingViewController *settingVC = [YCSetttingViewController new];
    lxySettingViewController *settingVC = [lxySettingViewController new];
    
    //  设置tabBar为根视图控制器 最后加上首页
    
    
    self.viewControllers = [[[NSArray alloc] init] autorelease];
    self.viewControllers = @[diaryVC, eventVC, hourglassVC, settingVC];
    //self.selectedIndex = 0;
    
    
    [diaryVC release];
    [eventVC release];
    [hourglassVC release];
    [settingVC release];
    
    
    //  创建按钮
    NSArray *array = nil;
    array = @[@"日记",@"事件",@"沙漏",@"设置"];
    int viewCount = self.viewControllers.count > 5 ? 5 : self.viewControllers.count;
    
    _buttons = [NSMutableArray arrayWithCapacity:viewCount];
    
    double _width = 320 / viewCount - 10;
    
    for (int i = 0; i < viewCount; i++) {

        UIButton *btn = [[[UIButton alloc] init] autorelease];
        
        btn.frame = CGRectMake(35 + i*_width,self.tabBar.frame.origin.y, _width - 10 , 25);
        UIImage *image = [UIImage imageNamed:@"intro_menu_brown"];
        [btn setBackgroundImage:image forState:UIControlStateNormal];

        btn.titleLabel.font = [UIFont fontWithName:ziti size:17.f];
        [btn setTitle:array[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(selectedTab:) forControlEvents:UIControlEventTouchUpInside];
        
        btn.tag = i;
        
        [self.buttons addObject:btn];
        
        [self.view addSubview:btn];
        
//        [btn release];
    }

    NSLog(@"%d", self.selectedIndex);
    UIButton *selectedButton = (UIButton *)[self.view viewWithTag:self.selectedIndex];
    [self selectedTab:selectedButton];

}
 -(void)selectedTab:(UIButton *)button
{
        
    self.selectedIndex = button.tag;

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
