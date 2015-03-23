//
//  lxySettingViewController.m
//  SettingView
//
//  Created by 刘翔宇 on 14-6-22.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "lxySettingViewController.h"
#import "lxySettingView.h"
//#import "lxyDataBase.h"   X
#import "lxyUserTableModel.h"

#import "lxyIntroduceViewController.h"

#define alerViewTag 200
#define setViewTag 201
//设置密码事件中两个textfield的tag值
#define mimaText 202
#define againMima 203

//修改密码事件中两个textField的tag值
#define yuanMima 204
#define xinMima 205

//修改页面上保存按钮的tag值
#define alertBaoCun 206

@interface lxySettingViewController ()<UIGestureRecognizerDelegate , UITextFieldDelegate , UIAlertViewDelegate>
{
    
    
    
    NSInteger i;
}


@property (nonatomic, retain)UILabel *originPwdLbl;
@property (nonatomic, retain)UITextField *originPwd;
@property (nonatomic, retain)UIButton *originPwdOkButton;
@end

NSInteger switchIndex = 0;
NSInteger flag = 0;

@implementation lxySettingViewController

- (void)dealloc
{
    [_stView release];
    [_oldPwdLabel release];
    [_oldPwdText release];
    [_newPwdLabel release];
    [_newPwdText release];
    [_concelBtn release];
    [_concelBtn release];
    [_alertPwdView release];
    [_setPwdView release];
    
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
    self.stView = [[[lxySettingView alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.view = _stView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    //根据数据库中的是否有密码来设置该开关的状态
    [self setSwitchStatus];
    //密码开关监听事件
    [_stView.pwdSwitch addTarget:self action:@selector(pwdSwitchAction:) forControlEvents:UIControlEventValueChanged];
    [self setSwitchStatus];
    
    //修改密码按钮监听事件
    [_stView.alertPwdBtn addTarget:self action:@selector(alertPwdBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //设置密码按钮监听事件
//    [_stView.setPwdBtn addTarget:self action:@selector(setPwdBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //备份按钮监听事件
    [_stView.backUpBtn addTarget:self action:@selector(backUpBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //轻怕屏幕的代理方法
    _stView.tap.delegate = self;
    [_stView.tap addTarget:self action:@selector(tapAction:)];
    
    //  新手指引
    [self.stView.aboutButton addTarget:self action:@selector(aboutButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark - 新手指引
- (void)aboutButtonAction:(UIButton *)sender
{
    lxyIntroduceViewController *introduceVC = [[[lxyIntroduceViewController alloc] init] autorelease];
    [self presentViewController:introduceVC animated:YES completion:nil];
}

#pragma mark -根据数据库中是否有密码来设置switch开关的状态
- (void)setSwitchStatus
{
    if (100 == switchIndex) {
        switchIndex = 1;
    }
    
    //先从数据库中取出数据并放到数组中
//    NSMutableArray *dataArray = [[[NSMutableArray alloc] init] autorelease];
//    NSMutableArray *dataArray = [NSMutableArray array];
    NSMutableArray *dataArray = nil;
    dataArray = [[lxyDataBase shareLxyDataBase] searchAllDataFromUserTable];
    //判断该数组中有没有数据
    if (0 == dataArray.count) {     //如果数组中没有数据
        [_stView.pwdSwitch setOn:NO];
        //显示设置密码按钮
        if (0 == switchIndex) {
//            _stView.setPwdBtn.hidden = NO;
            _stView.pwdSwitch.userInteractionEnabled = YES;
        } else {
//            _stView.setPwdBtn.hidden = YES;
        }
        //隐藏修改密码按钮
        _stView.alertPwdBtn.hidden = YES;
    } else{                         //数组中有数据
        //判断密码是否为空
        lxyUserTableModel *modle = nil;
        modle = [dataArray objectAtIndex:0];
        NSString *mima = modle.user_pwd;
        if ([mima isEqualToString:@"(null)"]) {
            [_stView.pwdSwitch setOn:NO];
            //显示设置密码按钮
            if (0 == switchIndex) {
//                _stView.setPwdBtn.hidden = NO;
                _stView.pwdSwitch.userInteractionEnabled = YES;
            } else {
//                _stView.setPwdBtn.hidden = YES;
            }
            //隐藏修改密码按钮
            _stView.alertPwdBtn.hidden = YES;
        } else {
            //显示修改密码按钮
            _stView.alertPwdBtn.hidden = NO;
            //隐藏设置密码按钮
//            _stView.setPwdBtn.hidden = YES;
            _stView.pwdSwitch.userInteractionEnabled = YES;
            _stView.pwdSwitch.on = YES;
        }
    }
}

#pragma mark -轻拍手势的监听事件
//轻怕手势的监听事件
- (void)tapAction:(UITapGestureRecognizer *)sender
{
    [_oldPwdText resignFirstResponder];
    [_newPwdText resignFirstResponder];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.5];
    if (1 == i) {
        _alertPwdView.frame = CGRectMake(50, 173, 280, 180);
    }
    if (2 == i) {
        _setPwdView.frame = CGRectMake(50, 173, 280, 180);
    }
    [UIView commitAnimations];
}

#pragma mark -床架label的方法
//创建label方法
- (UILabel *)createLabelWithName:(NSString *)name
                        andFrame:(CGRect)frame
{
    UILabel *label = [[[UILabel alloc] initWithFrame:frame] autorelease];
    label.text = name;
    label.font = [UIFont fontWithName:@"LiDeBiao-Xing-3.0" size:17.f];
    return label;
}

#pragma mark -创建text的方法
//创建text方法
- (UITextField *)createTextFieldWithName:(NSString *)name
                                andFrame:(CGRect)frame
{
    UITextField *text = [[[UITextField alloc] initWithFrame:frame] autorelease];
    text.placeholder = name;
    text.borderStyle = UITextBorderStyleRoundedRect;
    text.font = [UIFont fontWithName:@"LiDeBiao-Xing-3.0" size:17.f];
    return text;
}

#pragma mark -创建button的方法
//创建button方法
- (UIButton *)createButtonWithName:(NSString *)name
                    andFrame:(CGRect)frame
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = frame;
    [button setTitle:name forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont fontWithName:@"LiDeBiao-Xing-3.0" size:17.f];
    return button;
}

#pragma mark -创建修改密码的view
//创建修改密码的view
- (UIView *)createAlerPwdView
{
    self.alertPwdView = [[[UIView alloc] initWithFrame:CGRectMake(50, 173, 280, 180)] autorelease];
    _alertPwdView.tag = alerViewTag;
    
    
    UIImage *img = [[[UIImage alloc] init] autorelease];
    UIImageView *imgView = [[[UIImageView alloc] initWithImage:img] autorelease];
    imgView.frame = CGRectMake(30, 0, _alertPwdView.frame.size.width - 60, _alertPwdView.frame.size.height / 3);
    
    //创建原密码label
    self.oldPwdLabel = [self createLabelWithName:@"原密码" andFrame:CGRectMake(imgView.frame.origin.x, imgView.frame.origin.y + imgView.frame.size.height - 35, 60, 30)];
    self.oldPwdLabel.tintColor = [UIColor whiteColor];
    [_alertPwdView addSubview:_oldPwdLabel];
    
    //创建原密码text
    self.oldPwdText = [self createTextFieldWithName:@"请输入原密码" andFrame:CGRectMake(_oldPwdLabel.frame.origin.x + _oldPwdLabel.frame.size.width, _oldPwdLabel.frame.origin.y, _oldPwdLabel.frame.origin.x + _oldPwdLabel.frame.size.width + 70, _oldPwdLabel.frame.size.height)];
    _oldPwdText.tag = yuanMima;     //text的tag值
    _oldPwdText.keyboardType = UIKeyboardTypeNumberPad;     //键盘类型
    [_alertPwdView addSubview:_oldPwdText];
    
    //创建新密码label
    self.newPwdLabel = [self createLabelWithName:@"新密码" andFrame:CGRectMake(_oldPwdLabel.frame.origin.x, _oldPwdLabel.frame.origin.y + _oldPwdLabel.frame.size.height + 5, _oldPwdLabel.frame.size.width, _oldPwdLabel.frame.size.height)];
    _newPwdLabel.tintColor = [UIColor whiteColor];
    [_alertPwdView addSubview:_newPwdLabel];
    
    //创建新密码text
    self.newPwdText = [self createTextFieldWithName:@"请输入新密码" andFrame:CGRectMake(_oldPwdText.frame.origin.x, _oldPwdText.frame.origin.y + _oldPwdText.frame.size.height + 5, _oldPwdText.frame.size.width, _oldPwdText.frame.size.height)];
    _newPwdText.tag = xinMima;              //text的tag值
    _newPwdText.keyboardType = UIKeyboardTypeNumberPad;     //键盘类型
    [_newPwdText setEnabled:NO];            //初始化新密码框不能编辑
    [_alertPwdView addSubview:_newPwdText];
    
    //创建保存按钮
    self.confirmBtn = [self createButtonWithName:@"保存" andFrame:CGRectMake(_newPwdLabel.frame.origin.x, _newPwdLabel.frame.origin.y + _newPwdLabel.frame.size.height + 5, 60, _newPwdLabel.frame.size.height)];
    _concelBtn.tag = alertBaoCun;
    self.confirmBtn.tintColor = [UIColor orangeColor];
    [_alertPwdView addSubview:_confirmBtn];
    
    //创建取消按钮
    self.concelBtn = [self createButtonWithName:@"取消" andFrame:CGRectMake(_newPwdText.frame.origin.x, _newPwdText.frame.origin.y + _newPwdText.frame.size.height + 5, 60, _newPwdText.frame.size.height)];
    [_alertPwdView addSubview:_concelBtn];
    self.concelBtn.tintColor = [UIColor orangeColor];
    [_alertPwdView addSubview:imgView];
    
    CGRect frame;
    frame = _alertPwdView.frame;
    frame.size.height = frame.size.height - 60;
    _alertPwdView.frame = frame;
    
    
    //设置取消按钮的监听事件
    [_concelBtn addTarget:self action:@selector(concelBtnAction2:) forControlEvents:UIControlEventTouchUpInside];
    //设置保存按钮的监听事件
    [_confirmBtn addTarget:self action:@selector(alertViewConfirmBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //给量个输入框设置代理事假
    _oldPwdText.delegate = self;
    _newPwdText.delegate = self;
    
    i = 1;
    
    return _alertPwdView;
}

#pragma mark - 创建设置密码的view
//创建设置密码的view
- (UIView *)createSetPwdView
{
    self.setPwdView = [[[UIView alloc] initWithFrame:CGRectMake(50, 173, self.view.frame.size.width, 180)] autorelease];
    _setPwdView.tag = setViewTag;
    
    UIImage *img = [[[UIImage alloc] init] autorelease];
    UIImageView *imgView = [[[UIImageView alloc] initWithImage:img] autorelease];
    imgView.frame = CGRectMake(30, 0, _setPwdView.frame.size.width - 60, _setPwdView.frame.size.height / 3);
    
    //创建密码label
    self.oldPwdLabel = [self createLabelWithName:@"密码" andFrame:CGRectMake(imgView.frame.origin.x, imgView.frame.origin.y + imgView.frame.size.height - 35, 60, 30)];
    self.oldPwdLabel.tintColor = [UIColor whiteColor];
    [_setPwdView addSubview:_oldPwdLabel];
    
    //创建密码text
    self.oldPwdText = [self createTextFieldWithName:@"6位数字的密码" andFrame:CGRectMake(_oldPwdLabel.frame.origin.x + _oldPwdLabel.frame.size.width, _oldPwdLabel.frame.origin.y, _oldPwdLabel.frame.origin.x + _oldPwdLabel.frame.size.width + 70, _oldPwdLabel.frame.size.height)];
    _oldPwdText.delegate = self;
    _oldPwdText.tag = mimaText;
    _oldPwdText.keyboardType = UIKeyboardTypeNumberPad;     //键盘类型
    [_setPwdView addSubview:_oldPwdText];
    
    //创建agian密码label
    self.newPwdLabel = [self createLabelWithName:@"再次输入" andFrame:CGRectMake(_oldPwdLabel.frame.origin.x - 15, _oldPwdLabel.frame.origin.y + _oldPwdLabel.frame.size.height + 5, _oldPwdLabel.frame.size.width + 10, _oldPwdLabel.frame.size.height)];
    _newPwdLabel.tintColor = [UIColor whiteColor];
    [_setPwdView addSubview:_newPwdLabel];
    
    //创建again密码text
    self.newPwdText = [self createTextFieldWithName:@"请再输入一次密码" andFrame:CGRectMake(_oldPwdText.frame.origin.x, _oldPwdText.frame.origin.y + _oldPwdText.frame.size.height + 5, _oldPwdText.frame.size.width, _oldPwdText.frame.size.height)];
    _newPwdText.delegate = self;
    _newPwdText.tag = againMima;
    _newPwdText.keyboardType = UIKeyboardTypeNumberPad;     //键盘类型
    [_setPwdView addSubview:_newPwdText];
    
    //创建保存按钮
    self.confirmBtn = [self createButtonWithName:@"保存" andFrame:CGRectMake(_newPwdLabel.frame.origin.x + 2, _newPwdLabel.frame.origin.y + _newPwdLabel.frame.size.height + 5, 60, _newPwdLabel.frame.size.height)];
    self.confirmBtn.tintColor = [UIColor orangeColor];
    [_setPwdView addSubview:_confirmBtn];
    
    //创建取消按钮
    self.concelBtn = [self createButtonWithName:@"取消" andFrame:CGRectMake(_newPwdText.frame.origin.x, _newPwdText.frame.origin.y + _newPwdText.frame.size.height + 5, 60, _newPwdText.frame.size.height)];
    [_setPwdView addSubview:_concelBtn];
    self.concelBtn.tintColor = [UIColor orangeColor];
    [_setPwdView addSubview:imgView];
    
    CGRect frame;
    frame = _setPwdView.frame;
    frame.size.height = frame.size.height - 60;
    _setPwdView.frame = frame;
    
    
    //创建取消按钮的监听事件
    [_concelBtn addTarget:self action:@selector(concelBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    //创建保存按钮的监听事件
    [_confirmBtn addTarget:self action:@selector(setViewConfirmBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //给两个输入框设置代理事件
    _oldPwdText.delegate = self;
    _newPwdText.delegate = self;
    
    i = 2;
    
    return _setPwdView;
}

#pragma mark -隐藏头标题上的导航栏和时间等
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark -输入框中的长度不能超过6
//输入框中的长度不能超过6
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag == mimaText) {
        
        //得到输入框的内容
        NSString *toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        if ([toBeString length] > 6) {
            textField.text = [toBeString substringToIndex:6];
            UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"warnning" message:@"不能超过6个数字" delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
            [aler show];
            [aler release];
            [textField setEnabled:NO];
            return NO;
        }
        
    }
    return YES;
}

#pragma mark -输入框的输入不能为空
//输入框的输入不能为空
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == mimaText) {   //如果是创建密码的密码框
        NSString *string = textField.text;
        if (string.length == 0) {       //输入框长度为0的情况
            UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"输入不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [aler show];
            [aler release];
        } else {
            if ([self isKongWith:string]) {          //输入框全为空字符的情况
                UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"不能全是空字符" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [aler show];
                [aler release];
            }
        }
    }
    
    
    //如果是修改页面中的原密码输入框
    if (textField.tag == yuanMima) {
        NSString *yuanmima = textField.text;
        
        //获得数据库中的密码
//        NSMutableArray *array = [NSMutableArray array];
        NSMutableArray *array = nil;
        array = [[lxyDataBase shareLxyDataBase] searchAllDataFromUserTable];
        lxyUserTableModel *model = nil;
        model = [array objectAtIndex:0];
        NSString *mima = model.user_pwd;
        
        //判断原密码与数据库中的密码是否相等
        if ([mima isEqualToString:yuanmima]) {      //如果相等
            //打开新密码输入框
            [((UITextField *)[_alertPwdView viewWithTag:xinMima]) setEnabled:YES];
            //关闭原密码输入框
            [((UITextField *)[_alertPwdView viewWithTag:yuanMima]) setEnabled:NO];
        } else {            //如果不相等
            //提示密码输入错误
            UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"原密码输入错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [aler show];
            [aler release];
        }
    }
}

#pragma mark -增则表达式，判断一个字符串是否全部由空字符组成
//正则表达式，判断一个字符串是否全部是由空字符组成的
- (BOOL)isKongWith:(NSString *)string
{
    NSString *zengze = @"\\s*";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", zengze];
    return [test evaluateWithObject:string];
}

#pragma mark -修改密码按钮的监听事件
//修改密码按钮监听事件
- (void)alertPwdBtnAction:(UIButton *)sender
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.3];
    //小熊出现
    CGRect frame;
    frame = _stView.xiaoxiongImageView.frame;
    frame.size.width = 50;
    _stView.xiaoxiongImageView.frame = frame;
    [_alertPwdView removeFromSuperview];
    [_setPwdView removeFromSuperview];
    self.alertPwdView = [self createAlerPwdView];
    [_stView addSubview:_alertPwdView];
    [UIView commitAnimations];
}

#pragma mark -取消按钮的监听事件
//取消按钮的监听事件
- (void)concelBtnAction:(UIButton *)sender
{
    [self canleAction];
    
    [self.stView.pwdSwitch setOn:NO];
    self.stView.alertPwdBtn.hidden = YES;
}

- (void)concelBtnAction2:(UIButton *)sender
{
    [self canleAction];
    
}

-(void)canleAction
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.3];
    [_alertPwdView removeFromSuperview];
    [_setPwdView removeFromSuperview];
    //让小熊消失
    CGRect frame;
    frame = _stView.xiaoxiongImageView.frame;
    frame.size.width = 0;
    _stView.xiaoxiongImageView.frame = frame;
    [UIView commitAnimations];

}


#pragma mark -设置view上保存按钮的监听事件
//设置View上保存按钮的监听事件
- (void)setViewConfirmBtnAction:(UIButton *)sender
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *mima = ((UITextField *)[_setPwdView viewWithTag:mimaText]).text;
    NSString *mima2 = ((UITextField *)[_setPwdView viewWithTag:againMima]).text;
    
    //判断第一个密码是不是6个数字
    BOOL result;
    result = [self is6weiMiMaWith:mima];
    if (result) {
        if ([mima isEqualToString:mima2]) {     //设置密码成功
//#提示 将密码存到数据库
            //将该数据存到数据库
            lxyUserTableModel *model = [[[lxyUserTableModel alloc] initWithID:0 andName:nil andPWD:nil andBirthday:nil andHeaderImage:nil andIntroduce:nil andPhoto1:nil andPhoto2:nil] autorelease];
            
            //插入数据库的时候看一下数据库中是否有数据
//            NSMutableArray *array = [[[NSMutableArray alloc] init] autorelease];
//            NSMutableArray *array = nil;
            NSMutableArray *array = [NSMutableArray array];
            array = [[lxyDataBase shareLxyDataBase] searchAllDataFromUserTable];
            if (0 == array.count) {         //如果数据库中没有数据
                //创建该数据表
                [[lxyDataBase shareLxyDataBase] createUserTable];
                //把该model插入进去
                [[lxyDataBase shareLxyDataBase] insertToUserTableWithOneUserTableModel:model];
                [userDefaults setBool:YES forKey:@"isSetPwd"];
                
            } else {                    //如果数据库中有数据
                //修改数据中的密码字段
                [[lxyDataBase shareLxyDataBase] alertPassWordWithNewPassWord:mima2];
                [userDefaults setBool:YES forKey:@"isSetPwd"];

            }
            
            switchIndex ++;
            _stView.pwdSwitch.userInteractionEnabled = YES;
            //调用取消按钮的事件
//            [self concelBtnAction:nil]
            [_stView.pwdSwitch setOn:YES animated:YES];
            _stView.pwdSwitch.userInteractionEnabled = YES;
//            _stView.setPwdBtn.hidden = YES;
            _stView.alertPwdBtn.hidden = NO;
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:1.3];
            //让小熊消失
            CGRect frame = _stView.xiaoxiongImageView.frame;
            frame.size.width = 0;
            _stView.xiaoxiongImageView.frame = frame;
            
            //移除设置密码界面
            [self.setPwdView removeFromSuperview];
            [UIView commitAnimations];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"设置成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
            [alert release];
            
        } else {                    //设置密码失败
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"两次输入不一样" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
            [alert release];
        }
    } else {
        UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入6位数字的密码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [aler show];
        [aler release];
    }

}

#pragma mark -alerView的代理方法
//alertViewDelegate代理方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [((UITextField *)[_setPwdView viewWithTag:mimaText]) setEnabled:YES];
            break;
            
        default:
            break;
    }
}

#pragma mark -修改密码页面上保存按钮的监听事件
//修改View上保存按钮的监听事件
- (void)alertViewConfirmBtnAction:(UIButton *)sender
{
    //修改页面的保存按钮
    
    NSString *xinmima = ((UITextField *)[_alertPwdView viewWithTag:xinMima]).text;
    
    //利用正则表达式判断该新密码是不是6个数字
    BOOL result;
    result = [self is6weiMiMaWith:xinmima];
    if (result) {
        //再把该新密码插入到数据库中
        [[lxyDataBase shareLxyDataBase] alertPassWordWithNewPassWord:xinmima];
        [_alertPwdView removeFromSuperview];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:1.3];
        //小熊消失
        CGRect frame;
        frame = _stView.xiaoxiongImageView.frame;
        frame.size.width = 0;
        _stView.xiaoxiongImageView.frame = frame;
        //设置页面消失
        [_setPwdView removeFromSuperview];
        [UIView commitAnimations];
        
        //提示修改成功
        UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"" message:@"修改密码成功" delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
        [aler show];
        [aler release];
        
    } else {
        UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"warnning" message:@"密码为6位数字" delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
        [aler show];
        [aler release];
    }
    
}

//利用正则表达式判断是否为6位数字的密码
- (BOOL)is6weiMiMaWith:(NSString *)string
{
    NSString *zhengze = @"\\d{6}";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@" , zhengze];
    return [test evaluateWithObject:string];
}

#pragma mark -设置密码按钮监听事件
//设置密码按钮监听事件
- (void)setPwdBtnAction:(UIButton *)sender
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.3];
    
    [_setPwdView removeFromSuperview];
    [_alertPwdView removeFromSuperview];
    self.setPwdView = [self createSetPwdView];
    CGRect frame;
    frame = _stView.xiaoxiongImageView.frame;
    frame.size.width = 50;
    _stView.xiaoxiongImageView.frame = frame;
    [_stView.backImgView addSubview:_setPwdView];
    
    [UIView commitAnimations];
    
}



- (void)setPwd
{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.3];
    
    [_setPwdView removeFromSuperview];
    [_alertPwdView removeFromSuperview];
    self.setPwdView = [self createSetPwdView];
    CGRect frame;
    frame = _stView.xiaoxiongImageView.frame;
    frame.size.width = 50;
    _stView.xiaoxiongImageView.frame = frame;
    [_stView.backImgView addSubview:_setPwdView];
    
    [UIView commitAnimations];

}
//备份按钮监听事件
- (void)backUpBtnAction:(UIButton *)sender
{    [self dismissViewControllerAnimated:YES completion:nil];

    NSLog(@"备份按钮");
    //将所有数据备份到云端
}

#pragma mark -密码开关选择的监听事件
//密码开关选择的监听方法
- (void)pwdSwitchAction:(UISwitch *)sender
{
    
    if (sender.isOn == YES) {       //开关处于打开状态
        flag = 1;
        [self setPwd];
        [self closeOriginPwdView];
        
        //隐藏设置密码按钮
//        _stView.setPwdBtn.hidden = YES;
        
        //显示修改密码按钮
        _stView.alertPwdBtn.hidden = NO;
        
    } else {                        //开关处于关闭状态
        
//        [self stopPwd];
        [self canleAction];
        
        //  清空数据库中的密码
        [[lxyDataBase shareLxyDataBase] alertPassWordWithNewPassWord:@"(null)"];
    
        
        //隐藏修改密码按钮
        _stView.alertPwdBtn.hidden = YES;
        
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isSetPwd"];
        
        //显示设置密码按钮
//        _stView.setPwdBtn.hidden = NO;
    }
}

#pragma mark 停用密码事件
//- (void)stopPwd
//{
//    //  要求用户输入原密码
//    self.originPwdLbl = [[[UILabel alloc] initWithFrame:Rect(50, 200, 60, 30)] autorelease];
//    self.originPwdLbl.text = @"原密码";
//    [self.stView addSubview:_originPwdLbl];
//    
//    self.originPwd = [[[UITextField alloc] initWithFrame:Rect(MaxX(_originPwdLbl.frame), MinY(_originPwdLbl.frame), 100, 30)] autorelease];
//    _originPwd.borderStyle = UITextBorderStyleRoundedRect;
//    [self.stView addSubview:_originPwd];
//    
//    self.originPwdOkButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    _originPwdOkButton.frame = CGRectMake(MaxX(_originPwd.frame) + 20 ,MinY(_originPwd.frame), 30, 30);
//    [_originPwdOkButton setTitle:@"确定" forState:UIControlStateNormal];
//    [self.stView addSubview:_originPwdOkButton];
//    
//    
//}

- (void)closeOriginPwdView
{
    [self.originPwdOkButton removeFromSuperview];
    [self.originPwd removeFromSuperview];
    [self.originPwdLbl removeFromSuperview];
}
//输入框中将要编辑的时候
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame;
    
    if (1 == i) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:1.3];
        frame = _alertPwdView.frame;
        if (frame.origin.y != self.view.frame.size.height - 350) {
            frame.origin.y = self.view.frame.size.height - 350;
        }
        _alertPwdView.frame = frame;
        [UIView commitAnimations];
    }
    
    if (2 == i) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:1.3];
        frame = _setPwdView.frame;
        if (frame.origin.y != self.view.frame.size.height - 350) {
            frame.origin.y = self.view.frame.size.height - 350;
        }
        _setPwdView.frame = frame;
        [UIView commitAnimations];
    }
}

- (void)didReceiveMemory提示
{
    [super didReceiveMemory提示];
    // Dispose of any resources that can be recreated.
}

@end
