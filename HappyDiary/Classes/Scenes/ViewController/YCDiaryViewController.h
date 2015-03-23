//
//  YCDiaryViewController.h
//  HappyDiary
//
//  Created by 孙震 on 14-6-20.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LYTuyaBan;
@class LYTuyaView;

@interface YCDiaryViewController : LYBaseViewController

@property (nonatomic , strong) UIImageView *jiepingImageView;
@property (nonatomic , strong) UIButton *finishButton;
@property (nonatomic , strong) UIButton *cancelButton;


@property (nonatomic , assign) CGPoint beginPoint;

@property (nonatomic , assign) CGPoint nowPoint;

@property (nonatomic , assign) CGFloat beginX;

@property (nonatomic , assign) CGFloat beginY;

@property (nonatomic , assign) CGFloat nowX;

@property (nonatomic , assign) CGFloat nowY;

@property (nonatomic , assign) CGFloat width;

@property (nonatomic , assign) CGFloat height;

@property (nonatomic , assign) CGFloat jiaodu;

@property (nonatomic , assign) CGRect frame;

@property (nonatomic , strong) LYTuyaBan *tuyaBan;  //刘玉涂鸦板

@property (nonatomic , strong) LYTuyaView *tuyaView;    //刘玉涂鸦view



@end
