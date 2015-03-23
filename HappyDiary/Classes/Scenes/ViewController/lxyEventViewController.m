//
//  lxyEventViewController.m
//  EventController
//
//  Created by 刘翔宇 on 14-6-20.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "lxyEventViewController.h"

#import "lxyMonthlyView.h"
#import "lxyWeeklyView.h"
#import "lxyDailyView.h"
#import "lxyPersonDataView.h"
//#import "lxyBaseView.h"
//#import "lxyDataBase.h"
#import "lxyWeeklyCell.h"
#import "YCWeeklyDetailViewController.h"
#import "lxyUserTableModel.h"

//#import "YCCalendarView.h"
//#import <QuartzCore/QuartzCore.h>
#import "lxyDiaryModel.h"
#define kBegin 40
#define kWidth 80
#define kHeight 30
#define kY 480

@interface lxyEventViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate , UITextFieldDelegate , UITextViewDelegate , UIAlertViewDelegate , UIActionSheetDelegate , UINavigationControllerDelegate , UIImagePickerControllerDelegate>
{
    int i; //  控制月份的切换
}

@property (nonatomic, retain) NSMutableArray *array;
@property (nonatomic, retain) NSMutableDictionary *dict;
@property (nonatomic, retain) NSMutableArray *keyArray;

@end

@implementation lxyEventViewController

- (void)dealloc
{
    [_monthlyView release];
    [_weeklyView release];
    [_dailyView release];
    [_personDataView release];
    [_baseView release];
    
    [super dealloc];
}

//monthlyView、weeklyView、dailyView、personView 的懒加载
- (lxyMonthlyView *)monthlyView
{
    if (nil == _monthlyView) {
        _monthlyView = [[lxyMonthlyView alloc] init];
    }
    return _monthlyView;
}
- (lxyWeeklyView *)weeklyView
{
    if (nil == _weeklyView) {
        _weeklyView = [[lxyWeeklyView alloc] init];
    }
    return _weeklyView;
}
- (lxyDailyView *)dailyView
{
    if (nil == _dailyView) {
        _dailyView = [[lxyDailyView alloc] init];
    }
    return _dailyView;
}
- (lxyPersonDataView *)personDataView
{
    if (nil == _personDataView) {
        _personDataView = [[lxyPersonDataView alloc] init];
    }
    return _personDataView;
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
    self.monthlyView = [[[lxyMonthlyView alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.weeklyView = [[[lxyWeeklyView alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.dailyView = [[[lxyDailyView alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.personDataView = [[[lxyPersonDataView alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    
    
    self.baseView = [[[lxyBaseView alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    
    [self weeklyButton1ForDailyViewAction:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //  加载日历
    dtForMonth = [NSDate date];
    [self createCalendar];
    
    //dailyView上button按钮的事件
    [_dailyView.monthlyButton1 addTarget:self action:@selector(monthlyButton1ForDailyViewAction:) forControlEvents:UIControlEventTouchUpInside];
    [_dailyView.weeklyButton1 addTarget:self action:@selector(weeklyButton1ForDailyViewAction:) forControlEvents:UIControlEventTouchUpInside];
    [_dailyView.personDataButton1 addTarget:self action:@selector(personDataButton1ForDailyViewAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //monthlyView上button按钮的事件
    [_monthlyView.weeklyButton1 addTarget:self action:@selector(weeklyButton1ForMonthlyViewAction:) forControlEvents:UIControlEventTouchUpInside];
    [_monthlyView.dailyButton1 addTarget:self action:@selector(dailyButton1ForMonthlyViewAction:) forControlEvents:UIControlEventTouchUpInside];
    [_monthlyView.personDataButton1 addTarget:self action:@selector(personDataButton1ForMonthlyViewAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //weeklyView上button按钮的事件
    [_weeklyView.monthlyButton1 addTarget:self action:@selector(monthlyButton1ForWeeklyViewAction:) forControlEvents:UIControlEventTouchUpInside];
    [_weeklyView.dailyButton1 addTarget:self action:@selector(dailyButton1ForWeeklyViewAction:) forControlEvents:UIControlEventTouchUpInside];
    [_weeklyView.personDataButton1 addTarget:self action:@selector(personDataButton1ForWeeklyViewAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //personDataView上button按钮的事件
    [_personDataView.monthlyButton1 addTarget:self action:@selector(monthlyButton1ForPersonDataViewAction:) forControlEvents:UIControlEventTouchUpInside];
    [_personDataView.weeklyButton1 addTarget:self action:@selector(weeklyButton1ForPersonDataViewAction:) forControlEvents:UIControlEventTouchUpInside];
    [_personDataView.dailyButton1 addTarget:self action:@selector(dailyButton1ForPersonDataViewAction:) forControlEvents:UIControlEventTouchUpInside];
    [_personDataView.editBtn addTarget:self action:@selector(personDataEditButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_personDataView.tap addTarget:self action:@selector(tapAction:)];      //轻怕view的监听事件
    
    
    //  换月份按钮的事件
    [self.monthlyView.previousButton addTarget:self action:@selector(previousButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.monthlyView.nextButton addTarget:self action:@selector(nextButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //  设置tableView的代理
    self.dailyView.tableView.delegate = self;
    self.dailyView.tableView.dataSource = self;
    
    //  设置searchBar的代理
    self.dailyView.searchBar.delegate = self;
    
    //设置三个输入框的代理
    _personDataView.introduce.delegate = self;
    _personDataView.name.delegate = self;
    _personDataView.birthday.delegate = self;
    
    _weeklyView.collection.delegate = self;
    
    //  初始化属性
    self.keyArray = [NSMutableArray array];
    self.dict = [NSMutableDictionary dictionary];
    
    //  获取日记表
    self.array = [lxyFunctionOfDataBase searchAllDataInTable:@"diaryTable"];
    for (lxyDiaryModel *model in self.array) {
        NSString *key = [[model diary_time] substringToIndex:10];
        if ([self.keyArray containsObject:key]) {
            [self.dict[key] addObject:model];
        } else {
            NSMutableArray *diArray = [NSMutableArray arrayWithObject:model];
            [_dict setObject:diArray forKey:key];
            _keyArray = [[self.dict allKeys] mutableCopy];
        }
    }
    
    //添加头像图片轻怕手势的方法
    [self.personDataView.tapHeadIcon addTarget:self action:@selector(headIconTapAction:)];
    
    //diary界面的轻拍手势
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGRAction:)];
    [self.dailyView addGestureRecognizer:tapGR];
    [tapGR release];
    
    //为各个页面的返回按钮添加事件
    [self.monthlyView.monthlyBackButton addTarget:self action:@selector(monthlyBackButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.dailyView.dailyBackButton addTarget:self action:@selector(dailyBackButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.personDataView.personDataBackButton addTarget:self action:@selector(personDataBackButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark -monthlyView上返回按钮的监听事件
- (void)monthlyBackButtonAction:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark -dailyView上返回按钮的监听事件
-(void)dailyBackButtonAction:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark -personDataView上返回按钮的监听事件
-(void)personDataBackButtonAction:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//每个cell的点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    YCWeeklyDetailViewController *detailVC = [[YCWeeklyDetailViewController alloc] init];
    detailVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    lxyWeeklyCell *cell = (lxyWeeklyCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    detailVC.iconImage = cell.titleIcon.image;
    detailVC.Mytitle = cell.titleLabel.text;
    detailVC.day = cell.titleDay.text;
    detailVC.contentImage = cell.contentImageView.image;
    
    [self presentViewController:detailVC animated:YES completion:nil];
    [detailVC release];
}

//personDataView上button按钮的事件
- (void)monthlyButton1ForPersonDataViewAction:(UIButton *)sender
{
    self.view = _monthlyView;
}
- (void)weeklyButton1ForPersonDataViewAction:(UIButton *)sender
{
    self.view = _weeklyView;
}
- (void)dailyButton1ForPersonDataViewAction:(UIButton *)sender
{
    self.view = _dailyView;
}

#pragma mark -编辑按钮的监听事件
//编辑按钮的监听事件
- (void)personDataEditButtonAction:(UIButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:@"编辑"]) {
        [_personDataView.editBtn setTitle:@"完成" forState:UIControlStateNormal];
        _personDataView.name.enabled = YES;
        _personDataView.birthday.enabled = YES;
        _personDataView.introduce.editable = YES;
        _personDataView.headerIcon.userInteractionEnabled = YES;
        _personDataView.introduce.autoresizingMask = UIViewAutoresizingFlexibleHeight;      //textView自适应高度
        
        //按钮显示为Done时各种输入框的状态
        _personDataView.name.borderStyle = UITextBorderStyleRoundedRect;
        _personDataView.birthday.borderStyle = UITextBorderStyleRoundedRect;
        _personDataView.introduce.layer.borderColor = [[UIColor orangeColor] CGColor];
        _personDataView.introduce.layer.borderWidth = .3f;
        _personDataView.introduce.layer.cornerRadius = 13.f;
        _personDataView.headerIcon.layer.borderColor = [[UIColor orangeColor] CGColor];
        _personDataView.headerIcon.layer.borderWidth = .3f;
        _personDataView.headerIcon.layer.cornerRadius = 13.f;
    } else {
        [_personDataView.editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        _personDataView.name.enabled = NO;
        _personDataView.birthday.enabled = NO;
        _personDataView.introduce.editable = NO;
        _personDataView.headerIcon.userInteractionEnabled = NO;
        
        //按钮显示为Done时各种输入框的状态
        _personDataView.name.borderStyle = UITextBorderStyleNone;
        _personDataView.birthday.borderStyle = UITextBorderStyleNone;
        _personDataView.introduce.layer.borderColor = [[UIColor clearColor] CGColor];
        _personDataView.introduce.layer.borderWidth = .0f;
        _personDataView.introduce.layer.cornerRadius = 0.f;
        _personDataView.headerIcon.layer.borderColor = [[UIColor clearColor] CGColor];
        _personDataView.headerIcon.layer.borderWidth = .0f;
        _personDataView.headerIcon.layer.cornerRadius = 0.f;
        
        //  获取当前时间
        NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        //看一下数据库中有没有该个人介绍的数据
        NSMutableArray *personDataArray = [[lxyDataBase shareLxyDataBase] searchAllDataFromUserTable];
        //如果该表中没有数据
        if (0 == personDataArray.count) {
            //创建该表
            [[lxyDataBase shareLxyDataBase] createUserTable];
            //并把该person插入到新建的表中
            lxyUserTableModel *model = [[[lxyUserTableModel alloc] initWithID:0 andName:nil andPWD:nil andBirthday:nil andHeaderImage:nil andIntroduce:nil andPhoto1:nil andPhoto2:nil] autorelease];
            [[lxyDataBase shareLxyDataBase] insertToUserTableWithOneUserTableModel:model];
        } else {        //如果表中有数据
            //把该person的资料存到数据库中
            [[lxyDataBase shareLxyDataBase] alertNameWithNewName:_personDataView.name.text];
            [[lxyDataBase shareLxyDataBase] alertBirthdayWithNewBirthday:_personDataView.birthday.text];
            [[lxyDataBase shareLxyDataBase] alertContentWithNewContent:_personDataView.introduce.text];
        }
    }
}
//头像图片轻怕手势的监听方法
- (void)headIconTapAction:(UITapGestureRecognizer *)sender
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"select" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"照相机" , @"图库", nil];
    [sheet showInView:self.view];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            //调用照相机
            [self camera];
            break;
        case 1:
            //调用图库
            [self photo];
            
        default:
            break;
    }
}
//调用照相机方法
- (void)camera
{
    //判断照相机是否可以打开
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;     //是否可以编辑
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;        //获取摄像头
        [self presentViewController:picker animated:YES completion:nil];
        [picker release];
    } else {
        //提示用户没有照相机功能
        UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"warnning" message:@"没有没有照相功能" delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
        [aler show];
        [aler release];
    }
}
//调用图库方法
- (void)photo
{
    //判断是否成功调用了系统的图库功能
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;     //是否可以编辑
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;      //打开相册
        [self presentViewController:picker animated:YES completion:nil];
        [picker release];
    } else {
        UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"打开相册失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [aler show];
        [aler release];
    }
}
//UIImagePickerControllerDelegate里的方法
//已经完成选择媒体
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //得到图片
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];

    CGFloat hearIconWidth = self.personDataView.headerIcon.frame.size.width;
    image = [LYHelper OriginImage:image scaleToSize:CGSizeMake(hearIconWidth, image.size.height/image.size.width * hearIconWidth)];
    
    NSString* mediaType=[info objectForKey:UIImagePickerControllerMediaType];
    //    WhatIsX(mediaType);
    if([mediaType isEqualToString:@"public.image"])//@"public.image"
    {
        UIImageOrientation imageOrientation=image.imageOrientation;
        if(imageOrientation!=UIImageOrientationUp)
        {
            //            // 原始图片可以根据照相时的角度来显示，但UIImage无法判定，于是出现获取的图片会向左转９０度的现象。
            //            // 以下为调整图片角度的部分
            UIGraphicsBeginImageContext(image.size);
            [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
            image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            // 调整图片角度完毕
        }
    }

    
    NSData *imgData = UIImagePNGRepresentation(image);
    NSString *time = [LYHelper getCurrentTime];
    
    //拼接出图片路径
    NSString *imagePath = [KDocument stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", time]];
    [imgData writeToFile:imagePath atomically:YES];
    //添加自动释放池————————————————————
    @autoreleasepool {
        UIImage *selectImage = [[[UIImage alloc] initWithContentsOfFile:imagePath] autorelease];
        self.personDataView.headerIcon.image = selectImage;
        self.personDataView.headerIcon.contentMode = UIViewContentModeScaleAspectFit;
        [[lxyDataBase shareLxyDataBase] alertHeadImageWithHeadImage:imagePath];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//获取点击屏幕的位置
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    self.touchPoint = [touch locationInView:self.view];
}
//轻怕屏幕的监听事件
- (void)tapAction:(UITapGestureRecognizer *)sender
{
    [_personDataView.name resignFirstResponder];
    [_personDataView.birthday resignFirstResponder];
    [_personDataView.introduce resignFirstResponder];
}
//开始编辑输入框的时候，软键盘出现，执行此事件
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.frame = _personDataView.introduce.frame;
    NSTimeInterval animationDuration = 0.8f;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    _height = 255 - (self.view.frame.size.height - (_personDataView.introduce.frame.origin.y + _personDataView.introduce.frame.size.height));
    _frame.origin.y = _frame.origin.y - _height;
    [_personDataView.introduce setFrame:_frame];
    
    [UIView commitAnimations];
    
}
//简要完成编辑的时候，来计算textView的高度
- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    NSString *text = _personDataView.introduce.text;
    CGRect frame = [self calcStrHeight:text];
    CGRect yuanframe = _personDataView.introduce.frame;
    [_personDataView.introduce setFrame:yuanframe];
    
    return YES;
}
//输入框编辑完成以后，将视图恢复到原始状态
- (void)textViewDidEndEditing:(UITextView *)textView
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.8f];
    CGRect frame = _personDataView.introduce.frame;
    frame.origin.y = frame.origin.y + _height;
    _personDataView.introduce.frame = frame;
    [UIView commitAnimations];
}
//判断输入框textView中的文字的最大字数
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    //得到输入框的内容
    NSString *toBeString = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    if ([toBeString length] > 150) {
        textView.text = [toBeString substringToIndex:150];
        UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"warnning" message:@"不能超过150个数字" delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
        [aler show];
        [aler release];
        [textView setEditable:NO];
        return NO;
    }
    
    return YES;
}
//判断输入框textField中的文字的最大字数
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //得到输入框的内容
    NSString *toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (textField.tag == 202) {     //如果是姓名输入框，控制其长度不能超过5个字符
        if ([toBeString length] > 5) {
            textField.text = [toBeString substringToIndex:5];
            UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"warnning" message:@"不能超过5个数字" delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
            [aler show];
            [aler release];
            [textField setEnabled:NO];
            return NO;
        }
    }
    
    if (textField.tag == 203) {      //如果是生日输入框，控制其长度不能超过10个字符
        if ([toBeString length] > 10) {
            textField.text = [toBeString substringToIndex:10];
            UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"warnning" message:@"不能超过10个数字" delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
            [aler show];
            [aler release];
            [textField setEnabled:NO];
            return NO;
        }
    }
    
    
    
    return YES;
}
//alertView的代理事件
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [_personDataView.introduce setEditable:YES];
            [_personDataView.name setEnabled:YES];
            [_personDataView.birthday setEnabled:YES];
            break;
        default:
            break;
    }
}



//dailyView上button按钮的事件
- (void)monthlyButton1ForDailyViewAction:(UIButton *)sender
{
    self.view = _monthlyView;
}
- (void)weeklyButton1ForDailyViewAction:(UIButton *)sender
{
    self.view = _weeklyView;
}
- (void)personDataButton1ForDailyViewAction:(UIButton *)sender
{
    self.view = _personDataView;
}

//monthlyView上button按钮的事件
- (void)weeklyButton1ForMonthlyViewAction:(UIButton *)sender
{
    self.view = _weeklyView;
}
- (void)dailyButton1ForMonthlyViewAction:(UIButton *)sender
{
    self.view = _dailyView;
}
- (void)personDataButton1ForMonthlyViewAction:(UIButton *)sender
{
    self.view = _personDataView;
}

//weeklyView上button按钮的事件
- (void)monthlyButton1ForWeeklyViewAction:(UIButton *)sender
{
    self.view = _monthlyView;
}
- (void)dailyButton1ForWeeklyViewAction:(UIButton *)sender
{
    self.view = _dailyView;
}
- (void)personDataButton1ForWeeklyViewAction:(UIButton *)sender
{
    self.view = _personDataView;
}

#pragma mark - 日历
//  上一月按钮
- (void)previousButtonAction:(UIButton *)sender
{
    dtForMonth = [NSDate date];
    i --;
    [self getMonth];
    [self createCalendar];
}

//  下一月按钮
- (void)nextButtonAction:(UIButton *)sender
{
    dtForMonth = [NSDate date];
    i ++;
    [self getMonth];
    [self createCalendar];
}

//  获取要调整的月份
- (void)getMonth
{
    if (i >= 0) {
        NSCalendar *gregorian = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
        NSRange totaldaysForMonth = [gregorian rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:dtForMonth];
        dtForMonth = [dtForMonth dateByAddingTimeInterval:i * (Seconds_of_Minute * Minutes_of_Hour * Hours_of_Day * totaldaysForMonth.length)];
    } else {
        NSCalendar *gregorian = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
        NSDateComponents *components = [[[NSDateComponents alloc] init] autorelease];
        [components setMonth:i * (Minus_month_for_Previous_Action)];
        dtForMonth = [gregorian dateByAddingComponents:components toDate:dtForMonth options:0];
    }
}

//  创建日历
-(void)createCalendar
{
    
    if ([self.monthlyView viewWithTag:1001])
    {
        [[self.monthlyView viewWithTag:1001] removeFromSuperview];
    }
    UIView *viewTmp = [[[UIView alloc] initWithFrame:CGRectMake(0, 30, 320, 400)] autorelease];
    //viewTmp.backgroundColor = [UIColor cyanColor];
    viewTmp.tag=1001;
    [self.monthlyView.imageView addSubview:viewTmp];
    int X = 0;
    
    //dtForMonth = [NSDate date];
    
    //right now i have create 1*1 matrix of calendar to display on view, in next versions i wll make it dynamic.
    
    //  当前dtFormonth去创建日历
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:dtForMonth];
    NSInteger month = [components month];
    NSInteger year = [components year];
    NSInteger day = [components day];
    
    //  显示月份
    NSDateFormatter *dt = [[[NSDateFormatter alloc] init] autorelease];
    NSString *strMonthName = [[dt monthSymbols] objectAtIndex:month-1];//January,Febryary,March etc...
    strMonthName = [ strMonthName stringByAppendingString:[NSString  stringWithFormat:@"- %d",year]];
    
    //  日历的X坐标
    X = 20;
    //  日历的Y坐标
    originY = 80;
    
    YCCalendarView  *vwCal = [[[YCCalendarView alloc] initWithFrame:CGRectMake(X, 0, 287, self.view.bounds.size.height - 50)] autorelease];
    X++;
    vwCal.tag = 100;
    vwCal.layer.masksToBounds = NO;
    
    //添加自动释放池————————————————————————————————————
    @autoreleasepool {
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"blueSky" ofType:@"png"];
        UIImage *image = [[[UIImage alloc] initWithContentsOfFile:imagePath] autorelease];
        vwCal.backgroundColor = [UIColor colorWithPatternImage:image];
        vwCal = [vwCal createCalOfDay:day Month:month Year:year MonthName:strMonthName];
    }
    [viewTmp addSubview:vwCal];
}

#pragma mark - Daily
#pragma mark UITableViewDataSource Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.keyArray count] == 0) {
        return 0;
    } else {
        return [self.dict[self.keyArray[section]] count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cell_idenfier = @"cell_idenfier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_idenfier];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cell_idenfier] autorelease];
    }
    NSArray *nowArray = self.dict[self.keyArray[indexPath.section]];
    cell.textLabel.text = [nowArray[indexPath.row] diary_title];
    cell.textLabel.textColor = UIColorFromRGB(0xB94FFF);
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = [UIFont fontWithName:@"LiDeBiao-Xing-3.0" size:20.f];
    cell.detailTextLabel.text = [[nowArray[indexPath.row] diary_time] substringWithRange:NSMakeRange(11, 8)];
    cell.detailTextLabel.textColor = UIColorFromRGB(0xFF8800);
    cell.detailTextLabel.font = [UIFont fontWithName:@"LiDeBiao-Xing-3.0" size:20.f];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fy"]];
    cell.backgroundView = imageView;
    [imageView release];
    NSString *iconImagePath = [nowArray[indexPath.row] diary_icon];
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:iconImagePath];
    cell.imageView.image = image;
    [image release];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if ([self.keyArray count] == 0) {
        return 0;
    } else {
        return self.keyArray[section];
    }
}

//  自定义高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array = self.dict[self.keyArray[indexPath.section]];
    NSString *title = [array[indexPath.row] diary_title];
    CGRect rect = [title boundingRectWithSize:CGSizeMake(220, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont fontWithName:@"LiDeBiao-Xing-3.0" size:20.f]} context:nil];
    if (rect.size.height > 44) {
        return rect.size.height;
    } else {
        return 44;
    }
}

#pragma mark - UISearchBarDelegate Methods

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar                       // return NO to not become first responder
{
    //NSLog(@"111");
    return YES;
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar                     // called when text starts editing
{
    //NSLog(@"222");
}
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar                        // return NO to not resign first responder
{
    //NSLog(@"333");
    return YES;
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar                       // called when text ends editing
{
    //NSLog(@"444");
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText   // called when text changes (including clear)
{
    //NSLog(@"555");
    self.array = [lxyFunctionOfDataBase searchAllDataInTable:@"diaryTable"];
    self.keyArray = nil;
    for (lxyDiaryModel *model in self.array) {
        NSString *key = [[model diary_time] substringToIndex:10];
        if ([self.keyArray containsObject:key]) {
            [self.dict[key] addObject:model];
        } else {
            NSMutableArray *diArray = [NSMutableArray arrayWithObject:model];
            [_dict setObject:diArray forKey:key];
            _keyArray = [[self.dict allKeys] mutableCopy];
        }
    }
    [self.dailyView.tableView reloadData];
}
- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text NS_AVAILABLE_IOS(3_0) // called before text changes
{
   //NSLog(@"101010");
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar                     // called when keyboard search button pressed
{
    //NSLog(@"666");
    self.array = [lxyFunctionOfDataBase searchAllDataInTable:@"diaryTable"];
    NSMutableArray *stringArray = [NSMutableArray array];
    for (lxyDiaryModel *model in self.array) {
        if ([[model diary_title] isEqualToString:searchBar.text]) {
            [stringArray addObject:model];
        }
    }
    self.array = stringArray;
    self.keyArray = nil;
    for (lxyDiaryModel *model in self.array) {
        NSString *key = [[model diary_time] substringToIndex:10];
        if ([self.keyArray containsObject:key]) {
            [self.dict[key] addObject:model];
        } else {
            NSMutableArray *diArray = [NSMutableArray arrayWithObject:model];
            [_dict setObject:diArray forKey:key];
            _keyArray = [[self.dict allKeys] mutableCopy];
        }
    }
    
    [self.dailyView.tableView reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar                    // called when cancel button pressed
{
    self.array = [lxyFunctionOfDataBase searchAllDataInTable:@"diaryTable"];
    for (lxyDiaryModel *model in self.array) {
        NSString *key = [[model diary_time] substringToIndex:10];
        if ([self.keyArray containsObject:key]) {
            [self.dict[key] addObject:model];
        } else {
            NSMutableArray *diArray = [NSMutableArray arrayWithObject:model];
            [_dict setObject:diArray forKey:key];
            _keyArray = [[self.dict allKeys] mutableCopy];
        }
    }
    [self.dailyView.tableView reloadData];
}

#pragma mark - 轻拍手势
- (void)tapGRAction:(UITapGestureRecognizer *)sender
{
    [self.dailyView.searchBar resignFirstResponder];
}

#pragma mark 计算一个字符串高度的算法
- (CGRect)calcStrHeight:(NSString *)str
{
    CGSize maxSize = CGSizeMake(220, 1000);
    
    //文字大小
    NSDictionary *fontDictn = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:17.f], NSFontAttributeName ,  nil];
    
    //计算出文字应占的size
    CGRect rect = [str boundingRectWithSize:maxSize
                                    options:NSStringDrawingUsesLineFragmentOrigin
                                 attributes:fontDictn
                                    context:nil];
    return rect;
}

#pragma mark 隐藏导航栏上方系统时间、电池显示
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
