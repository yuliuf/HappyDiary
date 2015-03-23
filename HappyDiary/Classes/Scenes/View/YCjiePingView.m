//
//  YCjiePingView.m
//  YuGeV5
//
//  Created by liuyu on 14-6-28.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "YCjiePingView.h"

@implementation YCjiePingView

- (UITapGestureRecognizer *)tap
{
    if (nil == _tap) {
        self.tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:_tap];
    }
    return _tap;
}


- (void)tapAction:(UITapGestureRecognizer *)sender
{
    [self.layer removeAllAnimations];
    self.cancelButton.hidden = YES;
    if (self.layer.borderWidth == 0) {
        self.layer.borderWidth = 0.8f;
        for (UIView *view in self.subviews) {
            view.userInteractionEnabled = NO;
        }
    } else {
        self.layer.borderWidth = 0.f;
        for (UIView *view in self.subviews) {
            view.userInteractionEnabled = YES;
        }    }
}

-(UILongPressGestureRecognizer *)longPressTap
{
    if (nil == _longPressTap) {
        _longPressTap = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressTapAction:)];
        [self addGestureRecognizer:_longPressTap];
    }
    return _longPressTap;

    
}

- (void)longPressTapAction:(UILongPressGestureRecognizer *)sender
{
    self.cancelButton.hidden = NO;
    
    //  抖动效果
    CALayer*viewLayer=[self layer];
    CABasicAnimation*animation=[CABasicAnimation
                                
                                animationWithKeyPath:@"transform"];
    animation.duration=0.2;
    animation.repeatCount = 100000;
    animation.autoreverses=YES;
    animation.fromValue=[NSValue valueWithCATransform3D:CATransform3DRotate
                         
                         (viewLayer.transform, -0.05, 0.0, 0.0, 0.05)];
    animation.toValue=[NSValue valueWithCATransform3D:CATransform3DRotate
                       
                       (viewLayer.transform, 0.05, 0.0, 0.0, 0.05)];
    [viewLayer addAnimation:animation forKey:@"wiggle"];
    
}





- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
        self.layer.borderWidth = .8f;
        self.layer.borderColor = [[UIColor redColor] CGColor];
        self.cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _cancelButton.frame = Rect(Width(frame) - 20, 0, 20, 20);
        _cancelButton.hidden = YES;
        [_cancelButton setBackgroundImage:[UIImage imageNamed:@"cancleIcon"] forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_cancelButton];
        
        self.tap.delegate = self;
        self.longPressTap.delegate = self;
        
        
        
    }
    return self;
}



- (void)cancelButtonAction:(UIButton *)sender
{
    [self removeFromSuperview];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    self.beginPoint = [touch locationInView:self.superview];
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
        CGFloat touchX = _beginPoint.x;
        CGFloat touchY = _beginPoint.y;
        
        CGFloat hengX1 = self.frame.origin.x +10;    //上边框横坐标的起点
        CGFloat hengX2 = self.frame.origin.x + self.frame.size.width - 10;   //上边框横坐标的终点
        
        CGFloat shuY1 = self.frame.origin.y + 10;     //左边框纵坐标的起点
        CGFloat shuY2 = self.frame.origin.y + self.frame.size.height - 10;  //左边框纵坐标的终点
        
        //上边框的上下范围
        CGFloat shangY1 = self.frame.origin.y - 10;
        CGFloat shangY2 = self.frame.origin.y + 10;
        //下边框的上下范围
        CGFloat xiaY1 = self.frame.origin.y + self.frame.size.height - 10;
        CGFloat xiaY2 = self.frame.origin.y + self.frame.size.height + 10;
        
        //左边框的左右范围
        CGFloat zuoX1 = self.frame.origin.x - 10;
        CGFloat zuoX2 = self.frame.origin.x + 10;
        //右边框的左右范围
        CGFloat youX1 = self.frame.origin.x + self.frame.size.width - 10;
        CGFloat youX2 = self.frame.origin.x + self.frame.size.width + 10;
        
        
        //如果触摸点在上下边框上
        if((touchX > hengX1 && touchX < hengX2))
        {
            //在上边框上
            if(touchY > shangY1 && touchY < shangY2)
            {
                UITouch *touch = [touches anyObject];
                CGPoint point = [touch locationInView:self.superview];
                CGFloat nowY = point.y;
                CGFloat beginY;
                beginY = _beginPoint.y;
                CGFloat height = nowY - beginY;
                CGRect frame = self.frame;
                frame.origin.y = frame.origin.y + height;
                frame.size.height = frame.size.height - height;
                self.frame = frame;
                self.frame = frame;
                _cancelButton.frame = Rect(Width(self.frame) - 20, 0, 20, 20);
                _beginPoint = point;
                
            }
            
            //在下边框上
            if (touchY > xiaY1 && touchY < xiaY2) {
                CGFloat beginY = _beginPoint.y;
                UITouch *touch = [touches anyObject];
                CGPoint point = [touch locationInView:self.superview];
                CGFloat nowY = point.y;
                CGFloat height = nowY - beginY;
                CGRect frame = self.frame;
                frame.size.height = frame.size.height + height;
                self.frame = frame;
                self.frame = frame;
                 _cancelButton.frame = Rect(Width(self.frame) - 20, 0, 20, 20);
                _beginPoint = point;
            }
        }
        
        
        
        //如果触摸点在左右边框
        if(touchY > shuY1 && touchY < shuY2)
        {
            //在左边框上
            if(touchX > zuoX1 && touchX < zuoX2)
            {
                NSLog(@"左边框上");
                UITouch *touch = [touches anyObject];
                CGPoint point = [touch locationInView:self.superview];
                CGFloat beginX = _beginPoint.x;
                CGFloat nowX = point.x;
                CGFloat width = nowX - beginX;
                CGRect frame = self.frame;
                frame.origin.x = frame.origin.x + width;
                frame.size.width = frame.size.width - width;
                self.frame = frame;
                self.frame = frame;
                _cancelButton.frame = Rect(Width(self.frame) - 20, 0, 20, 20);
                _beginPoint = point;
                
            }
            
            //在右边框上
            if(touchX > youX1 && touchX < youX2)
            {
                CGFloat beginX = _beginPoint.x;
                UITouch *touce = [touches anyObject];
                CGPoint point = [touce locationInView:self.superview];
                CGFloat nowX = point.x;
                CGFloat width = nowX - beginX;
                CGRect frame = self.frame;
                frame.size.width = frame.size.width + width;
                self.frame = frame;
                self.frame = frame;
                _cancelButton.frame = Rect(Width(self.frame) - 20, 0, 20, 20);
                _beginPoint = point;
            }
        }
        
        
        //左上角范围
        CGFloat zuoshangX1 = self.frame.origin.x - 10;
        CGFloat zuoshangX2 = self.frame.origin.x + 10;
        CGFloat zuoshangY1 = self.frame.origin.y - 10;
        CGFloat zuoshangY2 = self.frame.origin.y + 10;
        
        //如果触摸点在左上角
        if (touchX > zuoshangX1 && touchX < zuoshangX2) {
            if(touchY > zuoshangY1 && touchY < zuoshangY2)
            {
                CGFloat beginX = _beginPoint.x;
                CGFloat beginY = _beginPoint.y;
                
                UITouch *touch = [touches anyObject];
                CGPoint point = [touch locationInView:self.superview];
                
                CGFloat nowX = point.x;
                CGFloat nowY = point.y;
                
                CGFloat width = nowX - beginX;
                CGFloat height = nowY - beginY;
                
                CGRect frame = self.frame;
                frame.origin.x = frame.origin.x + width;
                frame.size.width = frame.size.width - width;
                frame.origin.y = frame.origin.y + height;
                frame.size.height = frame.size.height - height;
                
                self.frame = frame;
                self.frame = frame;
                _cancelButton.frame = Rect(Width(self.frame) - 20, 0, 20, 20);
                _beginPoint = point;
                
            }
        }
        
        
        //右上角范围
        CGFloat youshangX1 = self.frame.origin.x + self.frame.size.width - 10;
        CGFloat youshangX2 = self.frame.origin.x + self.frame.size.width + 10;
        CGFloat youshangY1 = zuoshangY1;
        CGFloat youshangY2 = zuoshangY2;
        
        //如果触摸点在右上角
        if(touchX > youshangX1 && touchX < youshangX2)
        {
            if (touchY > youshangY1 && touchY < youshangY2) {
                
                CGFloat beginX = _beginPoint.x;
                CGFloat beginY = _beginPoint.y;
                
                UITouch *touch = [touches anyObject];
                CGPoint point = [touch locationInView:self.superview];
                
                CGFloat nowX = point.x;
                CGFloat nowY = point.y;
                
                CGFloat width = nowX - beginX;
                CGFloat height = nowY - beginY;
                
                CGRect frame = self.frame;
                
                frame.size.width = frame.size.width + width;
                frame.origin.y = frame.origin.y + height;
                frame.size.height = frame.size.height - height;
                
                self.frame = frame;
                self.frame = frame;
                _cancelButton.frame = Rect(Width(self.frame) - 20, 0, 20, 20);
                _beginPoint = point;
                
            }
        }
        
        
        //左下角范围
        CGFloat zuoxiaX1 = zuoshangX1;
        CGFloat zuoxiaX2 = zuoshangX2;
        CGFloat zuoxiaY1 = self.frame.origin.y + self.frame.size.height - 10;
        CGFloat zuoxiaY2 = self.frame.origin.y + self.frame.size.height + 10;
        
        //如果触摸点在左下角
        if(touchX > zuoxiaX1 && touchX < zuoxiaX2)
        {
            if (touchY > zuoxiaY1 && touchY < zuoxiaY2) {
                
                CGFloat beginX = _beginPoint.x;
                CGFloat beginY = _beginPoint.y;
                
                UITouch *touch = [touches anyObject];
                CGPoint point = [touch locationInView:self.superview];
                
                CGFloat nowX = point.x;
                CGFloat nowY = point.y;
                
                CGFloat width = nowX - beginX;
                CGFloat height = nowY - beginY;
                
                CGRect frame = self.frame;
                
                frame.origin.x = frame.origin.x + width;
                frame.size.width = frame.size.width - width;
                frame.size.height = frame.size.height + height;
                
                self.frame = frame;
                self.frame = frame;
                _cancelButton.frame = Rect(Width(self.frame) - 20, 0, 20, 20);
                _beginPoint = point;
            }
        }
        
        
        //右下角范围
        CGFloat youxiaX1 = youshangX1;
        CGFloat youxiaX2 = youshangX2;
        CGFloat youxiaY1 = zuoxiaY1;
        CGFloat youxiaY2 = zuoxiaY2;
        
        //如果触摸点在右下角
        if (touchX > youxiaX1 && touchX < youxiaX2) {
            if (touchY > youxiaY1 && touchY < youxiaY2) {
                
                CGFloat beginX = _beginPoint.x;
                CGFloat beginY = _beginPoint.y;
                
                UITouch *touch = [touches anyObject];
                CGPoint point = [touch locationInView:self.superview];
                
                CGFloat nowX = point.x;
                CGFloat nowY = point.y;
                
                CGFloat width = nowX - beginX;
                CGFloat height = nowY - beginY;
                
                CGRect frame = self.frame;
                
                frame.size.width = frame.size.width + width;
                frame.size.height = frame.size.height + height;
                
                self.frame = frame;
                self.frame = frame;
                _cancelButton.frame = Rect(Width(self.frame) - 20, 0, 20, 20);
                _beginPoint = point;
            }
        }
        
        
        
        
        //如果触摸在中间位置
        CGFloat midX1 = self.frame.origin.x + 10;
        CGFloat midX2 = self.frame.origin.x + self.frame.size.width - 10;
        CGFloat midY1 = self.frame.origin.y + 10;
        CGFloat midY2 = self.frame.origin.y + self.frame.size.height - 10;
        
        if (touchX > midX1 && touchX < midX2) {
            if (touchY > midY1 && touchY < midY2) {
                self.layer.borderWidth = 0.f;
                CGFloat beginX = _beginPoint.x;
                CGFloat beginY = _beginPoint.y;
                
                UITouch *touch = [touches anyObject];
                CGPoint point = [touch locationInView:self.superview];
                
                CGFloat nowX = point.x;
                CGFloat nowY = point.y;
                
                CGFloat width = nowX - beginX;
                CGFloat height = nowY - beginY;
                
                CGRect frame = self.frame;
                
                frame.origin.x = frame.origin.x + width;
                frame.origin.y = frame.origin.y +height;
                
                self.frame = frame;
                self.frame = frame;
                _cancelButton.frame = Rect(Width(self.frame) - 20, 0, 20, 20);
                _beginPoint = point;
            }
        }

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
