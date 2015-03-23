//
//  LYToolBarView.m
//  HappyDiary
//
//  Created by 刘翔宇 on 14-6-24.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import "LYToolBarView.h"



@implementation LYToolBarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

#pragma mark 初始化方法
-(id)initWithFrame:(CGRect)frame withArray:(NSArray *)Array
{
    if ([self initWithFrame:frame]) {
        self.toolArray = Array;
    }
    return self;
}

-(void)setToolArray:(NSArray *)toolArray
{
    
    
    for (UIView *view in [self subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            [view removeFromSuperview];
        }
    }
    CGFloat btnWidth = self.frame.size.width - 10;
    CGFloat btnHeight = 40;
    self.scrollEnabled = NO;
    
    
    CGRect newRect = Rect(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, btnHeight * toolArray.count);
    self.frame = newRect;
    
    if (toolArray.count > 6) {
        self.scrollEnabled = YES;
        self.showsVerticalScrollIndicator = NO;
        CGRect newRect = Rect(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 240);
        self.frame = newRect;
        self.contentSize = CGSizeMake(btnHeight, btnHeight * toolArray.count);
    }
    
    for (int i = 0; i < toolArray.count; i ++) {
        
        //            NSInteger i = toolArray.count;
        
        UIButton *btn = [[UIButton alloc] initWithFrame:Rect(0, i * btnHeight, btnWidth, btnHeight)];
        btn.tag = 100 + i;
        btn.backgroundColor = [UIColor whiteColor];
        btn.layer.borderWidth = 1.f;
        btn.layer.borderColor = [UIColor grayColor].CGColor;
        btn.layer.cornerRadius = 6;
        [btn setBackgroundImage:[UIImage imageNamed:toolArray[i]] forState:UIControlStateNormal];
        [self addSubview:btn];
    }
    
}
@end
