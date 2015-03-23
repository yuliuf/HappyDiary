//
//  YCCreateHourglassViewController.m
//  HappyDiary
//
//  Created by 孙震 on 14-6-27.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import "YCCreateHourglassViewController.h"
#import "YCCreateHourglassView.h"
#import <AVFoundation/AVFoundation.h>
#import "SZMusic.h"

#import "lxySandTimerModel.h"
//#import "lxyDataBase.h"

@interface YCCreateHourglassViewController () <UITextFieldDelegate, UITextViewDelegate>
{
    BOOL isPlay;
    BOOL isVoice;
    CGFloat voiceValue;
}

@property (nonatomic, retain) YCCreateHourglassView *createHourglassView;

@property (nonatomic, retain) AVAudioPlayer *avAudioPlayer;

@end

@implementation YCCreateHourglassViewController

- (void)dealloc
{
    [_createHourglassView release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    self.createHourglassView = [[[YCCreateHourglassView alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.view = _createHourglassView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //  设置代理
    self.createHourglassView.textField.delegate = self;
    self.createHourglassView.textView.delegate = self;
    
    //  添加segment事件
    [self.createHourglassView.segment addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    
    //  添加按钮事件
    [self.createHourglassView.saveButton addTarget:self action:@selector(saveButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //  取消按钮事件
    [self.createHourglassView.cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //  音乐控制
    [self.createHourglassView.playButton addTarget:self action:@selector(playButton) forControlEvents:UIControlEventTouchUpInside];
    [self.createHourglassView.volumeSlider addTarget:self action:@selector(volumeSlider:) forControlEvents:UIControlEventValueChanged];
    [self.createHourglassView.voice addTarget:self action:@selector(voiceAction:) forControlEvents:UIControlEventTouchUpInside];
    self.music = [[[SZMusic alloc] initWithName:@"kiss the rain" type:@"mp3"] autorelease];
    [self loadMusic];
    
    //  滑动手势
    UISwipeGestureRecognizer *swipGR1 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipGR1Action:)];
    swipGR1.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipGR1];
    [swipGR1 release];
    
    UISwipeGestureRecognizer *swipGR2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipGR2Action:)];
    swipGR2.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipGR2];
    [swipGR2 release];
    
    //  轻点手势
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGRAction:)];
    [self.view addGestureRecognizer:tapGR];
    [tapGR release];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 音乐控制
#pragma mark 载入音乐
- (void)loadMusic
{
    SZMusic *nowMusic = self.music;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:nowMusic.name ofType:nowMusic.type];
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    self.avAudioPlayer = [[[AVAudioPlayer alloc] initWithData:fileData error:nil] autorelease] ;
    self.avAudioPlayer.volume = 0.8;
    self.avAudioPlayer.numberOfLoops = -1;
    isPlay = YES;
    isVoice = YES;
    [self.avAudioPlayer prepareToPlay];
    [self.avAudioPlayer play];
    //NSLog(@"%d", self.avAudioPlayer.prepareToPlay);
}

#pragma mark 控制按钮
- (void)playButton
{
    if (isPlay) {
        [self.avAudioPlayer pause];
        isPlay = NO;
        [self.createHourglassView.playButton setBackgroundImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    } else {
        [self.avAudioPlayer play];
        isPlay = YES;
        [self.createHourglassView.playButton setBackgroundImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
    }
}

- (void)voiceAction:(UIButton *)sender
{
    if (isVoice) {
        voiceValue = self.avAudioPlayer.volume;
        self.avAudioPlayer.volume = 0.f;
        isVoice = NO;
        [self.createHourglassView.voice setBackgroundImage:[UIImage imageNamed:@"noVoice"] forState:UIControlStateNormal];
    } else {
        self.avAudioPlayer.volume = voiceValue;
        isVoice = YES;
        [self.createHourglassView.voice setBackgroundImage:[UIImage imageNamed:@"voice"] forState:UIControlStateNormal];
    }
}

#pragma mark 声音大小
- (void)volumeSlider:(UISlider *)slider
{
    self.avAudioPlayer.volume = slider.value;
}

#pragma mark - 按钮的监听方法
#pragma mark segment
- (void)segmentAction:(UISegmentedControl *)sender
{
    [self changeValue]; 
}

#pragma mark saveButton
- (void)saveButtonAction:(UIButton *)sender
{
    //  获取textFiled.text
    NSString *string = self.createHourglassView.textField.text;
    NSString *introduce = self.createHourglassView.textView.text;
    
    //  创建沙漏模型
    lxySandTimerModel *sandTimerModel = [[lxySandTimerModel alloc] init];
    int index = self.createHourglassView.segment.selectedSegmentIndex;
    sandTimerModel.style = [NSString stringWithFormat:@"%d", index];
    sandTimerModel.backGroundMusic = [NSString stringWithFormat:@"%d", index];
    sandTimerModel.peopleName = string;
    sandTimerModel.introduce = introduce;
    
    //  创建沙漏模型的时间
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *time = [dateFormatter stringFromDate:[NSDate date]];
    sandTimerModel.time = time;
    
    
    //  把模型插入到数据表中
    [lxyFunctionOfDataBase insertToTabel:@"sandTimerTable" withObject:sandTimerModel];
    
    //  创建单个沙漏模型表
    [[lxyDataBase shareLxyDataBase] createTableWithPeopleNameForTableName:string];
    
    [sandTimerModel release];
    
    //  推出创建页面
    [self.avAudioPlayer stop];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark cancleButton
- (void)cancelButtonAction:(UIButton *)sender
{
    [self.avAudioPlayer stop];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITextFieldDelegate Methods
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.createHourglassView.textField resignFirstResponder];
    return YES;
}

#pragma mark - 滑动手势
- (void)swipGR1Action:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        if (self.createHourglassView.segment.selectedSegmentIndex > 0) {
            self.createHourglassView.segment.selectedSegmentIndex -- ;
            [self changeValue];
        }
    }
}

- (void)swipGR2Action:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        if (self.createHourglassView.segment.selectedSegmentIndex < 4) {
            self.createHourglassView.segment.selectedSegmentIndex ++;
            [self changeValue];
        }
    }
}

- (void)changeValue
{
    if (self.createHourglassView.segment.selectedSegmentIndex == 0) {
        [self.avAudioPlayer stop];
        self.createHourglassView.imageView.image = [UIImage imageNamed:@"shalou5"];
        self.music = [[[SZMusic alloc] initWithName:@"kiss the rain" type:@"mp3"] autorelease];
        [self loadMusic];
    } else if (self.createHourglassView.segment.selectedSegmentIndex == 1) {
        self.createHourglassView.imageView.image = [UIImage imageNamed:@"shalou1"];
        [self.avAudioPlayer stop];
        self.music = [[[SZMusic alloc] initWithName:@"卡农" type:@"mp3"] autorelease];
        [self loadMusic];
    } else if (self.createHourglassView.segment.selectedSegmentIndex == 2) {
        self.createHourglassView.imageView.image = [UIImage imageNamed:@"shalou3"];
        [self.avAudioPlayer stop];
        self.music = [[[SZMusic alloc] initWithName:@"忧伤还是快乐" type:@"mp3"] autorelease];
        [self loadMusic];
    } else if (self.createHourglassView.segment.selectedSegmentIndex == 3) {
        self.createHourglassView.imageView.image = [UIImage imageNamed:@"shalou2"];
        [self.avAudioPlayer stop];
        self.music = [[[SZMusic alloc] initWithName:@"always with me" type:@"mp3"] autorelease];
        [self loadMusic];
    }
}

- (void)tapGRAction:(UITapGestureRecognizer *)sender
{
    [self.createHourglassView.textField resignFirstResponder];
    [self.createHourglassView.textView resignFirstResponder];
}

#pragma mark - UITextViewDelegate Methods
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    self.createHourglassView.textView.text = @"";
    return YES;
}

#pragma mark - 键盘上浮
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    //CGRect frame = textView.frame;
    textView.textColor = [UIColor blackColor];
   // int offset = frame.origin.y + 32 - (self.view.frame.size.height - 216.0); //  键盘高度216.0
    NSTimeInterval animationDuration = 0.3f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    //将视图Y坐标上移
   // if (offset < 0) {
        textView.frame = CGRectMake(50.f, 95, textView.frame.size.width, textView.frame.size.height);
    //}
    [UIView commitAnimations];
}

#pragma mark - 收回键盘时，下浮
- (void)textViewDidEndEditing:(UITextView *)textView
{
    NSTimeInterval animationDuration = 0.3f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    textView.frame = CGRectMake(50, 280, 220, 120);
    [UIView commitAnimations];
}

#pragma mark - 隐藏导航栏上方系统时间、电池显示
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
