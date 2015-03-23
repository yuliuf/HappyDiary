//
//  YCDetailHourglassViewController.m
//  Diary
//
//  Created by 孙震 on 14-6-19.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import "YCDetailHourglassViewController.h"
#import "YCDetailHourglassView.h"
#import "YCWriteHourglassViewController.h"
#import "lxySandTimerModel.h"
//#import "lxyDataBase.h"
//#import "lxyAlonePersonModel.h"
#import "YCOneDetailViewController.h"
//#import "YCDetailCell.h"
#import "LYCustomTabBar.h"
#import "SZMusic.h"
#import <AVFoundation/AVFoundation.h>

@interface YCDetailHourglassViewController () <UITableViewDataSource, UITableViewDelegate>
{
    BOOL isPlay;
    BOOL isVoice;
    CGFloat voiceValue;
}

@property (nonatomic, retain) YCDetailHourglassView *detailHourglassView;

@property (nonatomic, retain) AVAudioPlayer *avAudioPlayer;

@end

@implementation YCDetailHourglassViewController

-(void)dealloc
{
    [_sandModel release];
    [_detailHourglassView release];
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
    self.detailHourglassView = [[[YCDetailHourglassView alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.view = _detailHourglassView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    //  设置代理
    self.detailHourglassView.tableView.delegate = self;
    self.detailHourglassView.tableView.dataSource = self;
    
    /*
    //  rightBar
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStyleDone target:self action:@selector(rightBarAction:)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"intro_menu_brown"]];
    
    UILabel *lalble = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 44, 24)];
    lalble.text = @"添加";
    lalble.font = myZiti;
    lalble.textColor = [UIColor whiteColor];
    [imageView addSubview:lalble];
    [lalble release];

    rightBar.customView = imageView;
    [imageView release];
    
    //[rightBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"LiDeBiao-Xing-3.0" size:22.f], NSFontAttributeName, [UIColor whiteColor], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
     
    self.navigationItem.rightBarButtonItem = rightBar;
    [rightBar release];
     
     //  leftBar
     UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(leftBarAction:)];
     [leftBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"LiDeBiao-Xing-3.0" size:22.f], NSFontAttributeName, UIColorFromRGB(0xB94FFF), NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
     self.navigationItem.leftBarButtonItem = leftBar;
     [leftBar release];
     */
    
    self.rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _rightButton.frame = Rect(240, 8, 60, 30);
    [_rightButton setTitle:@"添加" forState:UIControlStateNormal];
    _rightButton.tintColor = [UIColor whiteColor];
    _rightButton.titleLabel.font = myZiti;
    [_rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_rightButton setBackgroundImage:[UIImage imageNamed:@"intro_menu_brown"] forState:UIControlStateNormal];
    [self.view addSubview:_rightButton];
    
    self.leftButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _leftButton.frame = Rect(20, 8, 60, 30);
    [_leftButton setTitle:@"返回" forState:UIControlStateNormal];
    _leftButton.tintColor = [UIColor whiteColor];
    _leftButton.titleLabel.font = myZiti;
    [_leftButton addTarget:self action:@selector(leftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_leftButton setBackgroundImage:[UIImage imageNamed:@"intro_menu_brown"] forState:UIControlStateNormal];
    [self.view addSubview:_leftButton];
    
    //  title
    self.title = [self.sandModel peopleName];
 
    //  载入数据
    NSString *image_str = @"";
    self.music = nil;
    if ([[self.sandModel style] intValue] == 0) {
        image_str = @"shalou5";
        self.music = [[[SZMusic alloc] initWithName:@"kiss the rain" type:@"mp3"] autorelease];
    } else if ([[self.sandModel style] intValue] == 1) {
        image_str = @"shalou1";
        self.music = [[[SZMusic alloc] initWithName:@"卡农" type:@"mp3"] autorelease];
    } else if ([[self.sandModel style] intValue] == 2) {
        image_str = @"shalou3";
        self.music = [[[SZMusic alloc] initWithName:@"忧伤还是快乐" type:@"mp3"] autorelease];
    } else if ([[self.sandModel style] intValue] == 3) {
        image_str = @"shalou2";
        self.music = [[[SZMusic alloc] initWithName:@"always with me" type:@"mp3"] autorelease];
    }
    self.detailHourglassView.hgStyleImageView.image = [UIImage imageNamed:image_str];
    self.detailHourglassView.introduceLabel.text = self.sandModel.introduce;
   // NSLog(@"text:%@", self.sandModel.introduce);
   // NSLog(@"name:%@", self.sandModel.peopleName);
    
    //  载入音乐
    [self loadMusic];
    
    //  按钮事件
    [self.detailHourglassView.playButton addTarget:self action:@selector(playButton) forControlEvents:UIControlEventTouchUpInside];
    [self.detailHourglassView.voice addTarget:self action:@selector(voiceAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 载入音乐
- (void)loadMusic
{
    SZMusic *nowMusic = self.music;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:nowMusic.name ofType:nowMusic.type];
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    self.avAudioPlayer = [[[AVAudioPlayer alloc] initWithData:fileData error:nil] autorelease];
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
        [self.detailHourglassView.playButton setBackgroundImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    } else {
        [self.avAudioPlayer play];
        isPlay = YES;
        [self.detailHourglassView.playButton setBackgroundImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
    }
}

- (void)voiceAction:(UIButton *)sender
{
    if (isVoice) {
        voiceValue = self.avAudioPlayer.volume;
        self.avAudioPlayer.volume = 0.f;
        isVoice = NO;
        [self.detailHourglassView.voice setBackgroundImage:[UIImage imageNamed:@"noVoice"] forState:UIControlStateNormal];
    } else {
        self.avAudioPlayer.volume = voiceValue;
        isVoice = YES;
        [self.detailHourglassView.voice setBackgroundImage:[UIImage imageNamed:@"voice"] forState:UIControlStateNormal];
    }
}

#pragma mark - UITableViewDataSourse Methods
#pragma mark 组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSMutableArray *array = [[lxyDataBase shareLxyDataBase] searchAllDataFromalonePersonTableByPersonName:[self.sandModel peopleName]];
    return [array count];
}

#pragma mark 每行内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cell_detail = @"cell_detail";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_detail];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cell_detail] autorelease];
    }
    NSMutableArray *array = [[lxyDataBase shareLxyDataBase] searchAllDataFromalonePersonTableByPersonName:[self.sandModel peopleName]];
    cell.textLabel.text = [array[indexPath.row] content];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.font = [UIFont fontWithName:@"LiDeBiao-Xing-3.0" size:22.f];
    cell.textLabel.numberOfLines = 0;
    cell.detailTextLabel.text = [array[indexPath.row] time];
    cell.imageView.image = [UIImage imageNamed:@"cal"];
    cell.detailTextLabel.font = [UIFont fontWithName:@"LiDeBiao-Xing-3.0" size:22.f];
    //cell.detailTextLabel.textColor = [UIColor orangeColor];
    cell.detailTextLabel.textColor = [UIColor grayColor];
    cell.backgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fy"]] autorelease];
    
    return cell;
}

#pragma mark - UITableViewDelegate Mothods
#pragma mark Did select row
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YCOneDetailViewController *oneDetailVC = [[[YCOneDetailViewController alloc] init] autorelease];
    //  传值
    NSMutableArray *array = [[lxyDataBase shareLxyDataBase] searchAllDataFromalonePersonTableByPersonName:[self.sandModel peopleName]];
    oneDetailVC.aloneModel = array[indexPath.row];
    [self.navigationController pushViewController:oneDetailVC animated:YES];
}

#pragma mark - Commit
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSMutableArray *array = [[lxyDataBase shareLxyDataBase] searchAllDataFromalonePersonTableByPersonName:[self.sandModel peopleName]];
        lxyAlonePersonModel *aloneModel = array[indexPath.row];
        [[lxyDataBase shareLxyDataBase] deleteOneAlonePersonModel:aloneModel byName:[aloneModel name]];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

#pragma mark - 自适应高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSMutableArray *array = [[lxyDataBase shareLxyDataBase] searchAllDataFromalonePersonTableByPersonName:[self.sandModel peopleName]];
    NSString *title = [array[indexPath.row] content];
    CGRect rect = [title boundingRectWithSize:CGSizeMake(240, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont fontWithName:@"LiDeBiao-Xing-3.0" size:22.f]} context:nil];
    if (rect.size.height > 44) {
        return rect.size.height + 30;
    } else {
        return 54;
    }
}

#pragma mark - 按钮监听事件
#pragma mark 添加事件
- (void)rightButtonAction:(UIButton *)sender
{
    YCWriteHourglassViewController *writeVC = [[[YCWriteHourglassViewController alloc] init] autorelease];
    writeVC.sandModel = self.sandModel;
    [self presentViewController:writeVC animated:YES completion:nil];
}

#pragma mark 返回按钮
- (void)leftButtonAction:(UIButton *)sender
{
    [self.avAudioPlayer stop];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 更新UI
- (void)viewWillAppear:(BOOL)animated
{
    [self.detailHourglassView.tableView reloadData];
}

#pragma mark 隐藏导航栏上方系统时间、电池显示
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
