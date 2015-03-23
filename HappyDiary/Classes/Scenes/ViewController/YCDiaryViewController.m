//
//  YCDiaryViewController.m
//  HappyDiary
//
//  Created by 孙震 on 14-6-20.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import "YCDiaryViewController.h"
#import "LYDiaryView.h"
#import "lxyDiaryModel.h"
#import "LYCustomCell.h"
#import "LYTuyaBan.h"
#import "LYTuyaView.h"
#import "LYCustomTextField.h"
#import "lxyEventViewController.h"

#define BTN_SIZE 44
#define TXT_FRAME Rect(40, 93, ScreenWidth-80, ScreenHeight-160)
#define TIME2 10
#define MAXNUM 10

@interface YCDiaryViewController ()<UIGestureRecognizerDelegate, UITextViewDelegate, UITableViewDataSource, UITableViewDelegate , UIActionSheetDelegate , UINavigationControllerDelegate , UIImagePickerControllerDelegate , UIAlertViewDelegate, UITextFieldDelegate>

- (void)initArrays;
- (void)tapGRAction:(UITapGestureRecognizer *)sender;
- (void)toolButtonAction:(UIButton *)sender;
- (void)buttonClicked:(UIButton *)button;

@end

NSInteger i = 0;
NSInteger alerIndex = 0;


@interface YCDiaryViewController ()
@property (nonatomic, retain) LYDiaryView *diaryView;  //  自定义视图
@property (nonatomic, retain) lxyDiaryModel *diary; //  普通日记模型
@property (nonatomic, assign) BOOL isKeyBoardVisible;  //  键盘是否可见
@property (nonatomic, retain) NSArray *weatherArray;  // 天气数组
@property (nonatomic, retain) NSArray *toolArray;   //  工具数组
@property (nonatomic, retain) LYToolView *toolView;  //  工具选择框
@property (nonatomic, retain) NSArray *duiqiArray;  //  文本对齐方式
@property (nonatomic, retain) NSArray *backgroundImage; //  信纸
@property (nonatomic, retain) NSArray *textColorArray;  //  文本颜色
@property (nonatomic, retain) NSArray *eventIconArray;  //  事件图标

@property (nonatomic, retain) NSDictionary *textEditDict;   //  文本编辑的字典
@property (nonatomic, retain) NSDictionary *decoDict;   //  装饰物的字典
@property (nonatomic, retain) NSDictionary *bgDict;  //  各种背景的字典

@property (nonatomic, retain) NSDictionary *dictForTableView;
@property (nonatomic, retain) UITableView *rightToorBar;

@property (nonatomic, retain) UILongPressGestureRecognizer *longPressGR;//  对tablrView添加长按手势

@property (nonatomic, assign) CGPoint beganPoint;

@property (nonatomic, assign) BOOL topToolViewIsShow;       //      给上左右的工具栏设置开关状态
@property (nonatomic, assign) BOOL leftToolViewIsShow;
@property (nonatomic, assign) BOOL rightToolViewIsShow;
@property (nonatomic, assign) BOOL rightIsClicked;
@property (nonatomic, assign) BOOL leftIsClicked;


@end

@implementation YCDiaryViewController

- (void)dealloc
{
    [_jiepingImageView release];
    [_finishButton release];
    [_cancelButton release];
    
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    [self initArrays];
        WhatIsX(KDocument);
    }
    return self;
}
- (void)loadView
{
    self.diaryView = [[[LYDiaryView alloc] initWithFrame:[UIScreen mainScreen].bounds] autorelease];
    self.view = self.diaryView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.diary = [[[lxyDiaryModel alloc] init] autorelease];
    self.diaryView.title.delegate = self;
    
    //  给事件图标赋初值
    NSString *iconPath = [[NSBundle mainBundle] pathForResource:@"event_icon0" ofType:@"png"];
    _diary.diary_icon = iconPath;

    
    //  获取图标数据
    NSString *path = [[NSBundle mainBundle] pathForResource:@"tool1" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    self.textEditDict = array[0];
    self.decoDict = array[1];
    self.bgDict = array[2];
    
    //添加截屏所用的图片
    UIImage *img = [UIImage imageNamed:@"kuang.png"];
    self.jiepingImageView = [[[UIImageView alloc] initWithImage:img] autorelease];
    _jiepingImageView.frame = CGRectMake(70, 250, 200, 180);
    _jiepingImageView.hidden = YES;
    [self.view addSubview:_jiepingImageView];
    //添加截屏时所用的finish按钮
    self.finishButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _finishButton.frame = CGRectMake(_jiepingImageView.frame.origin.x + _jiepingImageView.frame.size.width, _jiepingImageView.frame.origin.y - 20, 20, 20);
    [_finishButton setTitle:@"√" forState:UIControlStateNormal];
    _finishButton.hidden = YES;
    [_finishButton addTarget:self action:@selector(finishButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_finishButton];
    //添加截屏时的取消button
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _cancelButton.frame = CGRectMake(_jiepingImageView.frame.origin.x - 20, _jiepingImageView.frame.origin.y - 20, 20, 20);
    [_cancelButton setTitle:@"x" forState:UIControlStateNormal];
    _cancelButton.hidden = YES;
    [_cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_cancelButton];
    
    //  添加topToolView
    self.toolView = [[[LYToolView alloc] initWithTitle:@"工具" withFrame:Rect(edgeMagin, kMargin, ScreenWidth - 2 *edgeMagin, 80)] autorelease];
    [self addToolButtons];
    //  topView 关闭按钮添加事件
    [_toolView.closeBtn addTarget:self action:@selector(closeToolView:) forControlEvents:UIControlEventTouchUpInside];
    self.toolView.alpha = 0.f;
    [self.diaryView addSubview:_toolView];
    [_toolView release];
    
    // 工具按钮事件
    [self.diaryView.toolButton addTarget:self action:@selector(toolButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //  用tableView写的右侧工具栏
    self.dictForTableView = [NSDictionary dictionary];
    self.diaryView.rightToorBar.delegate = self;
    self.diaryView.rightToorBar.dataSource = self;
    
    //  长按手势
    self.diaryView.longPressGR.delegate = self;
    [self.diaryView.longPressGR addTarget:self action:@selector(longPressGR:)];
    
    // 天气按钮添加事件
    [self.diaryView.weatherBtn sizeToFit];
    [self.diaryView.weatherBtn addTarget:self action:@selector(eventIconSelect:) forControlEvents:UIControlEventTouchUpInside];
    //  轻拍手势添加事件
    _diaryView.tapGR.delegate = self;
    [self.diaryView.tapGR addTarget:self action:@selector(tapGRAction:)];
    
    //  保存按钮
    [self.diaryView.savaButton addTarget:self action:@selector(saveButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //  清空按钮
    [self.diaryView.cleanButton addTarget:self action:@selector(cleanButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //  跳转到今日记录
    [self.diaryView.eventButton addTarget:self action:@selector(eventButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
}
#pragma mark 清空按钮
- (void)cleanButtonAction:(UIButton *)sender
{
    for (UIView *view in self.diaryView.xinzhi.subviews) {
        [view removeFromSuperview];
    }
}
#pragma mark 跳转到今日记录
- (void)eventButtonAction:(UIButton *)sender
{
    lxyEventViewController *eventVC = [[lxyEventViewController alloc] init];
    [self presentViewController:eventVC animated:YES completion:nil];
    [eventVC release];
}
#pragma mark 保存按钮事件
- (void)saveButtonAction:(UIButton *)sender
{
    NSArray *arr = self.diaryView.xinzhi.subviews;
    
    if (arr.count == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您还没在信纸上添加东西!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];
        [alertView release];

    } else if ([self.diaryView.title.text isEqualToString:@""]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您还未输入标题!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];
        [alertView release];
        
    }
    
    else {
        
        //让上面所有的框框的边框为0
        for (UIView *bor in arr) {
            bor.layer.borderWidth = 0;
        }
        
            //  隐藏涂鸦view的buttons
            self.tuyaView.cancleButton.hidden = YES;
            self.tuyaView.deleteButton.hidden = YES;
            
            
            //收回两边的边框
            //    self.toolView.hidden = YES;
            self.diaryView.toolBarView.alpha = 0;
            self.diaryView.rightToorBar.alpha = 0;
            self.toolView.alpha = 0;
            
            
            
            [_diaryView endEditing:YES];
            
            //currentView
            UIGraphicsBeginImageContext(self.view.frame.size);
            
            [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
            
            //截取全屏图片
            UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
            
            CGRect xinzhiFrame = self.diaryView.xinzhi.frame;
            CGRect titleFrame = self.diaryView.title.frame;
            CGRect contentFrame = Rect(xinzhiFrame.origin.x, MaxY(titleFrame), Width(xinzhiFrame) - 10,Height(xinzhiFrame) - 75);
            //在一个图片上截取指定大小位置的图片
            UIImage *img = [UIImage imageWithCGImage:CGImageCreateWithImageInRect(image.CGImage, contentFrame)];
            NSData *imageData = UIImagePNGRepresentation(img);
            
            NSString *time = [LYHelper getCurrentTime];
            
            //  拼接出存储路径
            NSString *imagePath = [KDocument stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", time]];
            [imageData writeToFile:imagePath atomically:YES];
            
            //将修改包装成对象插入到数据库表中
            _diary.diary_content = imagePath;
            _diary.diary_time = time;
            _diary.diary_title = self.diaryView.title.text;
            
            [lxyFunctionOfDataBase insertToTabel:@"diaryTable" withObject:_diary];
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"保存成功！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alertView show];
            [alertView release];
            
            //调用清屏按钮的方法
            for (UIView *view in self.diaryView.xinzhi.subviews) {
                [view removeFromSuperview];
            }
    
    }
    self.diaryView.title.text = @"";
}



#pragma mark 隐藏导航栏上方系统时间、电池显示
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark 初始化数组
- (void)initArrays
{
    //  工具框
    self.toolArray = @[@"duiqi", @"textColor", @"photo", @"tuya",@"background"];
    //    //  事件图标
    self.eventIconArray = @[@"event_icon0", @"event_icon1", @"event_icon2", @"event_icon3", @"event_icon4", @"event_icon5", @"event_icon6", @"event_icon7", @"event_icon8", @"event_icon9", @"event_icon10", @"event_icon11", @"event_icon11", @"event_icon12", @"event_icon13", @"event_icon14", @"event_icon15", @"event_icon16", @"event_icon17", @"event_icon18", @"event_icon19", @"event_icon20", @"event_icon21", @"event_icon29"];
    
}

#pragma mark 轻拍手势事件  收回键盘 和工具栏
- (void)tapGRAction:(UITapGestureRecognizer *)sender
{
    [self.diaryView endEditing:YES];
    

    if (self.topToolViewIsShow) {

        [self closeTopToolView];
    }
    
    if (self.leftToolViewIsShow) {
        [self closeLeftToolView];
    } else {
        [self showLeftToolView];
    }
    
    //  如果没有数据 右边的工具栏不会显示
    if (self.dictForTableView.count > 0) {
        if (self.rightToolViewIsShow) {
            [self closeTableView];
        } else {
            if (self.leftToolViewIsShow) {
                [self showTableView];
            }
        }
    }

    
}

//~~~~~~~~~~~~~~~~~~~~~~~键盘弹起与回收~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#pragma mark 监听键盘
- (void)viewWillAppear:(BOOL)animated
{
    //注册通知，监听键盘出现
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(handleKeyboardDidShow:)
                                                name:UIKeyboardDidShowNotification
                                              object:nil];
    //注册通知，监听键盘消失事件
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(handleKeyboardDidHidden)
                                                name:UIKeyboardDidHideNotification
                                              object:nil];
    [super viewWillAppear:animated];
    
    
    
}


-(void)viewDidAppear:(BOOL)animated
{
    WhatIsX(@"diary didappear");
}

#pragma mark 页面消失时释放观察者
-(void)viewWillDisappear:(BOOL)animated
{
    //解除键盘出现通知
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name: UIKeyboardDidShowNotification object:nil];
    //解除键盘隐藏通知
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name: UIKeyboardDidHideNotification object:nil];
    [super viewWillDisappear:animated];
    
}

#pragma mark 唤起键盘后事件
-(void)handleKeyboardDidShow:(NSNotification *)notification
{
    _isKeyBoardVisible = YES;
    
    NSArray *array = self.diaryView.xinzhi.subviews;
    for (int i = 0; i < array.count; i ++) {
        ((UIView *)[array objectAtIndex:i]).userInteractionEnabled = YES;
        if ([((UIView *)[array objectAtIndex:i]) isKindOfClass:[LYCustomTextField class]]) {
            ((LYCustomTextField *)[array objectAtIndex:i]).textView.editable = YES;
        }
    }
    
}
#pragma mark 收回键盘后事件  
-(void)handleKeyboardDidHidden
{
    _isKeyBoardVisible = NO;
    NSArray *array = self.diaryView.xinzhi.subviews;
    for (int i = 0; i < array.count; i ++) {
        ((UIView *)[array objectAtIndex:i]).userInteractionEnabled = YES;
        if ([((UIView *)[array objectAtIndex:i]) isKindOfClass:[LYCustomTextField class]]) {
            ((LYCustomTextField *)[array objectAtIndex:i]).textView.editable = YES;
        }
    }
    
}


//  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#pragma mark 选择eventIcon事件
- (void)buttonClicked:(UIButton *)sender
{
    self.dictForTableView = @{@"eventIcon":_eventIconArray};
    [_rightToorBar reloadData];
    [self showTableView];
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~工具框相关~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#pragma mark 工具按钮事件 弹出topToolView
- (void)toolButtonAction:(UIButton *)sender
{
    [self showTopToolView];
    
}
//  添加最上面总工具栏的按钮
- (void)addToolButtons
{
    for (int i = 0; i < _toolArray.count; i ++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake(10 * (i + 1) +  BTN_SIZE * i, 30, BTN_SIZE, BTN_SIZE);
        btn.tag = 20 + i;
        [btn setBackgroundImage:[UIImage imageNamed:_toolArray[i]] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(toolAction:) forControlEvents:UIControlEventTouchUpInside];
        [_toolView addSubview:btn];
    }
}
#pragma mark 收回topToolView
- (void)closeToolView:(UIButton *)sender
{
    [self closeTopToolView];
}

#pragma mark 弹出顶部工具栏
- (void)showTopToolView
{
    

    //  过渡动画
    CATransition *transition = [CATransition animation];
    //  设置动画时间
    transition.duration = 0.3;
    //  设置动画样式
    transition.type = @"moveIn";
    //  设置动画方法
    transition.subtype = kCATransitionFromBottom;
    self.toolView.alpha = 1.f;
    //  添加动画到views
    [self.toolView.layer addAnimation:transition forKey:@"transition"];
    
    self.topToolViewIsShow = YES;
}

#pragma mark 收回顶部工具栏
- (void)closeTopToolView
{//  过渡动画
    CATransition *transition = [CATransition animation];
    //  设置动画时间
    transition.duration = 0.3;
    //  设置动画样式
    transition.type = @"reveal";
    //  设置动画方法
    transition.subtype = kCATransitionFromTop;
    self.toolView.alpha = 0.f;
    //  添加动画到views
    [self.toolView.layer addAnimation:transition forKey:@"transition"];
    
    self.topToolViewIsShow = NO;
}
#pragma mark 生成左侧工具栏
- (void)toolAction:(UIButton *)sender
{

//    self.leftIsClicked = YES;
//    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(closeLeftToolView) userInfo:nil repeats:NO];
//    self.leftIsClicked = NO;
    
    switch (sender.tag) {
        case 20:
            [self selectView:@"文本" : [_textEditDict allKeys]];
            break;
        case 21:
            [self selectView:@"装饰" :  [_decoDict allKeys]];
            break;
        case 22:
            [self closeLeftToolView];
            [self closeTopToolView];
            [self closeTableView];
            [self tanchuSheet];
            break;
        case 23:
            [self closeLeftToolView];
            [self closeTopToolView];
            [self closeTableView];
            [self showTuyaView];
            break;
        case 24:
            [self selectView:@"背景" : [_bgDict allKeys]];
            break;
            
        default:
            break;
    }
    
    
}

#pragma mark 弹出左侧工具栏
- (void)showLeftToolView
{
   


    
    //  过渡动画
    CATransition *transition = [CATransition animation];
    //  设置动画时间
    transition.duration = 0.3;
    //  设置动画样式
    transition.type = @"moveIn";
    //  设置动画方法
    transition.subtype = kCATransitionFromLeft;
    self.diaryView.toolBarView.alpha = 1.f;
    //  添加动画到views
    [self.diaryView.toolBarView.layer addAnimation:transition forKey:@"transition"];
    
    self.leftToolViewIsShow = YES;
#warning 修改2
    
//     [NSTimer scheduledTimerWithTimeInterval:TIME2 target:self selector:@selector(closeLeftToolView) userInfo:nil repeats:NO];
    
}

#pragma mark 收回左侧工具栏
- (void)closeLeftToolView
{
    //  过渡动画
    CATransition *transition = [CATransition animation];
    //  设置动画时间
    transition.duration = 0.3;
    //  设置动画样式
    transition.type = @"moveIn";
    //  设置动画方法
    transition.subtype = kCATransitionFromRight;
    self.diaryView.toolBarView.alpha = 0.f;
    //  添加动画到views
    [self.diaryView.toolBarView.layer addAnimation:transition forKey:@"transition"];
    self.leftToolViewIsShow = NO;
}

#pragma mark 左侧工具栏添加点击事件
- (void)selectView:(NSString *)title : (NSArray *)array
{
    [self showLeftToolView];
    [self.diaryView.toolBarView setToolArray:array];
    if ([title isEqualToString:@"文本"]) {
        for (int i = 0; i < array.count; i ++) {
            UIButton *button = (UIButton *)[self.diaryView.toolBarView viewWithTag:100 + i];
            [button addTarget:self action:@selector(btnAction1:) forControlEvents:UIControlEventTouchUpInside];

        }
    }
    
    if ([title isEqualToString:@"装饰"]) {
        for (int i = 0; i < array.count; i ++) {
            [((UIButton *)[self.diaryView.toolBarView viewWithTag:100 + i]) addTarget:self action:@selector(btnAction2:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    if ([title isEqualToString:@"背景"]) {
        for (int i = 0; i < array.count; i ++) {
            [((UIButton *)[self.diaryView.toolBarView viewWithTag:100 + i]) addTarget:self action:@selector(btnAction3:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
}

- (void)eventIconSelect:(UIButton *)sender
{
    self.dictForTableView = @{@"eventIcon": _eventIconArray};
    [self.diaryView.rightToorBar reloadData];
    [self closeTopToolView];
    [self showTableView];
    
}
- (void)btnAction1:(UIButton *)sender
{
    NSString *key = _textEditDict.allKeys[sender.tag - 100];

    if (100 == sender.tag) {
        self.dictForTableView = @{@"textColor": [_textEditDict objectForKey:key]};
    }
    if (101 == sender.tag) {
        self.dictForTableView = @{@"textFieldStyle": [_textEditDict objectForKey:key]};
    }
    if (102 == sender.tag) {
        self.dictForTableView = @{@"fontStyle": [_textEditDict objectForKey:key]};
    }
    [self.diaryView.rightToorBar reloadData];
    [self closeTopToolView];
    [self showTableView];
    
}
- (void)btnAction2:(UIButton *)sender
{
    NSString *key = _decoDict.allKeys[sender.tag - 100];
    self.dictForTableView = @{@"deco": [_decoDict objectForKey:key]};
    [self.diaryView.rightToorBar reloadData];
    [self closeTopToolView];
    [self showTableView];
    
}
- (void)btnAction3:(UIButton *)sender
{
    NSString *key = _bgDict.allKeys[sender.tag - 100];
    //    self.subToolsViw.toolArray = [_decoDict objectForKey:key];
    self.dictForTableView = @{@"background": [_bgDict objectForKey:key]};
    [self.diaryView.rightToorBar reloadData];
    [self closeTopToolView];
    [self showTableView];
    
}
#pragma mark 弹出右侧子工具栏
- (void)showTableView
{
    

    //  过渡动画
    CATransition *transition = [CATransition animation];
    //  设置动画时间
    transition.duration = 0.3;
    //  设置动画样式
    transition.type = @"moveIn";
    //  设置动画方法
    transition.subtype = kCATransitionFromRight;
    self.diaryView.rightToorBar.alpha = 1.f;
    //  添加动画到views
    [self.diaryView.rightToorBar.layer addAnimation:transition forKey:@"transition"];
    self.rightToolViewIsShow = YES;
 }
#pragma mark 收回右侧子工具栏
- (void)closeTableView
{
    //  过渡动画
    CATransition *transition = [CATransition animation];
    //  设置动画时间
    transition.duration = 0.3;
    //  设置动画样式
    transition.type = @"moveIn";
    //  设置动画方法
    transition.subtype = kCATransitionFromLeft;
    self.diaryView.rightToorBar.alpha = 0.f;
    //  添加动画到views
    [self.diaryView.rightToorBar.layer addAnimation:transition forKey:@"transition"];
    self.rightToolViewIsShow = NO;
    
}


// ~~~~~~~~~~~~~~~~~~~~tableView代理事件~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#pragma mark - tableView代理事件
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.dictForTableView.count == 0) {
        return 0;
    } else {
        
        NSString *key = [_dictForTableView allKeys][0];
        return [_dictForTableView[key] count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cell_id = @"cell_id";
    LYCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (cell == nil) {
        cell = [[[LYCustomCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cell_id] autorelease];
    }
    NSString *key = [_dictForTableView allKeys][0];
    NSArray *array = _dictForTableView[key];
    cell.image.image = [UIImage imageNamed:array[indexPath.row]];
    
    if ([key isEqualToString:@"textColor"]) {
      cell.image.backgroundColor = [self getColorWithString:array[indexPath.row]];
    } else {
        cell.image.backgroundColor = myGray;
    }

    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = [_dictForTableView allKeys][0];
    NSArray *array = _dictForTableView[key];
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:array[indexPath.row] ofType:@"png"];
    if ([key isEqualToString:@"fontStyle"]) {
        
        NSMutableArray *arr = [NSMutableArray array];
        
        NSInteger III = 0;
        
            for (UIView *VIEW in self.diaryView.xinzhi.subviews) {
                
                if ([VIEW isKindOfClass:[LYCustomTextField class]]) {
                    
                    if (VIEW.layer.borderWidth == .8f) {
                        
                        [arr addObject:VIEW];
                        
                        III ++;
                    }
                } else {
                    
                    if ([VIEW isKindOfClass:[LYTuyaView class]]) {
                        ;
                    } else {
                        UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择要编辑的文本框来修改字体" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                        [aler show];
                        [aler release];
                    }
                    
                }
                
                III ++;
            }
        
        
        
        if (arr.count == 0) {
            
            if (III == 0) {
                UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"对不起，该页面上还没有东西呢" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [aler show];
                [aler release];
            } else {

            UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择要编辑的文本框来修改字体" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [aler show];
            [aler release];
            }
        } else {
            for (UIView *VIEW in arr) {
                if (![((LYCustomTextField *)VIEW).textView.text isEqualToString:@""]) {

                    ((LYCustomTextField *)VIEW).textView.font = [UIFont fontWithName:array[indexPath.row] size:20.f];
                } else {
                    UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"对不起，您选中的文本框没有文字！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                    [aler show];
                    [aler release];

                }
            }
        }

    }
    
    
    if ([key isEqualToString:@"textColor"]) {
        
        NSMutableArray *arr = [NSMutableArray array];
        
        NSInteger III = 0;
        
        for (UIView *VIEW in self.diaryView.xinzhi.subviews) {
            
            if ([VIEW isKindOfClass:[LYCustomTextField class]]) {
                
                if (VIEW.layer.borderWidth == .8f) {
                    
                    [arr addObject:VIEW];
                    
                    III ++;
                }
            } else {
                UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择要编辑的文本框来修改文字的颜色" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [aler show];
                [aler release];
            }
            
            III ++;
        }
        
        
        
        if (arr.count == 0) {
            
            if (III == 0) {
                UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"对不起，该页面上还没有东西呢" delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
                [aler show];
                [aler release];
            } else {
                
                UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择要编辑的文本框来修改文字的颜色" delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
                [aler show];
                [aler release];
            }
        } else {
            for (UIView *VIEW in arr) {
                
                if (![((LYCustomTextField *)VIEW).textView.text isEqualToString:@""]) {
                    
                    ((LYCustomTextField *)VIEW).textView.textColor = [self getColorWithString:array[indexPath.row]];
                } else {
                    UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"对不起，您选中的文本框没有文字！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                    [aler show];
                    [aler release];
                    
                }

                
            }
        }
    }
    
    if ([key isEqualToString:@"background"]) {
        UIImage *image = [[UIImage alloc] initWithContentsOfFile:imagePath];
        self.diaryView.xinzhi.image = image;
        [image release];
    }
    
    if ([key isEqualToString:@"eventIcon"]) {
        [self.diaryView.weatherBtn setBackgroundImage:[UIImage imageNamed:array[indexPath.row]] forState:UIControlStateNormal];
        self.diary.diary_icon = imagePath;
    }
    
}

- (UIColor *)getColorWithString:(NSString *)str
{
    if ([str isEqualToString:@"myGreen"]) {
        return myGreen;
    }
    
    if ([str isEqualToString:@"myPink"]) {
        return myPink;
    }
    
    if ([str isEqualToString:@"myYellow"]) {
        return myYellow;
    }
    if ([str isEqualToString:@"myBlue"]) {
        return myBlue;
    }
    
    if ([str isEqualToString:@"myGray"]) {
        return myGray;
    }
    if ([str isEqualToString:@"myRed"]) {
        return myRed;
    }
    if ([str isEqualToString:@"myBrown"]) {
        return myBrown;
    }
    if ([str isEqualToString:@"myDian"]) {
        return myDian;
    }
    return [UIColor blackColor];

}
#pragma mark tableViewCell长按手势
- (void)longPressGR:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        NSLog(@"UIGestureRecognizerStateBegan");
        CGPoint ponit=[gestureRecognizer locationInView:self.diaryView.rightToorBar];
        
//        // 以信纸作为坐标
//        CGPoint ponit2=[gestureRecognizer locationInView:self.diaryView.xinzhi];
        
        NSIndexPath* path=[self.diaryView.rightToorBar indexPathForRowAtPoint:ponit];
//        NSLog(@"row:%d",path.row);
        
        NSString *key = [_dictForTableView allKeys][0];
        NSArray *array = _dictForTableView[key];
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:array[path.row] ofType:@"png"];
        if ([key isEqualToString:@"deco"]) {
            UIImage *image = [[UIImage alloc] initWithContentsOfFile:imagePath];
//            YCjiePingView *view = [[YCjiePingView alloc] initWithFrame:Rect(100, 100, 50, 50)];
//            LYCustomTextField *view1 = [[LYCustomTextField alloc] initWithFrame:Rect(100, 100, 50, 50)];
            LYCustomTextField *view1 = [[LYCustomTextField alloc] init];
            [view1 setFrame:Rect(100, 100, 50, 50)];
            view1.contentMode = UIViewContentModeScaleAspectFit;
            view1.image = image;
            [image release];
            [self.diaryView.xinzhi addSubview:view1];
            [view1 release];
        }
        
        if ([key isEqualToString:@"textFieldStyle"]) {
              UIImage *image = [[UIImage alloc] initWithContentsOfFile:imagePath];
            LYCustomTextField *textField = [[LYCustomTextField alloc] initWithFrame:Rect(100, 100, 150, 100)];
            textField.textView.delegate = self;
            textField.image = image;
//            [image release];
            [self.diaryView.xinzhi addSubview:textField];
            [textField release];
            
        }
#warning 修改2
        
//        self.rightIsClicked = YES;
//        [NSTimer scheduledTimerWithTimeInterval:TIME2 target:self selector:@selector(closeTableView) userInfo:nil repeats:NO];
//        self.rightIsClicked = NO;
        
        
    }else if(gestureRecognizer.state == UIGestureRecognizerStateEnded)
    {
        //未用
    }
    else if(gestureRecognizer.state == UIGestureRecognizerStateChanged)
    {
        //未用
    }
}

-(BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSString * toBeString = [textView.text stringByReplacingCharactersInRange:range withString:text]; //得到输入框的内容
    
    if ([toBeString length] > 30) { //如果输入框内容大于20则弹出警告
        textView.text = [toBeString substringToIndex:30];
        if (0 == alerIndex) {
            UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"输入长度不能超过30个字符" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [aler show];
            [aler release];
        }
        alerIndex ++;
        return NO;
    }
    
    return YES;
}

//-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
//{
//    textView.text = @"";
//    textView.textColor = [UIColor blackColor];
//    return YES;
//}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            alerIndex = 0;
            break;
            
        default:
            break;
    }
}


#pragma mark 弹出涂鸦视图
- (void)showTuyaView
{
    self.tuyaView = [[[LYTuyaView alloc] initWithFrame:CGRectMake(11, 36, self.diaryView.xinzhi.frame.size.width - 22, self.diaryView.xinzhi.frame.size.height - 70)] autorelease];
    _tuyaView.backgroundColor = [UIColor orangeColor];
    _tuyaView.backgroundColor = [UIColor clearColor];
    _tuyaView.layer.borderColor = [[UIColor redColor] CGColor];
    _tuyaView.layer.borderWidth = 1.f;
    [self.diaryView.xinzhi addSubview:_tuyaView];
    
//    [_tuyaBan.saveButton addTarget:self action:@selector(tuyaSave:) forControlEvents:UIControlEventTouchUpInside];
    [_tuyaView.cancleButton addTarget:self action:@selector(tuyaCancle:) forControlEvents:UIControlEventTouchUpInside];
    [_tuyaView.deleteButton addTarget:self action:@selector(tuyaDelete:) forControlEvents:UIControlEventTouchUpInside];
//    [_tuyaBan.editButton addTarget:self action:@selector(tuyaEdit:) forControlEvents:UIControlEventTouchUpInside];
    
//    LYTuyaView *tuyaView = [[LYTuyaView alloc] initWithFrame:Rect(100, 100, 120, 100)];
//    tuyaView.backgroundColor = myBlue;
//    [self.diaryView.xinzhi addSubview:tuyaView];
//    [tuyaView release];
}

- (void)tuyaSave:(UIButton *)sender
{
    LYTuyaBan *ban = (LYTuyaBan *)[sender superview];
    ban.tuyaView.userInteractionEnabled = NO;
    ban.cancleButton.hidden = YES;
    ban.saveButton.hidden = YES;
    ban.deleteButton.hidden = YES;
    ban.editButton.hidden = NO;
    
    
}

- (void)tuyaCancle:(UIButton *)sender
{
    [[sender superview] removeFromSuperview];
    
}
- (void)tuyaDelete:(UIButton *)sender
{
//    LYTuyaBan *ban = (LYTuyaBan *)[sender superview];
    [self.tuyaView.lineArray removeLastObject];
    [_tuyaView setNeedsDisplay];
}
- (void)tuyaEdit:(UIButton *)sender
{
    LYTuyaBan *ban = (LYTuyaBan *)[sender superview];
    ban.tuyaView.userInteractionEnabled = YES;
    ban.editButton.hidden = YES;
    ban.cancleButton.hidden = NO;
    ban.saveButton.hidden = NO;
    ban.deleteButton.hidden = NO;

}

//————————————————————————————————————————————————uiactionSheet的监听事件————————————————————————————————————————————————————————
#pragma mark 关于照相功能
//弹出sheet
- (void)tanchuSheet
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"选择方式" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"照相机" , @"图库" , @"截屏", nil];
    [sheet showInView:self.view];
    
}
//sheet中每个button按钮的监听事件
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    switch (buttonIndex) {
        case 0:
        {
            //选择照相机
            [self selectCamera];
        }
            break;
            case 1:
        {
            //调用图库方法
            [self selectPhoto];
        }
            break;
            case 2:
        {
            //调用截屏方法
            [self jiepingFunction];
        }
            break;
        default:
            break;
    }
}
//选择照相机的方法
- (void)selectCamera
{
    //判断是否可以打开相机，模拟器没有此功能，无法使用
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;     //是否可以编辑
        
        //获取摄像头
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:nil];
        [picker release];
    } else {
        //如果没有的话要提示用户
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"没有照相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
}
//调用图库方法
- (void)selectPhoto
{
    //相册是可以用模拟器打开的
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;         //是否可以编辑
        
        //打开相册选择图片
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:nil];
        [picker release];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"没有相册" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //得到图片
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    image = [LYHelper OriginImage:image scaleToSize:CGSizeMake(100, image.size.height / image.size.width * 100)];
    
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

    [self dismissViewControllerAnimated:YES completion:nil];
    YCjiePingView *photoImageView = [[YCjiePingView alloc] initWithFrame:Rect(100, 200, 100, 100)];
    photoImageView.image = image;
    photoImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.diaryView.xinzhi addSubview:photoImageView];
    [photoImageView release];
}

//调用截屏方法
- (void)jiepingFunction
{
    _jiepingImageView.hidden = NO;
    _finishButton.hidden = NO;
    _cancelButton.hidden = NO;
    i = 1;
}
//截屏上finish按钮的监听方法
- (void)finishButtonAction:(UIButton *)sender
{
    _finishButton.hidden = YES;
    _jiepingImageView.hidden = YES;
    _cancelButton.hidden = YES;
    i = 0;
    _frame = _jiepingImageView.frame;
    
    //currentView
    UIGraphicsBeginImageContext(self.view.frame.size);
    
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    //截取全屏图片
    
    @autoreleasepool {
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();

        //在一个图片上截取指定大小位置的图片
        UIImage *img = [UIImage imageWithCGImage:CGImageCreateWithImageInRect(image.CGImage, _frame)];
        
        //img就是获取的截图，如果要讲图片存入相册，只需在后面调用下面的语句
        UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil);
    }

    
    UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"添加成功" message:@"图片已存到相册" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [aler show];
    [aler release];
}
//截屏上cancel按钮的监听方法
- (void)cancelButtonAction:(UIButton *)sender
{
    _cancelButton.hidden = YES;
    _finishButton.hidden = YES;
    _jiepingImageView.hidden = YES;
}
//alertView的代理方法
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    switch (buttonIndex) {
//        case 0:
//            ;
//            break;
//            
//        default:
//            break;
//    }
//}


//touch begin
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    self.beginPoint = [touch locationInView:self.view];
    
    self.beginX = _beginPoint.x;
    self.beginY = _beginPoint.y;
}
//touch moving
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (i == 1) {
        CGFloat touchX = _beginPoint.x;
        CGFloat touchY = _beginPoint.y;
        
        CGFloat hengX1 = _jiepingImageView.frame.origin.x +5;    //上边框横坐标的起点
        CGFloat hengX2 = _jiepingImageView.frame.origin.x + _jiepingImageView.frame.size.width - 5;   //上边框横坐标的终点
        
        CGFloat shuY1 = _jiepingImageView.frame.origin.y + 5;     //左边框纵坐标的起点
        CGFloat shuY2 = _jiepingImageView.frame.origin.y + _jiepingImageView.frame.size.height - 5;  //左边框纵坐标的终点
        
        //上边框的上下范围
        CGFloat shangY1 = _jiepingImageView.frame.origin.y - 5;
        CGFloat shangY2 = _jiepingImageView.frame.origin.y + 5;
        //下边框的上下范围
        CGFloat xiaY1 = _jiepingImageView.frame.origin.y + _jiepingImageView.frame.size.height - 5;
        CGFloat xiaY2 = _jiepingImageView.frame.origin.y + _jiepingImageView.frame.size.height + 5;
        
        //左边框的左右范围
        CGFloat zuoX1 = _jiepingImageView.frame.origin.x - 5;
        CGFloat zuoX2 = _jiepingImageView.frame.origin.x + 5;
        //右边框的左右范围
        CGFloat youX1 = _jiepingImageView.frame.origin.x + _jiepingImageView.frame.size.width - 5;
        CGFloat youX2 = _jiepingImageView.frame.origin.x + _jiepingImageView.frame.size.width + 5;
        
        
        //如果触摸点在上下边框上
        if((touchX > hengX1 && touchX < hengX2))
        {
            //在上边框上
            if(touchY > shangY1 && touchY < shangY2)
            {
                UITouch *touch = [touches anyObject];
                CGPoint point = [touch locationInView:self.view];
                CGFloat nowY = point.y;
                CGFloat beginY;
                beginY = _beginPoint.y;
                CGFloat height = nowY - beginY;
                CGRect frame = _jiepingImageView.frame;
                frame.origin.y = frame.origin.y + height;
                frame.size.height = frame.size.height - height;
                _jiepingImageView.frame = frame;
                _finishButton.frame = CGRectMake(_jiepingImageView.frame.origin.x + _jiepingImageView.frame.size.width, _jiepingImageView.frame.origin.y - 20, 20, 20);
                _cancelButton.frame = CGRectMake(_jiepingImageView.frame.origin.x - 20, _jiepingImageView.frame.origin.y - 20, 20, 20);
                _beginPoint = point;
                
            }
            
            //在下边框上
            if (touchY > xiaY1 && touchY < xiaY2) {
                CGFloat beginY = _beginPoint.y;
                UITouch *touch = [touches anyObject];
                CGPoint point = [touch locationInView:self.view];
                CGFloat nowY = point.y;
                CGFloat height = nowY - beginY;
                CGRect frame = _jiepingImageView.frame;
                frame.size.height = frame.size.height + height;
                _jiepingImageView.frame = frame;
                _finishButton.frame = CGRectMake(_jiepingImageView.frame.origin.x + _jiepingImageView.frame.size.width, _jiepingImageView.frame.origin.y - 20, 20, 20);
                _cancelButton.frame = CGRectMake(_jiepingImageView.frame.origin.x - 20, _jiepingImageView.frame.origin.y - 20, 20, 20);
                _beginPoint = point;
            }
        }
        
        
        
        //如果触摸点在左右边框
        if(touchY > shuY1 && touchY < shuY2)
        {
            //在左边框上
            if(touchX > zuoX1 && touchX < zuoX2)
            {
                UITouch *touch = [touches anyObject];
                CGPoint point = [touch locationInView:self.view];
                CGFloat beginX = _beginPoint.x;
                CGFloat nowX = point.x;
                CGFloat width = nowX - beginX;
                CGRect frame = _jiepingImageView.frame;
                frame.origin.x = frame.origin.x + width;
                frame.size.width = frame.size.width - width;
                _jiepingImageView.frame = frame;
                _finishButton.frame = CGRectMake(_jiepingImageView.frame.origin.x + _jiepingImageView.frame.size.width, _jiepingImageView.frame.origin.y - 20, 20, 20);
                _cancelButton.frame = CGRectMake(_jiepingImageView.frame.origin.x - 20, _jiepingImageView.frame.origin.y - 20, 20, 20);
                _beginPoint = point;
                
            }
            
            //在右边框上
            if(touchX > youX1 && touchX < youX2)
            {
                CGFloat beginX = _beginPoint.x;
                UITouch *touce = [touches anyObject];
                CGPoint point = [touce locationInView:self.view];
                CGFloat nowX = point.x;
                CGFloat width = nowX - beginX;
                CGRect frame = _jiepingImageView.frame;
                frame.size.width = frame.size.width + width;
                _jiepingImageView.frame = frame;
                _finishButton.frame = CGRectMake(_jiepingImageView.frame.origin.x + _jiepingImageView.frame.size.width, _jiepingImageView.frame.origin.y - 20, 20, 20);
                _cancelButton.frame = CGRectMake(_jiepingImageView.frame.origin.x - 20, _jiepingImageView.frame.origin.y - 20, 20, 20);
                _beginPoint = point;
            }
        }
        
        
        //左上角范围
        CGFloat zuoshangX1 = _jiepingImageView.frame.origin.x - 5;
        CGFloat zuoshangX2 = _jiepingImageView.frame.origin.x + 5;
        CGFloat zuoshangY1 = _jiepingImageView.frame.origin.y - 5;
        CGFloat zuoshangY2 = _jiepingImageView.frame.origin.y + 5;
        
        //如果触摸点在左上角
        if (touchX > zuoshangX1 && touchX < zuoshangX2) {
            if(touchY > zuoshangY1 && touchY < zuoshangY2)
            {
                CGFloat beginX = _beginPoint.x;
                CGFloat beginY = _beginPoint.y;
                
                UITouch *touch = [touches anyObject];
                CGPoint point = [touch locationInView:self.view];
                
                CGFloat nowX = point.x;
                CGFloat nowY = point.y;
                
                CGFloat width = nowX - beginX;
                CGFloat height = nowY - beginY;
                
                CGRect frame = _jiepingImageView.frame;
                frame.origin.x = frame.origin.x + width;
                frame.size.width = frame.size.width - width;
                frame.origin.y = frame.origin.y + height;
                frame.size.height = frame.size.height - height;
                
                _jiepingImageView.frame = frame;
                _finishButton.frame = CGRectMake(_jiepingImageView.frame.origin.x + _jiepingImageView.frame.size.width, _jiepingImageView.frame.origin.y - 20, 20, 20);
                _cancelButton.frame = CGRectMake(_jiepingImageView.frame.origin.x - 20, _jiepingImageView.frame.origin.y - 20, 20, 20);
                _beginPoint = point;
                
            }
        }
        
        
        //右上角范围
        CGFloat youshangX1 = _jiepingImageView.frame.origin.x + _jiepingImageView.frame.size.width - 5;
        CGFloat youshangX2 = _jiepingImageView.frame.origin.x + _jiepingImageView.frame.size.width + 5;
        CGFloat youshangY1 = zuoshangY1;
        CGFloat youshangY2 = zuoshangY2;
        
        //如果触摸点在右上角
        if(touchX > youshangX1 && touchX < youshangX2)
        {
            if (touchY > youshangY1 && touchY < youshangY2) {
                
                CGFloat beginX = _beginPoint.x;
                CGFloat beginY = _beginPoint.y;
                
                UITouch *touch = [touches anyObject];
                CGPoint point = [touch locationInView:self.view];
                
                CGFloat nowX = point.x;
                CGFloat nowY = point.y;
                
                CGFloat width = nowX - beginX;
                CGFloat height = nowY - beginY;
                
                CGRect frame = _jiepingImageView.frame;
                
                frame.size.width = frame.size.width + width;
                frame.origin.y = frame.origin.y + height;
                frame.size.height = frame.size.height - height;
                
                _jiepingImageView.frame = frame;
                _finishButton.frame = CGRectMake(_jiepingImageView.frame.origin.x + _jiepingImageView.frame.size.width, _jiepingImageView.frame.origin.y - 20, 20, 20);
                _cancelButton.frame = CGRectMake(_jiepingImageView.frame.origin.x - 20, _jiepingImageView.frame.origin.y - 20, 20, 20);
                _beginPoint = point;
                
            }
        }
        
        
        //左下角范围
        CGFloat zuoxiaX1 = zuoshangX1;
        CGFloat zuoxiaX2 = zuoshangX2;
        CGFloat zuoxiaY1 = _jiepingImageView.frame.origin.y + _jiepingImageView.frame.size.height - 5;
        CGFloat zuoxiaY2 = _jiepingImageView.frame.origin.y + _jiepingImageView.frame.size.height + 5;
        
        //如果触摸点在左下角
        if(touchX > zuoxiaX1 && touchX < zuoxiaX2)
        {
            if (touchY > zuoxiaY1 && touchY < zuoxiaY2) {
                
                CGFloat beginX = _beginPoint.x;
                CGFloat beginY = _beginPoint.y;
                
                UITouch *touch = [touches anyObject];
                CGPoint point = [touch locationInView:self.view];
                
                CGFloat nowX = point.x;
                CGFloat nowY = point.y;
                
                CGFloat width = nowX - beginX;
                CGFloat height = nowY - beginY;
                
                CGRect frame = _jiepingImageView.frame;
                
                frame.origin.x = frame.origin.x + width;
                frame.size.width = frame.size.width - width;
                frame.size.height = frame.size.height + height;
                
                _jiepingImageView.frame = frame;
                _finishButton.frame = CGRectMake(_jiepingImageView.frame.origin.x + _jiepingImageView.frame.size.width, _jiepingImageView.frame.origin.y - 20, 20, 20);
                _cancelButton.frame = CGRectMake(_jiepingImageView.frame.origin.x - 20, _jiepingImageView.frame.origin.y - 20, 20, 20);
                _beginPoint = point;
            }
        }
        
        
        //右下角范围
        CGFloat youxiaX1 = youshangX1;
        CGFloat youxiaX2 = youshangX2;
        CGFloat youxiaY1 = zuoxiaY1;
        CGFloat youxiaY2 = zuoxiaY2;
        
        //如果触摸点在右下角
        if (touchX > youxiaX1 && touchX < youxiaX2) {
            if (touchY > youxiaY1 && touchY < youxiaY2) {
                
                CGFloat beginX = _beginPoint.x;
                CGFloat beginY = _beginPoint.y;
                
                UITouch *touch = [touches anyObject];
                CGPoint point = [touch locationInView:self.view];
                
                CGFloat nowX = point.x;
                CGFloat nowY = point.y;
                
                CGFloat width = nowX - beginX;
                CGFloat height = nowY - beginY;
                
                CGRect frame = _jiepingImageView.frame;
                
                frame.size.width = frame.size.width + width;
                frame.size.height = frame.size.height + height;
                
                _jiepingImageView.frame = frame;
                _finishButton.frame = CGRectMake(_jiepingImageView.frame.origin.x + _jiepingImageView.frame.size.width, _jiepingImageView.frame.origin.y - 20, 20, 20);
                _cancelButton.frame = CGRectMake(_jiepingImageView.frame.origin.x - 20, _jiepingImageView.frame.origin.y - 20, 20, 20);
                _beginPoint = point;
            }
        }
        
        
        
        
        //如果触摸在中间位置
        CGFloat midX1 = _jiepingImageView.frame.origin.x + 10;
        CGFloat midX2 = _jiepingImageView.frame.origin.x + _jiepingImageView.frame.size.width - 10;
        CGFloat midY1 = _jiepingImageView.frame.origin.y + 10;
        CGFloat midY2 = _jiepingImageView.frame.origin.y + _jiepingImageView.frame.size.height - 10;
        
        if (touchX > midX1 && touchX < midX2) {
            if (touchY > midY1 && touchY < midY2) {
                
                CGFloat beginX = _beginPoint.x;
                CGFloat beginY = _beginPoint.y;
                
                UITouch *touch = [touches anyObject];
                CGPoint point = [touch locationInView:self.view];
                
                CGFloat nowX = point.x;
                CGFloat nowY = point.y;
                
                CGFloat width = nowX - beginX;
                CGFloat height = nowY - beginY;
                
                CGRect frame = _jiepingImageView.frame;
                
                frame.origin.x = frame.origin.x + width;
                frame.origin.y = frame.origin.y +height;
                
                _jiepingImageView.frame = frame;
                _finishButton.frame = CGRectMake(_jiepingImageView.frame.origin.x + _jiepingImageView.frame.size.width, _jiepingImageView.frame.origin.y - 20, 20, 20);
                _cancelButton.frame = CGRectMake(_jiepingImageView.frame.origin.x - 20, _jiepingImageView.frame.origin.y - 20, 20, 20);
                _beginPoint = point;
            }
        }
        
    }
}

//——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————

#pragma mark - Return
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.diaryView.title resignFirstResponder];
    return YES;
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
