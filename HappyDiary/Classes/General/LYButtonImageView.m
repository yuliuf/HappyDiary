//
//  LYButtonImageView.m
//  HappyDiary
//
//  Created by liuyu on 14-6-22.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import "LYButtonImageView.h"

@interface LYButtonImageView ()
{
    id _target;
    SEL _action;
    UIControlEvents _controlEvents;
}
@end

@implementation LYButtonImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.content = [[UILabel alloc] initWithFrame:Rect(10, 10, frame.size.width - 20, frame.size.height - 20)];
        _content.backgroundColor = [UIColor clearColor];
        _content.numberOfLines = 0;
        _content.textAlignment = NSTextAlignmentCenter;
        _content.font = myZitiBig;
        [self addSubview:_content];
        
        self.userInteractionEnabled = YES;
        
    }
    return self;
}

- (id)initWithImage:(UIImage *)image
{
    self = [super initWithImage:image];
    if (self) {
        CGSize size = image.size;
        self.content = [[UILabel alloc] initWithFrame:Rect(10, 10, size.width - 20, size.height - 20)];
        _content.backgroundColor = [UIColor clearColor];
        _content.numberOfLines = 0;
        _content.textAlignment = NSTextAlignmentCenter;
        _content.font = myZitiBig;
        [self addSubview:_content];
        
        self.userInteractionEnabled = YES;
    }
    return self;
}

//- (void)setFrame:(CGRect)frame
//{
//    self.content = [[UILabel alloc] initWithFrame:Rect(10, 10, frame.size.width - 20, frame.size.height - 20)];
//    _content.text = @"hhhaha";
//    _content.backgroundColor = [UIColor redColor];
//    [self addSubview:_content];
//}
#pragma mark 获取方法中的值
- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    _target = target;
    _action = action;
    _controlEvents = controlEvents;
}

#pragma mark 重写触摸结束方法
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //  判断触摸的方式
    if (_controlEvents == UIControlEventTouchUpInside) {
        //  给_target对象，发送_action消息， 并把self作为对象传递出去
        [_target performSelector:_action withObject:self];
    }
}



@end
