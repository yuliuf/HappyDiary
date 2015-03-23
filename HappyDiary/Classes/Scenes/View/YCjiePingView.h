//
//  YCjiePingView.h
//  YuGeV5
//
//  Created by liuyu on 14-6-28.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCjiePingView : UIImageView<UIGestureRecognizerDelegate>

@property (nonatomic , assign) CGPoint beginPoint;

@property (nonatomic , retain) UIImageView *jiepingImageView;

@property (nonatomic , retain) UIButton *finishButton;      //完成按钮

@property (nonatomic , retain) UIButton *cancelButton;      //取消按钮

@property (nonatomic , assign) NSInteger biaoji;

@property (nonatomic , assign) UITapGestureRecognizer *tap;
@property (nonatomic, assign) UILongPressGestureRecognizer *longPressTap;

@end
