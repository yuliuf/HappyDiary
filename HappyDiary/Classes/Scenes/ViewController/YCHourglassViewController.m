//
//  YCHourglassViewController.m
//  HappyDiary
//
//  Created by 孙震 on 14-6-20.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import "YCHourglassViewController.h"
#import "YCHourglassView.h"
#import "YCHourglassCell.h"
#import "YCCreateHourglassView.h"
//#import "lxyHourglassTabaleModel.h"
#import "lxySandTimerModel.h"
//#import "lxyDataBase.h"
#import "YCDetailHourglassViewController.h"
#import "YCDeleteHourglassView.h"
//#import "lxyHourglassTabaleModel.h"
#import "YCCreateHourglassViewController.h"

#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>
#import <netdb.h>
#import <SystemConfiguration/SCNetworkReachability.h>


@interface YCHourglassViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIAlertViewDelegate>
{
    //lxySandTimerModel *nowSandModel;  //  点击删除
    NSString *table_name;
    NSString *selector;
}

@property (nonatomic, strong) YCHourglassView *hourglassView;
@property (nonatomic, strong) YCCreateHourglassView *createHourglassView;
@property (nonatomic, strong) YCDeleteHourglassView *deleteHourglassView;
@property (nonatomic, strong) NSArray *hourglassModelArray;

@end

NSInteger indexCell = 0;

@implementation YCHourglassViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"沙漏" image:[UIImage imageNamed:@"diary"] tag:3];
    }
    return self;
}

- (void)loadView
{
    self.hourglassView = [[YCHourglassView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view = _hourglassView;
}

- (void)viewDidLoad
{
    //[self start];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //  添加页面
    //self.createHourglassView = [[[YCCreateHourglassView alloc] initWithFrame:CGRectMake(70, 30, 200, 200)] autorelease];
    
    //  删除页面
    self.deleteHourglassView = [[YCDeleteHourglassView alloc] initWithFrame:CGRectMake(70, 30, 200, 200)];
    
    self.hourglassView.collectionView.backgroundColor = UIColorFromRGB(0xFFFFFF);
    
    //  设置delegate
    self.hourglassView.collectionView.dataSource = self;
    self.hourglassView.collectionView.delegate = self;
    
    //  注册cell
    [self.hourglassView.collectionView registerClass:[YCHourglassCell class] forCellWithReuseIdentifier:@"cell_collection"];
    
    //  添加删除按钮监听事件
    [self.hourglassView.addButton addTarget:self action:@selector(addButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.hourglassView.deleteButton addTarget:self action:@selector(deleteButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    /*
    //  添加长按手势
    UILongPressGestureRecognizer *lpGR = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(lpGRAction:)];
    lpGR.minimumPressDuration = 1.f;
    [self.view addGestureRecognizer:lpGR];
    [lpGR release];
    */
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSourse Methods
#pragma mark 设置组数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

#pragma mark 设置每个分组中游多少item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray *array = [lxyFunctionOfDataBase searchAllDataInTable:@"sandTimerTable"];
    return [array count];
}

#pragma mark 设置每个item上显示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YCHourglassCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell_collection" forIndexPath:indexPath];
    if (!cell) {
        cell = [[YCHourglassCell alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    }
    NSArray *array = [lxyFunctionOfDataBase searchAllDataInTable:@"sandTimerTable"];
    cell.label.text = [array[indexPath.row] peopleName];
    cell.label.font = [UIFont fontWithName:@"LiDeBiao-Xing-3.0" size:20.f];
    //cell.label.textColor = UIColorFromRGB(0xFF8800);
    cell.label.textColor = [UIColor blackColor];
    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    backImageView.image = [UIImage imageNamed:@"blue"];
    cell.backgroundView = backImageView;
    NSString *image_str = @"";
    if ([[array[indexPath.row] sandStyle] intValue] == 0) {
        image_str = @"shalou5";
    } else if ([[array[indexPath.row] sandStyle] intValue] == 1) {
        image_str = @"shalou1";
    } else if ([[array[indexPath.row] sandStyle] intValue] == 2) {
        image_str = @"shalou3";
    } else if ([[array[indexPath.row] sandStyle] intValue] == 3) {
        image_str = @"shalou2";
    }
    cell.imageView.image = [UIImage imageNamed:image_str];
    return cell;
    
    /*
    cell.label.text = [_hourglassModelArray[indexPath.row] objectForKey:@"hg_name"];
    cell.label.font = [UIFont fontWithName:@"LiDeBiao-Xing-3.0" size:20.f];
    cell.label.textColor = UIColorFromRGB(0xFF44AA);
    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    cell.imageView.image = [UIImage imageNamed:@"tuya"];
    return cell;
     */
}


/*
- (void)loadData
{
    //  读取数据
    
    //_hourglassModelArray = [NSArray array];
    
    table_name = @"hourglass_table";
    selector = @"select";
    
    NSString *url_str = [NSString stringWithFormat:@"http://172.16.3.125/happyDiary_db.php?table_name=%@&selector=%@", table_name, selector];
    NSURL *url = [NSURL URLWithString:url_str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLResponse *response = [[NSURLResponse alloc] init];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    self.hourglassModelArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
}
 */

#pragma mark - UICollectionViewDelegateFlowLayout
#pragma mark 点击cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    YCDetailHourglassViewController *detailHourglassVC = [[YCDetailHourglassViewController alloc] init];
    NSMutableArray *array = [lxyFunctionOfDataBase searchAllDataInTable:@"sandTimerTable"];
    detailHourglassVC.sandModel = array[indexPath.row];
    detailHourglassVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    //NSLog(@"sandModel:%@", [detailHourglassVC.sandModel style]);
    [self presentViewController:detailHourglassVC animated:YES completion:nil];
    
    //  获取当前点击模型
    //nowSandModel = array[indexPath.row];
}

#pragma mark 间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

#pragma mark - 添加删除的按钮事件
#pragma mark 添加按钮
- (void)addButtonAction:(UIButton *)sender
{
    /*
    [UIView animateWithDuration:0.3f animations:^{
        self.createHourglassView.alpha = 1.f;
        self.createHourglassView.transform = CGAffineTransformMakeScale(1.f, 1.f);
    } completion:^(BOOL finished) {
        [self.view addSubview:_createHourglassView];
    }];
    [self.createHourglassView.textField becomeFirstResponder];
    
    //  添加按钮的监听方法
    [self.createHourglassView.saveButton addTarget:self action:@selector(saveButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.createHourglassView.cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
     */
    
    YCCreateHourglassViewController *createHourglassVC = [[YCCreateHourglassViewController alloc] init];
    createHourglassVC.modalTransitionStyle = UIModalPresentationPageSheet;
    [self presentViewController:createHourglassVC animated:YES completion:nil];
}

#pragma mark 删除按钮
- (void)deleteButtonAction:(UIButton *)sender
{
    [UIView animateWithDuration:0.3f animations:^{
        self.deleteHourglassView.alpha = 1.f;
        self.deleteHourglassView.transform = CGAffineTransformMakeScale(1.f, 1.f);
    } completion:^(BOOL finished) {
        [self.view addSubview:_deleteHourglassView];
    }];
    
    [self.deleteHourglassView.nameTextField becomeFirstResponder];
    
    //  删除按钮的监听方法
    [self.deleteHourglassView.saveButton addTarget:self action:@selector(deleteHourglassViewSaveButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.deleteHourglassView.cancelButton addTarget:self action:@selector(deleteHourglassViewCancelButton:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 删除页面的删除按钮
#pragma mark - 删除按钮
- (void)deleteHourglassViewSaveButton:(UIButton *)sender
{
    NSString *name = self.deleteHourglassView.nameTextField.text;
    lxySandTimerModel *sandModel = nil;
    NSMutableArray *array = [lxyFunctionOfDataBase searchAllDataInTable:@"sandTimerTable"];
    for (lxySandTimerModel *model in array) {
        if ([[model peopleName] isEqualToString:name]) {
            sandModel = model;
            break;
        }
    }
    [lxyFunctionOfDataBase deleteOneDataBy:sandModel fromTable:@"sandTimerTable"];
    
    [self.hourglassView.collectionView reloadData];
    
    [UIView animateWithDuration:0.3f animations:^{
        self.deleteHourglassView.alpha = 0.1f;
        self.deleteHourglassView.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
    } completion:^(BOOL finished) {
        [self.deleteHourglassView removeFromSuperview];
    }];
    
    self.deleteHourglassView.nameTextField.text = @"";
}

#pragma mark 取消按钮
- (void)deleteHourglassViewCancelButton:(UIButton *)sender
{
    [UIView animateWithDuration:0.3f animations:^{
        self.deleteHourglassView.alpha = 0.1f;
        self.deleteHourglassView.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
    } completion:^(BOOL finished) {
        [self.deleteHourglassView removeFromSuperview];
    }];
    
    self.deleteHourglassView.nameTextField.text = @"";
}

#pragma mark - 添加页面的按钮事件
#pragma mark 取消按钮
- (void)cancelButtonAction:(UIButton *)sender
{
    [UIView animateWithDuration:0.3f animations:^{
        self.createHourglassView.alpha = 0.1f;
        self.createHourglassView.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
    } completion:^(BOOL finished) {
        [self.createHourglassView removeFromSuperview];
    }];
    
    self.createHourglassView.textField.text = @"";
}

#pragma mark 保存按钮
- (void)saveButtonAction:(UIButton *)sender
{
    //  获取textFiled.text
    NSString *string = self.createHourglassView.textField.text;
    
    //  创建沙漏模型
    
    lxySandTimerModel *sandTimerModel = [[lxySandTimerModel alloc] init];
    
    /*
    //  创建沙漏模型
    lxyHourglassTabaleModel *hourglassTabelModel = [[lxyHourglassTabaleModel alloc] init];
    
    //hourglassTabelModel.hg_id = hourglassModelArray.count;
    hourglassTabelModel.hg_name = string;
    hourglassTabelModel.hg_image = @"001";
    hourglassTabelModel.hg_music = @"002";
    
    //  创建沙漏模型的时间
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *time = [dateFormatter stringFromDate:[NSDate date]];
    hourglassTabelModel.hg_time = time;
    */
    
    
    
     NSMutableArray *array = [lxyFunctionOfDataBase searchAllDataInTable:@"sandTimerTable"];
     sandTimerModel.ID = [NSString stringWithFormat:@"%d", array.count];
     sandTimerModel.sandStyle = @"005";
     sandTimerModel.backGroundMusic = @"003";
     sandTimerModel.peopleName = string;
     //  创建沙漏模型的时间
     NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
     [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
     NSString *time = [dateFormatter stringFromDate:[NSDate date]];
     sandTimerModel.time = time;
    
    
    //  把模型插入到数据表中
    [lxyFunctionOfDataBase insertToTabel:@"sandTimerTable" withObject:sandTimerModel];
    
    /*
     
    table_name = @"hourglass_table";
    selector = @"insert";
    NSString *url_str2 = [NSString stringWithFormat:@"http://172.16.3.125/happyDiary_db.php?table_name=%@&selector=%@&hg_name=%@&hg_image=%@&hg_music=%@&hg_time=%@", table_name, selector, hourglassTabelModel.hg_name, hourglassTabelModel.hg_image, hourglassTabelModel.hg_music, hourglassTabelModel.hg_time];
    NSURL *url2 = [NSURL URLWithString:url_str2];
    NSURLRequest *request2 = [NSURLRequest requestWithURL:url2];
    NSOperationQueue *queue2 = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request2 queue:queue2 completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        //hourglassModelArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    }];
     
     */
    
    [UIView animateWithDuration:0.3f animations:^{
        self.createHourglassView.alpha = 0.1f;
        self.createHourglassView.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
    } completion:^(BOOL finished) {
        [self.createHourglassView removeFromSuperview];
    }];
    
    //  创建单个沙漏模型表
    [[lxyDataBase shareLxyDataBase] createTableWithPeopleNameForTableName:string];
    
    [self.hourglassView.collectionView reloadData];
    
    //  取消第一响应者
    [self.createHourglassView.textField resignFirstResponder];
    
    self.createHourglassView.textField.text = @"";
}

/*
#pragma mark 长按手势
- (void)lpGRAction:(UILongPressGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定要删除吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
        [alertView release];
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            break;
        case 1: {
            //  删除数据
            [lxyFunctionOfDataBase deleteOneDataBy:nowSandModel fromTable:@"sandTimerTable"];
            [self.hourglassView.collectionView reloadData];
        }
        default:
            break;
    }
}
 */

#pragma mark - 判断联网状态
- (BOOL) connectedToNetwork
{
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        return NO;
    }
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable && !needsConnection) ? YES : NO;
}

//call like:
-(void) start {
    if (![self connectedToNetwork]) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Network Connection Error"
                              message:@"You need to be connected to the internet to use this feature."
                              delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    } else {
        /*
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Network Connection success" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
         */
    }
}

#pragma mark - 刷新UI
- (void)viewWillAppear:(BOOL)animated
{
    [self.hourglassView.collectionView reloadData];
}

#pragma mark - 隐藏导航栏上方系统时间、电池显示
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
@end

