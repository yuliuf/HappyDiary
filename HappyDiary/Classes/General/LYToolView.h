//
//  LYToolView.h
//  HappyDiary
//
//  Created by liuyu on 14-6-20.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYToolView : UIView

@property (nonatomic, copy) NSString *title;  //  标题
@property (nonatomic, strong) UILabel *titleLbl; //  标题label
@property (nonatomic, strong) UIButton *closeBtn;  // 关闭按钮

- (LYToolView *)initWithTitle:(NSString *)title withFrame:(CGRect)frame;

@end
