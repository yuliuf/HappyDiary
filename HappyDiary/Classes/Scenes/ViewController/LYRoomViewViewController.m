//
//  LYRoomViewViewController.m
//  HappyDiary
//
//  Created by liuyu on 14-6-22.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "LYRoomViewViewController.h"
#import "LYRoomView.h"

//#import "LYCustomTabBar.h"
#import "YCDiaryViewController.h"
#import "lxyEventViewController.h"
#import "YCHourglassViewController.h"
//#import "YCSetttingViewController.h"
//#import "LYButtonImageView.h"
#import "lxySettingViewController.h"

#import "YCSpecialDayViewController.h"

@interface LYRoomViewViewController ()<UINavigationControllerDelegate , UIActionSheetDelegate , UIImagePickerControllerDelegate>

@property (nonatomic, retain) LYRoomView *roomView;
@property (nonatomic, assign) NSInteger flag;

@end

NSInteger zhaoxiangji = 0;

@implementation LYRoomViewViewController

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
    self.roomView = [[[LYRoomView alloc] initWithFrame:[UIScreen mainScreen].bounds] autorelease];
    self.view = self.roomView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    //  书本
	[self.roomView.book addTarget:self action:@selector(BookAction:) forControlEvents:UIControlEventTouchUpInside];
    //  设置
    [self.roomView.setting addTarget:self action:@selector(settingAction:) forControlEvents:UIControlEventTouchUpInside];
    //  沙漏
     [self.roomView.store addTarget:self action:@selector(sgAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //photo的监听事件
    [self.roomView.photo1 addTarget:self action:@selector(photoAction:) forControlEvents:UIControlEventTouchUpInside];
    //
    [self.roomView.photo2 addTarget:self action:@selector(photoAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //special day的监听事件
    [self.roomView.specialDay addTarget:self action:@selector(specialDayAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //  日历label的轻拍手势
    [self.roomView.tap addTarget:self action:@selector(canledarTap:)];

}

//————————————————————————————————————点击主页上的图片所触发的一些列方法事件————————————————————————————————————
- (void)BookAction:(LYButtonImageView *)sender
{
  
    YCDiaryViewController *diaryVC = [[YCDiaryViewController alloc] init];
    [self presentViewController:diaryVC animated:YES completion:nil];
    [diaryVC release];
}
- (void)settingAction:(LYButtonImageView *)sender
{
    lxySettingViewController *settingVC = [[lxySettingViewController alloc] init];
    [self presentViewController:settingVC animated:YES completion:nil];
    [settingVC release];
}
- (void)sgAction:(LYButtonImageView *)sender
{
    YCHourglassViewController *hgVC = [[YCHourglassViewController alloc] init];
    [self presentViewController:hgVC animated:YES completion:nil];
    [hgVC release];
}

- (void)canledarTap:(UIGestureRecognizer *)sender
{
    lxyEventViewController *eventVC = [[lxyEventViewController alloc] init];
    [self presentViewController:eventVC animated:YES completion:nil];
    [eventVC release];
    
}


//photo的监听事件
- (void)photoAction:(LYButtonImageView *)sender
{
    if (sender.tag == 200) {
        _flag = 0;
    } else {
        _flag = 1;
    }
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"select" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"照相机" , @"图库", nil];
    [sheet showInView:self.view];
    
//    NSLog(@"jdsfljds");

}
//actionSheet的代理事件
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            //选择照相机
            [self selectCamera];
            zhaoxiangji ++;
            break;
        case 1:
            //选择图库
            [self selectPhoto];
            break;
            
        default:
            break;
    }
}
//调用照相机方法
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
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"warnning" message:@"no camera" delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
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
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"warnning" message:@"no photo library" delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
}
//UIImagePickerControllerDelegate里的方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //得到图片
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
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

    
    
    //  改变尺寸
    CGFloat width = self.roomView.photo1.frame.size.width;

    UIImage *changeSizeImage = [LYHelper  OriginImage:image scaleToSize:CGSizeMake(width, image.size.height / image.size.width * width)];
    UIImage *img = [UIImage imageWithCGImage:CGImageCreateWithImageInRect(changeSizeImage.CGImage, self.roomView.photo1.bounds)];
    
    [self dismissViewControllerAnimated:YES completion:nil];

    
    
    NSData *imageData = UIImagePNGRepresentation(img);
    NSString *time = [LYHelper getCurrentTime];
    //  拼接出存储路径
    NSString *imagePath = [KDocument stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", time]];
    [imageData writeToFile:imagePath atomically:YES];
    
    UIImage *selectImage = [[[UIImage alloc] initWithContentsOfFile:imagePath] autorelease];
//    [selectImage release];
    
    //如果是从照相机进来的 这个方法
    if (1 == zhaoxiangji) {
        //把该如片存入相册
        UIImageWriteToSavedPhotosAlbum(selectImage, nil, nil, nil);
    }
    zhaoxiangji = 0;
    
//    CGFloat width = self.roomView.photo1.frame.size.width;
//    width = 100;
//    selectImage = [LYHelper  OriginImage:selectImage scaleToSize:CGSizeMake(width, selectImage.size.height / selectImage.size.width * width)];
//    UIImage *img = [UIImage imageWithCGImage:CGImageCreateWithImageInRect(selectImage.CGImage, self.roomView.photo1.bounds)];
    if (_flag == 0) {
        self.roomView.photo1.image = selectImage;
        self.roomView.photo1.contentMode = UIViewContentModeScaleAspectFit;
        [[lxyDataBase shareLxyDataBase] alertPhoto1WithPhoto:imagePath];
    } else {
        self.roomView.photo2.image = selectImage;
        self.roomView.photo2.contentMode = UIViewContentModeScaleAspectFit;
        [[lxyDataBase shareLxyDataBase] alertPhoto2WithPhoto:imagePath];

    }
    
//    [selectImage release];
    
    
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//选中图片进入的代理方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//alertView的代理方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            ;
            break;
            
        default:
            break;
    }
}
//————————————————————————————————————————————————————————————————————————————————————————————————————————



//special day的监听事件
- (void)specialDayAction:(LYButtonImageView *)sender
{
    YCSpecialDayViewController *specialDayVC = [[YCSpecialDayViewController alloc] init];
    specialDayVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:specialDayVC animated:YES completion:nil];
    [specialDayVC release];
}

#pragma mark 隐藏导航栏上方系统时间、电池显示
- (BOOL)prefersStatusBarHidden
{
    return YES;
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
