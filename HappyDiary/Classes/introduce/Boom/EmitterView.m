//
//  EmitterView.m
//  ui-4.1
//
//  Created by 孙震 on 14-5-18.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import "EmitterView.h"

@implementation EmitterView
{
    CAEmitterLayer *_emitterView; // 1
}

- (void)dealloc
{
    [_emitterView release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //  set ref to the layer
        _emitterView = (CAEmitterLayer *)self.layer; // 2
        _emitterView.renderMode = kCAEmitterLayerAdditive; //  选择渲染模式
        _emitterView.emitterShape = kCAEmitterLayerLine; //
    
        CAEmitterCell *fire = [CAEmitterCell emitterCell];
        fire.birthRate = 5;  //  粒子出生率
        fire.lifetime = 1.0; //  粒子生命周期
        fire.lifetimeRange = 0;  //  生命时间变化范围
        
        fire.color = [[UIColor colorWithRed:0.8 green:1.0 blue:0.8 alpha:0.8] CGColor];  //  粒子颜色
        fire.contents = (id)[[UIImage imageNamed:@"snow.png"] CGImage];  //  cell内容，一般为一个CGImage
        fire.velocity = 30; //  速度
        fire.velocityRange = 1; //  速度范围
        fire.emissionRange = 2; //  发射角度
        fire.scaleSpeed = 0.3;  //  变大速度
        fire.spin = 3;  //  旋转
        [fire setName:@"fire"];  //  cell名字，方便以后根据名字查找修改
        
        _emitterView.emitterCells = [NSArray arrayWithObject:fire];
        
            }
    return self;
}

+ (Class)layerClass // 3
{
    return [CAEmitterLayer class];
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
