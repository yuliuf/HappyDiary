//
//  LYLockView.h
//  HappyDiary
//
//  Created by liuyu on 14-7-1.
//  Copyright (c) 2014年/Users/RainbowYu/Desktop/HappyDiary 4.1 2/HappyDiary/test.png RainbowYu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYButtonImageView.h"


@interface LYLockView : UIView
@property (nonatomic, strong)UIImageView *backgroundImageView;
@property (nonatomic, strong)LYButtonImageView *lockImageView;
@property (nonatomic, strong)UITextField *pwdTextField;
@property (nonatomic, strong)UILabel *alertLabel;
@property (nonatomic, strong)UITapGestureRecognizer *tap;

@end
