//
//  YCDeleteHourglassView.m
//  HappyDiary
//
//  Created by 孙震 on 14-6-25.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "YCDeleteHourglassView.h"

@implementation YCDeleteHourglassView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addAllViews];
    }
    return self;
}

- (void)addAllViews
{
    self.noticeLabel = [[[UILabel alloc] initWithFrame:CGRectMake(25, 20, 140, 30)] autorelease];
    _noticeLabel.text = @"确定要删除吗";
    _noticeLabel.font = [UIFont fontWithName:@"LiDeBiao-Xing-3.0" size:20.f];
    _noticeLabel.textColor = UIColorFromRGB(0xAA7700);
    _noticeLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_noticeLabel];
    
    self.nameTextField = [[[UITextField alloc] initWithFrame:CGRectMake(25, 60, 140, 30)] autorelease];
    _nameTextField.textAlignment = NSTextAlignmentCenter;
    _nameTextField.borderStyle = UITextBorderStyleRoundedRect;
    _nameTextField.placeholder = @"输入沙漏名字";
    _nameTextField.tag = 403;
    _nameTextField.textColor = UIColorFromRGB(0xFF8800);
    [self addSubview:_nameTextField];
    
    self.saveButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_saveButton setTitle:@"删除" forState:UIControlStateNormal];
    self.saveButton.titleLabel.font = [UIFont fontWithName:@"LiDeBiao-Xing-3.0" size:18.f];
    _saveButton.frame = CGRectMake(35, 100, 60, 30);
    [self addSubview:_saveButton];
    
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    self.cancelButton.titleLabel.font = [UIFont fontWithName:@"LiDeBiao-Xing-3.0" size:18.f];
    _cancelButton.frame = CGRectMake(95, 100, 60, 30);
    [self addSubview:_cancelButton];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
