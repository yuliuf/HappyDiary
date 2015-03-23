//
//  YCWriteHourglassView.m
//  HappyDiary
//
//  Created by 孙震 on 14-6-20.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import "YCWriteHourglassView.h"

@implementation YCWriteHourglassView

- (void)dealloc
{
    [_textView release];
    [super dealloc];
}

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
    self.backImageView = [[[UIImageView alloc] initWithFrame:self.bounds] autorelease];
    self.backImageView.image = [UIImage imageNamed:@"blueSky"];
    [self addSubview:_backImageView];
    [_backImageView release];
    
    //  设置背景图
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"deco_sticker_mygom13" ofType:@"png"];
    UIImage *image = [[[UIImage alloc] initWithContentsOfFile:imagePath] autorelease];
    self.bgImageView = [[[UIImageView alloc] initWithImage:image] autorelease];
    _bgImageView.frame = Rect(15, 80, ScreenWidth - 30, 100);
    _bgImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_bgImageView];
    [_bgImageView release];
    
    self.changeImageButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _changeImageButton.frame = Rect(ScreenWidth - 50, 49, 40, 30);
    [_changeImageButton setBackgroundImage:[UIImage imageNamed:@"deco_sticker_mygom_tap_on"] forState:UIControlStateNormal];
    [self addSubview:_changeImageButton];
    
    self.textView = [[[UITextView alloc] initWithFrame:Rect(MinX(_bgImageView.frame), MaxY(_bgImageView.frame), Width(_bgImageView.frame), ScreenHeight - 200)] autorelease];
    self.textView.font = [UIFont fontWithName:@"LiDeBiao-Xing-3.0" size:19.f];
    self.textView.backgroundColor = [UIColor clearColor];
    self.textView.layer.borderWidth = 2;
    self.textView.layer.cornerRadius = 5;
    [self.textView becomeFirstResponder];
    self.textView.layer.borderColor = [[UIColor orangeColor] CGColor];
    [self addSubview:_textView];
}
- (UITapGestureRecognizer *)tapGR
{
    if (_tapGR == nil) {
        _tapGR = [[UITapGestureRecognizer alloc] init];
        [self addGestureRecognizer:_tapGR];
    }
    return _tapGR;
}

@end
