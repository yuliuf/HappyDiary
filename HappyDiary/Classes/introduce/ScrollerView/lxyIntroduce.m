//
//  lxyIntroduce.m
//  Introduce
//
//  Created by 刘翔宇 on 14-6-22.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "lxyIntroduce.h"
#import "EmitterView.h"

@implementation lxyIntroduce

-(void)dealloc
{
    [_scroller release];
    [_loginBtn release];
    
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self addAllViews];
        
    }
    return self;
}

- (void)addAllViews
{
    self.scroller = [[UIScrollView alloc] initWithFrame:self.bounds];

    //添加自动释放池————————————————————————————————————
    @autoreleasepool {
        for (int i = 1; i < 5; i ++) {
            NSString *iamgePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"jieshaoImage%d",i] ofType:@"png"];
            UIImage *img = [[[UIImage alloc] initWithContentsOfFile:iamgePath] autorelease];
            UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
            imgView.frame = CGRectMake((i - 1) * self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height);
            imgView.userInteractionEnabled = YES;
            [_scroller addSubview:imgView];
            
            //在第4张图片上添加一个button按钮
            if (4 == i) {
                self.loginBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                _loginBtn.frame = CGRectMake(275, self.bounds.size.height - 50, 40, 20);
                [_loginBtn setTitle:@"Next" forState:UIControlStateNormal];
                //初始化爆咋效果
                self.boom = [[[EmitterView alloc] initWithFrame:CGRectZero] autorelease];
                [_loginBtn addSubview:_boom];
                
                [imgView addSubview:_loginBtn];
            }
            
        }
    }
    _scroller.contentSize = CGSizeMake(self.bounds.size.width * 4, self.bounds.size.height);    //视图内容
    _scroller.scrollEnabled = YES;          //是否可以滑动
    _scroller.pagingEnabled = YES;          //是否是整页滑动
    _scroller.bounces = NO;                 //滑到边上是否可以再动
    _scroller.delegate = self;              //为scroller添加代理
    [self addSubview:_scroller];
    
    
    
    //添加页面控制器
    self.pageControll = [[UIPageControl alloc] initWithFrame:CGRectMake(60, self.bounds.size.height - 70, 200, 20)];
    _pageControll.numberOfPages = 4;
    _pageControll.currentPageIndicatorTintColor = [UIColor redColor];
    [self addSubview:_pageControll];
    
    
}

//scrollerView滑动结束时
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger i = scrollView.contentOffset.x / self.bounds.size.width;
    _pageControll.currentPage = i;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    //  绘制路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0, self.loginBtn.frame.size.width, self.loginBtn.frame.size.height));
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.duration = 3;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:@"easeInEaseOut"];
    animation.repeatCount = MAXFLOAT;
    animation.path = path;
    [_boom.layer addAnimation:animation forKey:@"test"];
    [(id)path release];

    
}


@end
