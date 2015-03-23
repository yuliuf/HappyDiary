//
//  YCOneDetailView.m
//  Diary
//
//  Created by 孙震 on 14-6-19.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import "YCOneDetailView.h"

@implementation YCOneDetailView

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
    //  设置背景图
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"deco_sticker_mygom13" ofType:@"png"];
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:imagePath];
    self.bgImageView = [[[UIImageView alloc] initWithImage:image] autorelease];
    _bgImageView.frame = Rect(15, 80, ScreenWidth - 30, 100);
    _bgImageView.contentMode = UIViewContentModeScaleAspectFit;
    [image release];
    [self addSubview:_bgImageView];
    [_bgImageView release];
    
    self.textView = [[[UITextView alloc] initWithFrame:Rect(MinX(_bgImageView.frame), MaxY(_bgImageView.frame), Width(_bgImageView.frame), ScreenHeight - 200)] autorelease];
    self.textView.font = [UIFont fontWithName:@"LiDeBiao-Xing-3.0" size:19.f];
    self.textView.backgroundColor = UIColorFromRGB(0xFFAA33);
    //    self.textView.layer.borderWidth = 1.f;
    self.textView.layer.cornerRadius = 5;
    [self addSubview:_textView];
//    [_textView release];
    
    self.changeImageButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _changeImageButton.frame = Rect(ScreenWidth - 50, 49, 40, 30);
    [_changeImageButton setBackgroundImage:[UIImage imageNamed:@"deco_sticker_mygom_tap_on"] forState:UIControlStateNormal];
    self.changeImageButton.hidden = YES;
    [self addSubview:_changeImageButton];
    
    
    //  deleteButton
    self.deleteButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.deleteButton.frame = CGRectMake(30, 568 - 114, 260, 30);
    [self.deleteButton setTintColor:[UIColor whiteColor]];
    self.deleteButton.backgroundColor = [UIColor redColor];
    self.deleteButton.layer.cornerRadius = 5.0;
    [self.deleteButton setTitle:@"删   除" forState:UIControlStateNormal];
    self.deleteButton.titleLabel.font = [UIFont systemFontOfSize:17.f];
    [self addSubview:_deleteButton];
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
