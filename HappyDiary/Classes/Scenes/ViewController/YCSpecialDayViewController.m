//
//  YCSpecialDayViewController.m
//  HappyDiary
//
//  Created by 孙震 on 14-6-25.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "YCSpecialDayViewController.h"
#import "YCSpecialDayView.h"
#import "YCSpecialDayTable.h"
#import "LYTabBarController.h"

@interface YCSpecialDayViewController () <UITableViewDataSource, UITableViewDelegate>
{
    NSString *table_name;
    NSString *selector;
}

@property (nonatomic, retain) YCSpecialDayView *specialDayView;
@property (nonatomic, retain) NSMutableArray *specialDayArray;

@end

@implementation YCSpecialDayViewController

- (void)dealloc
{
    [_contentView release];
    [_saveButton release];
    [_cancleButton release];
    [_timeLabel release];
    [_timeTextField release];
    [_detailLabel release];
    [_detailTextView release];
    [_specialDayView release];
    [_specialDayArray release];
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
    self.specialDayView = [[[YCSpecialDayView alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.view = _specialDayView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //  读取数据
    //[self loadData];
    self.specialDayArray = [lxyFunctionOfDataBase searchAllDataInTable:@"specialDayTable"];
    
    //  设置代理
    self.specialDayView.tableView.dataSource = self;
    self.specialDayView.tableView.delegate = self;
    
    /*
    //  左按钮
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(leftBarAction:)];
    [leftBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"LiDeBiao-Xing-3.0" size:22.f], NSFontAttributeName, UIColorFromRGB(0xB94FFF), NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = leftBar;
    [leftBar release];
    
    //  右按钮
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStyleDone target:self action:@selector(rightBarAction::)];
    [rightBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"LiDeBiao-Xing-3.0" size:22.f], NSFontAttributeName, UIColorFromRGB(0xB94FFF), NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightBar;
    [rightBar release];
     */
    
    self.rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _rightButton.frame = Rect(240, 8, 60, 30);
    [_rightButton setTitle:@"添加" forState:UIControlStateNormal];
    _rightButton.tintColor = [UIColor whiteColor];
    _rightButton.titleLabel.font = myZiti;
    [_rightButton addTarget:self action:@selector(rightButtonAction::) forControlEvents:UIControlEventTouchUpInside];
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
    
    
    
    // 弹出的添加视图
    self.contentView = [[[UIView alloc] initWithFrame:CGRectMake(10, 149, 300, 170)] autorelease];
    self.contentView.layer.borderWidth = .5f;
    self.contentView.layer.cornerRadius = 5.f;
    self.contentView.backgroundColor = UIColorFromRGB(0xFFFFFF);
    
    //  添加视图上的控件
    self.detailLabel = [[[UILabel alloc] initWithFrame:CGRectMake(10, 25, 60, 30)] autorelease];
    self.detailLabel.text = @"记录: ";
    self.detailLabel.font = [UIFont fontWithName:@"LiDeBiao-Xing-3.0" size:20.f];
    self.detailLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:_detailLabel];
    
    self.detailTextView = [[[UITextView alloc] initWithFrame:CGRectMake(60, 15, 230, 50)] autorelease];
    self.detailTextView.font = [UIFont fontWithName:@"LiDeBiao-Xing-3.0" size:17.F];
    self.detailTextView.textColor = [UIColor blackColor];
    self.detailTextView.layer.borderWidth = .5f;
    self.detailTextView.layer.cornerRadius = 5.f;
    //self.detailTextView.layer.borderColor = [[UIColor orangeColor] CGColor];
    [self.contentView addSubview:_detailTextView];
    
    self.timeLabel = [[[UILabel alloc] initWithFrame:CGRectMake(10, 80, 60, 30)] autorelease];
    self.timeLabel.text = @"时间: ";
    self.timeLabel.font = [UIFont fontWithName:@"LiDeBiao-Xing-3.0" size:20.f];
    self.timeLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:_timeLabel];
    
    self.timeTextField = [[[UITextField alloc] initWithFrame:CGRectMake(60, 75, 230, 50)] autorelease];
    self.timeTextField.font = [UIFont fontWithName:@"LiDeBiao-Xing-3.0" size:19.F];
    self.timeTextField.textColor = [UIColor blackColor];
    self.timeTextField.placeholder = @"2014/07/06";
    self.timeTextField.layer.borderWidth = .5f;
    //self.timeTextField.layer.borderColor = [[UIColor orangeColor] CGColor];
    self.timeTextField.layer.cornerRadius = 5.f;
    self.timeTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    [self.contentView addSubview:_timeTextField];
    
    self.saveButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.saveButton setTitle:@"保存" forState:UIControlStateNormal];
    self.saveButton.frame = CGRectMake(60, 135, 60, 30);
    self.saveButton.titleLabel.font = [UIFont fontWithName:@"LiDeBiao-Xing-3.0" size:17.F];
    [self.saveButton addTarget:self action:@selector(saveButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_saveButton];
    
    self.cancleButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    self.cancleButton.frame = CGRectMake(140, 135, 60, 30);
    self.cancleButton.titleLabel.font = [UIFont fontWithName:@"LiDeBiao-Xing-3.0" size:17.F];
    [self.cancleButton addTarget:self action:@selector(cancleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_cancleButton];
}

/*
- (void)loadData
{
    
    table_name = @"specialDay_table";
    selector = @"select";
    
    NSString *url_str = [NSString stringWithFormat:@"http://172.16.3.125/happyDiary_db.php?table_name=%@&selector=%@", table_name, selector];
    NSURL *url = [NSURL URLWithString:url_str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLResponse *response = [[NSURLResponse alloc] init];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    self.specialDayArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"specialDayArray:%@", self.specialDayArray);
    
}
 */

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - navigationItem
- (void)leftButtonAction:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)rightButtonAction:(UIButton *)sender :(UIEvent *)event
{
    [UIView animateWithDuration:0.3f animations:^{
        self.contentView.alpha = 1.f;
        self.contentView.transform = CGAffineTransformMakeScale(1.f, 1.f);
    } completion:^(BOOL finished) {
        [self.view addSubview:_contentView];
    }];
    
    if ((MaxY(self.saveButton.frame) + 149) > (self.view.bounds.size.height - 216)) {
        
        NSTimeInterval animationDuration = 0.3f;
        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        //将视图Y坐标上移
        self.contentView.frame = CGRectMake(10, 60, 300, 170);
        [UIView commitAnimations];
    }
    
    
    [self.detailTextView becomeFirstResponder];
    
}

- (void)saveButtonAction:(UIButton *)sender
{
    /*
    table_name = @"specialDay_table";
    selector = @"insert";
    
    NSString *title = self.detailTextView.text;
    NSString *time = self.timeTextField.text;
    NSString *title_utf8 = [title stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *time_utf8 = [time stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *url_str = [NSString stringWithFormat:@"http://172.16.3.125/happyDiary_db.php?table_name=%@&selector=%@&sd_title=%@&sd_time=%@", table_name, selector, title_utf8, time_utf8];
    NSURL *url = [NSURL URLWithString:url_str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLResponse *response = [[NSURLResponse alloc] init];
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
     */
    
    NSMutableArray *specialDayArray = [lxyFunctionOfDataBase searchAllDataInTable:@"specialDayTable"];
    NSString *special_id = [NSString stringWithFormat:@"%d", [specialDayArray count]];
    NSString *special_time = self.timeTextField.text;
    NSString *special_title = self.detailTextView.text;
    NSString *special_icon = @"";
    
    //  创建特殊日对象
    YCSpecialDayTable *specialDayModel = [[[YCSpecialDayTable alloc] initWithID:special_id time:special_time title:special_title icon:special_icon] autorelease];
    
    //  插入到特殊日表中
    [lxyFunctionOfDataBase insertToTabel:@"specialDayTable" withObject:specialDayModel];
    
    //  更新UI
    //[self loadData];
    self.specialDayArray = [lxyFunctionOfDataBase searchAllDataInTable:@"specialDayTable"];
    [self.specialDayView.tableView reloadData];
    
    //  隐藏添加界面
    [UIView animateWithDuration:0.3f animations:^{
        self.contentView.alpha = 0.1f;
        self.contentView.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
    } completion:^(BOOL finished) {
        [self.contentView removeFromSuperview];
    }];
    
    //
    self.detailTextView.text = @"";
    self.timeTextField.text = @"";
}

- (void)cancleButtonAction:(UIButton *)sender
{
    [UIView animateWithDuration:0.3f animations:^{
        self.contentView.alpha = 0.1f;
        self.contentView.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
    } completion:^(BOOL finished) {
        [self.contentView removeFromSuperview];
    }];
    
    //
    self.detailTextView.text = @"";
    self.timeTextField.text = @"";
}

#pragma mark - UITableViewDataSource Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.specialDayArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cell_idenfier = @"cell_idenfier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_idenfier];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cell_idenfier] autorelease];
    }
    cell.textLabel.text = [self.specialDayArray[indexPath.row] sd_title];
    cell.textLabel.font = [UIFont fontWithName:@"LiDeBiao-Xing-3.0" size:22.f];
//    cell.textLabel.textColor = UIColorFromRGB(0xB94FFF);
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.numberOfLines = 0;
    cell.detailTextLabel.text = [self.specialDayArray[indexPath.row] sd_time];
    cell.detailTextLabel.font = [UIFont fontWithName:@"LiDeBiao-Xing-3.0" size:22.f];
    //cell.detailTextLabel.textColor = [UIColor orangeColor];
    cell.detailTextLabel.textColor = [UIColor grayColor];
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fy"]];
    return cell;
}

#pragma mark - UITableViewDelegate Methods
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete) {
        /*
        table_name = @"specialDay_table";
        selector = @"delete";
        NSString *title = [self.specialDayArray[indexPath.row] objectForKey:@"sd_title"];
        NSString *title_utf8 = [title stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *url_str = [NSString stringWithFormat:@"http://172.16.3.125/happyDiary_db.php?table_name=%@&selector=%@&sd_title=%@", table_name, selector, title_utf8];
        NSURL *url = [NSURL URLWithString:url_str];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSURLResponse *response = [[NSURLResponse alloc] init];
        [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
        */
        
        //  更新UI
        //[self loadData];
        
        [lxyFunctionOfDataBase deleteOneDataBy:self.specialDayArray[indexPath.row] fromTable:@"specialDayTable"];
        NSLog(@"sp:%@", self.specialDayArray[indexPath.row]);
        
        //[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        self.specialDayArray = [lxyFunctionOfDataBase searchAllDataInTable:@"specialDayTable"];
        [self.specialDayView.tableView reloadData];
    }
}

//  自适应高度

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *title = [self.specialDayArray[indexPath.row] sd_title];
    CGRect rect = [title boundingRectWithSize:CGSizeMake(300, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont fontWithName:@"LiDeBiao-Xing-3.0" size:22.f]} context:nil];
    if (rect.size.height > 44) {
        return rect.size.height + 49;
    } else {
        return 49;
    }
}

#pragma mark - 键盘上浮
- (void)textViewDidBeginEditing:(UITextView *)textView
{
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


#pragma mark 隐藏导航栏上方系统时间、电池显示
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
