//
//  YCWriteHourglassViewController.m
//  Diary
//
//  Created by 孙震 on 14-6-19.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "YCWriteHourglassViewController.h"
#import "YCWriteHourglassView.h"
//#import "lxyDataBase.h"
#import "lxyAlonePersonModel.h"
#import "lxySandTimerModel.h"

@interface YCWriteHourglassViewController () <UITextViewDelegate>

@property (nonatomic, retain) YCWriteHourglassView *writeHourglassView;
@property (nonatomic, retain) NSArray *imageArray;
@property (nonatomic, assign) NSInteger clickCount; // 记录点击的次数
@property (nonatomic, copy) NSString *imagePath;    //  存储背景的路径

@end

@implementation YCWriteHourglassViewController

- (void)dealloc
{
    [_sandModel release];
    [_writeHourglassView release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"写一个";
        [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"LiDeBiao-Xing-3.0" size:22.f], NSFontAttributeName, UIColorFromRGB(0xB94FFF), NSForegroundColorAttributeName, nil]];
        self.imageArray = @[@"deco_sticker_mygom2",@"deco_sticker_mygom4",@"deco_sticker_mygom6",@"deco_sticker_mygom7",@"deco_sticker_mygom8",@"deco_sticker_mygom9",@"deco_sticker_mygom10",@"deco_sticker_mygom11",@"deco_sticker_mygom12",@"deco_sticker_mygom13"];
        self.clickCount = 0;
    }
    return self;
}


- (void)loadView
{
    self.writeHourglassView = [[[YCWriteHourglassView alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.view = _writeHourglassView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.imagePath = [[NSBundle mainBundle] pathForResource:@"deco_sticker_mygom13" ofType:@"png"];
    
    /*
    //  rightBar
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(rightBarAction:)];
    [rightBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"LiDeBiao-Xing-3.0" size:22.f], NSFontAttributeName, UIColorFromRGB(0xB94FFF), NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightBar;
    [rightBar release];
    
    //  leftBar
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(leftBarAction:)];
    [leftBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"LiDeBiao-Xing-3.0" size:22.f], NSFontAttributeName, UIColorFromRGB(0xB94FFF), NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = leftBar;
    [leftBar release];
     */
    
    self.rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _rightButton.frame = Rect(240, 8, 60, 30);
    [_rightButton setTitle:@"保存" forState:UIControlStateNormal];
    _rightButton.tintColor = [UIColor whiteColor];
    _rightButton.titleLabel.font = myZiti;
    [_rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_rightButton setBackgroundImage:[UIImage imageNamed:@"intro_menu_brown"] forState:UIControlStateNormal];
    [self.view addSubview:_rightButton];
    
    self.leftButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _leftButton.frame = Rect(20, 8, 60, 30);
    [_leftButton setTitle:@"取消" forState:UIControlStateNormal];
    _leftButton.tintColor = [UIColor whiteColor];
    _leftButton.titleLabel.font = myZiti;
    [_leftButton addTarget:self action:@selector(leftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_leftButton setBackgroundImage:[UIImage imageNamed:@"intro_menu_brown"] forState:UIControlStateNormal];
    [self.view addSubview:_leftButton];
    
    self.title = [self.sandModel peopleName];
    
//    [self.writeHourglassView.textView becomeFirstResponder];
    
    //  轻拍手势
    [self.writeHourglassView.tapGR addTarget:self action:@selector(tapGRAction:)];
    //  更换图片
    [self.writeHourglassView.changeImageButton addTarget:self action:@selector(changeImageAction:) forControlEvents:UIControlEventTouchUpInside];
    
}
#pragma mark 轻拍手势 收回键盘事件
- (void)tapGRAction:(UIGestureRecognizer *)sender
{
    [self.writeHourglassView endEditing:YES];
}

#pragma mark 更换图片
- (void)changeImageAction:(UIButton *)sender
{
    _clickCount ++;
    NSLog(@"%d", _clickCount);
    int i = _clickCount % _imageArray.count;
    if ( i < _imageArray.count) {
        self.imagePath = [[NSBundle mainBundle] pathForResource:_imageArray[i] ofType:@"png"];
        UIImage *image = [[UIImage alloc] initWithContentsOfFile:_imagePath];
        self.writeHourglassView.bgImageView.image = image;
        [image release];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 保存事件
- (void)rightButtonAction:(UIButton *)sender
{
    //  沙漏的名字
    NSString *name = [self.sandModel peopleName];
    
    NSMutableArray *array = [[lxyDataBase shareLxyDataBase] searchAllDataFromalonePersonTableByPersonName:name];
    //  沙漏中数据的ID
    NSString *ID = [NSString stringWithFormat:@"%d", array.count];
    
    //  沙漏中数据的内容
    NSString *content = self.writeHourglassView.textView.text;
    
    //  沙漏中数据的时间
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *time = [dateFormatter stringFromDate:[NSDate date]];
    
    //  创建个人模型
    lxyAlonePersonModel *model = [[[lxyAlonePersonModel alloc] initWithName:name andID:ID andTime:time andContent:content andbackGroundImage:_imagePath andWeather:@"001"] autorelease];
    
    //  插入到数据表中
    [[lxyDataBase shareLxyDataBase] insertToAlonePersonTableWithOneAlonePersonModel:model byName:name];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 取消按钮
- (void)leftButtonAction:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 隐藏导航栏上方系统时间、电池显示
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
@end
