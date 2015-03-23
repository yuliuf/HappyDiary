//
//  LYCustomTextField.m
//  textFieldView
//
//  Created by 刘翔宇 on 14-6-28.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import "LYCustomTextField.h"

@implementation LYCustomTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.textView = [[UITextView alloc] initWithFrame:Rect(10, 10, self.frame.size.width - 10, self.frame.size.height - 20)];
        self.textView.scrollEnabled = NO;
        self.textView.font = myZiti;
//        self.textView.text = @"最多可输入10个字符";
//        self.textView.textColor = [UIColor grayColor];
        self.textView.userInteractionEnabled = NO;
        self.textView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.textView];
        
    }
    return self;
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
