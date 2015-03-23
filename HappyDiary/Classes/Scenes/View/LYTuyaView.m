//
//  LYTuyaView.m
//  HappyDiary
//
//  Created by 刘翔宇 on 14-6-26.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "LYTuyaView.h"

@implementation LYTuyaView

- (void)dealloc
{
    [_lineArray release];
    
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.lineArray = [NSMutableArray array];
        self.colorTag = 0;
        
        [self addAllViews];
    }
    return self;
}


- (void) addAllViews
{
    self.cancleButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _cancleButton.frame = CGRectMake(10 ,self.bounds.size.height - 30, 20, 20);
//    [_cancleButton setTitle:@"×" forState:UIControlStateNormal];
    [_cancleButton setBackgroundImage:[UIImage imageNamed:@"cancleButton"] forState:UIControlStateNormal];
    [self addSubview:_cancleButton];
//
//    self.saveButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    _saveButton.frame = CGRectMake(MaxX(_cancleButton.frame) ,self.bounds.size.height - 20, 20, 20);
//    [_saveButton setTitle:@"√" forState:UIControlStateNormal];
//    [self addSubview:_saveButton];
//    
    self.deleteButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _deleteButton.frame = CGRectMake(self.frame.size.width - 40, self.frame.size.height - 30, 20, 20);
//    [_deleteButton setTitle:@"<-" forState:UIControlStateNormal];
    [_deleteButton setBackgroundImage:[UIImage imageNamed:@"chexiaoButton"] forState:UIControlStateNormal];
    [self addSubview:_deleteButton];
//
}
- (CGColorRef)getColorWithTag:(NSInteger)tag
{
    switch (tag) {
        case 0:
            return [UIColor cyanColor].CGColor;
            break;
        case 1:
            return [UIColor redColor].CGColor;
            break;
        case 2:
            return [UIColor yellowColor].CGColor;
            break;
        default:
            break;
    }
    return [UIColor blackColor].CGColor;
}
- (void)drawRect:(CGRect)rect
{
    
    //得到上下文
    CGContextRef context = UIGraphicsGetCurrentContext();//设置笔的颜色和粗细
    
    //设置笔的颜色
//    CGContextSetStrokeColorWithColor(context, [self getColorWithTag:self.colorTag]);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);

    //设置笔的粗细
    CGContextSetLineWidth(context, 2.0);
    //遍历数组
    for (int i  = 0; i < _lineArray.count; i ++) {
        NSMutableArray  *pointarray = [_lineArray objectAtIndex:i];
        for (int j = 0; j < (int)pointarray.count - 1 ; j ++) {
            NSValue *firstpointvalue = [pointarray objectAtIndex:j];
            NSValue *secondpointvalue = [pointarray objectAtIndex:j +1];
            CGPoint firstpoint = [firstpointvalue CGPointValue];
            CGPoint secondpoint = [secondpointvalue CGPointValue];
            
            //把第一个点移动到另外一个点上
            CGContextMoveToPoint(context, firstpoint.x, firstpoint.y);
            //把点连成线
            CGContextAddLineToPoint(context, secondpoint.x, secondpoint.y);
        }
        //绘图
        CGContextStrokePath(context);
    }
    
}
//触屏开始
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSMutableArray *pointarray = [NSMutableArray array];//初始化数组
    [_lineArray addObject:pointarray];//把点击的数组加入大数组中
    
}
//移动触屏
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    //视图上的坐标
    CGPoint point = [touch locationInView:self];
    //最后一个点的坐标
    NSMutableArray *pointarray = [_lineArray lastObject];
    //把point坐标添加到数组中先改成nsvalue
    NSValue *pointvalue = [NSValue valueWithCGPoint:point];
    [pointarray addObject:pointvalue];
    
    //重写写绘图界面
    [self setNeedsDisplay];
    
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
