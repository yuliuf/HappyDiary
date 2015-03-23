//
//  LYMoveImageView.m
//  HappyDiary
//
//  Created by liuyu on 14-6-26.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import "LYMoveImageView.h"

@interface LYMoveImageView ()

@property (nonatomic,assign) CGPoint beganPoint;

@end

@implementation LYMoveImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    self.beganPoint = [touch locationInView:self];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    //  获取手指触摸的一些信息
    UITouch *touch = [touches anyObject];
    //  根据当前视图获取点的信息
    CGPoint nowPoint = [touch locationInView:self];
    //  打印点的信息
    float x = nowPoint.x - self.beganPoint.x;
    float y = nowPoint.y - self.beganPoint.y;
    
    self.center = CGPointMake(self.center.x + x, self.center.y + y);
    
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
