//
//  YCOneDetailViewController.m
//  Diary
//
//  Created by 孙震 on 14-6-19.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import "YCOneDetailViewController.h"
#import "YCOneDetailView.h"
#import "lxyAlonePersonModel.h"
//#import "lxyDataBase.h"

@interface YCOneDetailViewController ()
@property (nonatomic, strong) YCOneDetailView *oneDetailView;
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, assign) NSInteger clickCount;
@property (nonatomic, copy) NSString *imagePath;
@end

@implementation YCOneDetailViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.imageArray = @[@"deco_sticker_mygom2",@"deco_sticker_mygom4",@"deco_sticker_mygom6",@"deco_sticker_mygom7",@"deco_sticker_mygom8",@"deco_sticker_mygom9",@"deco_sticker_mygom10",@"deco_sticker_mygom11",@"deco_sticker_mygom12",@"deco_sticker_mygom13"];
    }
    return self;
}

- (void)loadView
{
    self.oneDetailView = [[YCOneDetailView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view = self.oneDetailView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self hiddenBackButton:YES];
    
    self.imagePath = self.aloneModel.backGroundImage;
    self.oneDetailView.userInteractionEnabled = NO;
    
    self.oneDetailView.textView.text = [self.aloneModel content];
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:self.aloneModel.backGroundImage];
    self.oneDetailView.bgImageView.image = image;
    
    //  rightBar
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(rightBarAction:)];
    [rightBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"LiDeBiao-Xing-3.0" size:22.f], NSFontAttributeName, UIColorFromRGB(0xB94FFF), NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightBar;
    
    //  leftBar
    NSString *string = [self.aloneModel name];
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithTitle:string style:UIBarButtonItemStyleDone target:self action:@selector(leftBarAction:)];
    [leftBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"LiDeBiao-Xing-3.0" size:22.f], NSFontAttributeName, UIColorFromRGB(0xFF8800), NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = leftBar;
    
    //  deleteButton
    [self.oneDetailView.deleteButton addTarget:self action:@selector(deleteButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    //  更换图片
    [self.oneDetailView.changeImageButton addTarget:self action:@selector(changeImageAction:) forControlEvents:UIControlEventTouchUpInside];
    // 轻拍手势
    [self.oneDetailView.tapGR addTarget:self action:@selector(tapGRAction:)];
}

#pragma mark 轻拍手势 收回键盘事件
- (void)tapGRAction:(UIGestureRecognizer *)sender
{
    [self.oneDetailView endEditing:YES];
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
        self.oneDetailView.bgImageView.image = image;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 按钮事件
- (void)rightBarAction:(UIBarButtonItem *)sender
{
    if ([sender.title isEqualToString: @"编辑"]) {
        sender.title = @"完成";
        self.oneDetailView.userInteractionEnabled = YES;
        self.oneDetailView.changeImageButton.hidden = NO;
        [self.oneDetailView.textView becomeFirstResponder];
    } else {
        lxyAlonePersonModel *model = self.aloneModel;
        
        //  删除对应数据
        [[lxyDataBase shareLxyDataBase] deleteOneAlonePersonModel:self.aloneModel byName:[self.aloneModel name]];
        
        //  添加对应新数据
        model.content = self.oneDetailView.textView.text;
        model.backGroundImage = self.imagePath;
         [[lxyDataBase shareLxyDataBase] insertToAlonePersonTableWithOneAlonePersonModel:model byName:[model name]];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (void)leftBarAction:(UIBarButtonItem *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    //[self.navigationController popViewControllerAnimated:YES];
}

- (void)deleteButtonAction:(UIButton *)sender
{
    //  删除数据
    [[lxyDataBase shareLxyDataBase] deleteOneAlonePersonModel:self.aloneModel byName:[self.aloneModel name]];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 隐藏导航栏上方系统时间、电池显示
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
