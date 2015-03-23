//
//  YCjiePingView.h
//  YuGeV5
//
//  Created by liuyu on 14-6-28.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCjiePingView : UIImageView<UIGestureRecognizerDelegate>

@property (nonatomic , assign) CGPoint beginPoint;

@property (nonatomic , strong) UIImageView *jiepingImageView;

@property (nonatomic , strong) UIButton *finishButton;      //完成按钮

@property (nonatomic , strong) UIButton *cancelButton;      //取消按钮

@property (nonatomic , assign) NSInteger biaoji;

@property (nonatomic , strong) UITapGestureRecognizer *tap;
@property (nonatomic, strong) UILongPressGestureRecognizer *longPressTap;

@end
