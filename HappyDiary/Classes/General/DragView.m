//
//  DragView.m
//  lesson5
//
//  Created by liuyu on 14-5-16.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import "DragView.h"

@interface DragView ()
//@property (nonatomic, assign)CGFloat x;
//@property (nonatomic, assign)CGFloat y;
@property (nonatomic,assign) CGPoint beganPoint;
@end

@implementation DragView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
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

@end
