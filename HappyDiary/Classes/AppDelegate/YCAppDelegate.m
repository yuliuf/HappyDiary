//
//  YCAppDelegate.m
//  HappyDiary
//
//  Created by 孙震 on 14-6-20.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import "YCAppDelegate.h"
//#import "YCDiaryViewController.h"
//#import "lxyEventViewController.h"
//#import "YCHourglassViewController.h"
//#import "YCSetttingViewController.h"
#import "LYRoomViewViewController.h"
//#import "LYTabBarController.h"
#import "lxyIntroduceViewController.h"
#import "LYLockViewController.h"
#import "lxyUserTableModel.h"


@implementation YCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    
    NSUserDefaults *userDefaluts = [NSUserDefaults standardUserDefaults];
//
//    if (![[userDefaluts objectForKey:@"key"] isEqualToString:@"121"]) {
//        [userDefaluts setObject:@"121" forKey:@"key"];
//        
//        lxyIntroduceViewController *introduceVC = [[lxyIntroduceViewController new] autorelease];
//        self.window.rootViewController = introduceVC;
//        
//        //同步
//        [userDefaluts synchronize];
//    } else {
//        //        [NSFileManager defaultManager];
//        LYRoomViewViewController *rootVC = [[LYRoomViewViewController alloc] init];
//        self.window.rootViewController = rootVC;
//        [rootVC release];
//        
//    }
//    
    //  第一次运行创建数据表
    BOOL b = [userDefaluts boolForKey:@"isFirst"];
    if (!b) {
        
        lxyIntroduceViewController *introduceVC = [[lxyIntroduceViewController new] autorelease];
        self.window.rootViewController = introduceVC;
        
        //同步
        [userDefaluts synchronize];

        
        //  创建表
        [lxyFunctionOfDataBase createOneTable:@"sandTimerTable"];
        [lxyFunctionOfDataBase createOneTable:@"commonDiaryTable"];
        [lxyFunctionOfDataBase createOneTable:@"backGroundImageTable"];
        [lxyFunctionOfDataBase createOneTable:@"alonePersonTable"];
//        [lxyFunctionOfDataBase createOneTable:@"userTable"];
        [lxyFunctionOfDataBase createOneTable:@"diaryTable"];
        [lxyFunctionOfDataBase createOneTable:@"specialDayTable"];
        [[lxyDataBase shareLxyDataBase] createUserTable];
        
        lxyUserTableModel *model = [[[lxyUserTableModel alloc] initWithID:0 andName:nil andPWD:nil andBirthday:nil andHeaderImage:nil andIntroduce:nil andPhoto1:nil andPhoto2:nil] autorelease];
        [[lxyDataBase shareLxyDataBase] insertToUserTableWithOneUserTableModel:model];
                            

        
        //  取消第一次
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isFirst"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        
        if ([userDefaluts boolForKey:@"isSetPwd"]) {
            LYLockViewController *lockVC = [LYLockViewController new];
            self.window.rootViewController = lockVC;
            [lockVC release];
        } else {
            LYRoomViewViewController *rootVC = [[LYRoomViewViewController alloc] init];
            self.window.rootViewController = rootVC;
            [rootVC release];
            
        }
    }


    
    
    
//    lxyIntroduceViewController *introduceVC = [lxyIntroduceViewController new];
//    self.window.rootViewController = introduceVC;
    
    

    
    
    
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    [self.window makeKeyAndVisible];
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
