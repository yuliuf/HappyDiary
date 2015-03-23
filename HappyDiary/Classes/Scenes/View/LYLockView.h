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
@property (nonatomic, retain)UIImageView *backgroundImageView;
@property (nonatomic, retain)LYButtonImageView *lockImageView;
@property (nonatomic, retain)UITextField *pwdTextField;
@property (nonatomic, retain)UILabel *alertLabel;
@property (nonatomic, assign)UITapGestureRecognizer *tap;

@end
