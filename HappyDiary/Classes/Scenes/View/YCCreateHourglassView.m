//
//  YCCreateHourglassView.m
//  HappyDiary
//
//  Created by 孙震 on 14-6-20.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "YCCreateHourglassView.h"

@interface YCCreateHourglassView ()

@end

@implementation YCCreateHourglassView

/*
- (void)dealloc
{
    [_headerLable release];
    [_textView release];
    [_playButton release];
    [_volumeSlider release];
    [_label release];
    [_textField release];
    [_saveButton release];
    [_cancelButton release];
    [super dealloc];
}
 */ 

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addAllViews];
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"shalou4"]];
    }
    return self;
}

- (void)addAllViews
{
    self.backImageView = [[[UIImageView alloc] initWithFrame:self.bounds] autorelease];
    self.backImageView.image = [UIImage imageNamed:@"blueSky"];
    [self addSubview:_backImageView];
//    [_backImageView release];
    
    self.headerLable = [[[UILabel alloc] initWithFrame:CGRectMake(0, 10, 320, 30)] autorelease];
    self.headerLable.textColor = [UIColor grayColor];
    self.headerLable.font = [UIFont fontWithName:@"LiDeBiao-Xing-3.0" size:22.f];
    self.headerLable.textAlignment = NSTextAlignmentCenter;
    self.headerLable.text = @"沙 漏";
    [self addSubview:_headerLable];
    
    NSArray *itemsArray = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", nil];
    self.segment = [[[UISegmentedControl alloc] initWithItems:itemsArray] autorelease];
    self.segment.selectedSegmentIndex = 0;
    self.segment.tintColor = UIColorFromRGB(0xFF8800);
    self.segment.frame = CGRectMake(50, 50, 220, 30);
    [self addSubview:_segment];
    
    self.imageView = [[[UIImageView alloc] initWithFrame:CGRectMake(50, 95, 220, 120)] autorelease];
    self.imageView.image = [UIImage imageNamed:@"shalou5"];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_imageView];
    
    self.label = [[[UILabel alloc] initWithFrame:CGRectMake(50, 230, 65, 30)] autorelease];
    _label.text = @"名字:";
    _label.font = [UIFont fontWithName:@"LiDeBiao-Xing-3.0" size:20.f];
    _label.textColor = [UIColor grayColor];
//    _label.textColor = [UIColor blackColor];
    [self addSubview:_label];
    
    self.textField = [[[UITextField alloc] initWithFrame:CGRectMake(120, 230, 130, 30)] autorelease];
    _textField.borderStyle = UITextBorderStyleRoundedRect;
    _textField.layer.borderWidth = 0.5f;
    _textField.layer.cornerRadius = 5.f;
    _textField.font = [UIFont fontWithName:@"LiDeBiao-Xing-3.0" size:20.f];
//    _textField.textColor = UIColorFromRGB(0xFF8800);
    _textField.textColor = [UIColor blackColor];
    [self addSubview:_textField];
    
    self.textView = [[[UITextView alloc] initWithFrame:CGRectMake(50, 280, 220, 120)] autorelease];
    self.textView.layer.borderWidth = .5f;
    self.textView.text = @"还没有输入简介..";
    self.textView.font = [UIFont fontWithName:@"LiDeBiao-Xing-3.0" size:17.f];
    self.textView.textColor = [UIColor grayColor];
    self.textView.layer.cornerRadius = 5.f;
    [self addSubview:_textView];
    
    /*
    self.saveButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_saveButton setTitle:@"保存" forState:UIControlStateNormal];
    _saveButton.titleLabel.font = [UIFont fontWithName:@"LiDeBiao-Xing-3.0" size:18.f];
    _saveButton.frame = CGRectMake(90, 430, 60, 30);
    [self addSubview:_saveButton];

    self.cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    _cancelButton.titleLabel.font = [UIFont fontWithName:@"LiDeBiao-Xing-3.0" size:18.f];
    _cancelButton.frame = CGRectMake(160, 430, 60, 30);
    [self addSubview:_cancelButton];
     */
    
    self.saveButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _saveButton.frame = Rect(60, ScreenHeight - 55, 60, 30);
    [_saveButton setTitle:@"保存" forState:UIControlStateNormal];
    _saveButton.tintColor = [UIColor whiteColor];
    _saveButton.titleLabel.font = myZiti;
    [_saveButton setBackgroundImage:[UIImage imageNamed:@"intro_menu_brown"] forState:UIControlStateNormal];
    [self addSubview:_saveButton];
    
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _cancelButton.frame = Rect(200, ScreenHeight - 55, 60, 30);
    [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    _cancelButton.tintColor = [UIColor whiteColor];
    _cancelButton.titleLabel.font = myZiti;
    [_cancelButton setBackgroundImage:[UIImage imageNamed:@"intro_menu_brown"] forState:UIControlStateNormal];
    [self addSubview:_cancelButton];
    
    NSInteger y = MinY(self.saveButton.frame) - MaxY(self.textView.frame);
    
    self.playButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _playButton.frame = CGRectMake(280, MaxY(self.textView.frame) + y / 2 - 14, 32, 32);
    [_playButton setBackgroundImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
    [self addSubview:_playButton];
    
    self.volumeSlider = [[[UISlider alloc] initWithFrame:CGRectMake(40, MaxY(self.textView.frame) + y / 2 - 14, 240, 30)] autorelease];
    self.volumeSlider.value = 0.8;
    self.volumeSlider.minimumValue = 0;
    self.volumeSlider.maximumValue = 1;
    [self.volumeSlider setThumbImage:[UIImage imageNamed:@"sliderThumb"] forState:UIControlStateNormal];
    [self addSubview:_volumeSlider];
    [_volumeSlider release];
    
    self.voice = [UIButton buttonWithType:UIButtonTypeSystem];
    self.voice.frame = CGRectMake(8, MaxY(self.textView.frame) + y / 2 - 14, 32, 32);
    [self.voice setBackgroundImage:[UIImage imageNamed:@"voice"] forState:UIControlStateNormal];
    [self addSubview:_voice];
    
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
