//
//  LYDiaryView.m
//  HappyDiary
//
//  Created by liuyu on 14-6-20.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import "LYDiaryView.h"
#define TXT_FRAME Rect(40, 93, ScreenWidth-80, ScreenHeight-160)

@implementation LYDiaryView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addAllViews];
    }
    return self;
}

- (void)addAllViews
{
    
    
    //添加背景图书图片
    UIImage *bookImage = [UIImage imageNamed:@"book.png"];
    self.bookImageView = [[UIImageView alloc] initWithImage:bookImage];
    _bookImageView.userInteractionEnabled = YES;
    _bookImageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self addSubview:_bookImageView];
    
    //添加背景title图片
    UIImage *titleImage = [UIImage imageNamed:@"title.png"];
    self.titleImageView = [[UIImageView alloc] initWithImage:titleImage];
    _titleImageView.userInteractionEnabled = YES;
    _titleImageView.frame = CGRectMake(0, 0, self.frame.size.width, 54);
    [self addSubview:_titleImageView];

    //  添加信纸
    self.xinzhi = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"deco_bg_popup_check15"]];
    self.xinzhi.frame = Rect(20, 40, ScreenWidth - 30, ScreenHeight - 60);
    self.xinzhi.layer.cornerRadius = 5;
//    self.xinzhi.backgroundColor = myPink;
    _xinzhi.userInteractionEnabled = YES;
    [self addSubview:self.xinzhi];
    
    //  标题底色label
    UIView *view = [[UIView alloc] initWithFrame:Rect(20, 50, ScreenWidth - 20 - 15, 30)];
    view.backgroundColor = [UIColor whiteColor];
    view.alpha = 0.8f;
    [self addSubview:view];
    
    // 选择事件图标按钮
    self.weatherBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _weatherBtn.frame = CGRectMake(40, MinY(view.frame) - 5, 30, 30);
    _weatherBtn.tag = 1;
    [_weatherBtn setBackgroundImage:[UIImage imageNamed:@"event_icon0"] forState:UIControlStateNormal];
    [self addSubview:self.weatherBtn];
    
    // 标题
    self.title = [[UITextField alloc] initWithFrame:Rect(80, kMargin + 3, 150, 25)];
    self.title.placeholder = @"标题";
    self.title.font = [UIFont systemFontOfSize:20.f];
//    self.title.borderStyle = UITextBorderStyleRoundedRect;
    self.title.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_title];
    
    // 工具按钮
    self.toolButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _toolButton.frame = CGRectMake(ScreenWidth - 40 ,30, 30, 30);
    [self.toolButton setBackgroundImage:[UIImage imageNamed:@"page_selected_on"] forState:UIControlStateNormal];
    [self addSubview:_toolButton];
    
    // 左侧工具栏
    self.toolBarView = [[LYToolBarView alloc] initWithFrame:Rect(0, 150, 54, 300) withArray:[NSArray array]];
    [self addSubview:_toolBarView];
    _toolBarView.alpha = 0.f;
    
    //  右侧工具栏
    self.rightToorBar = [[UITableView alloc] initWithFrame:Rect(ScreenWidth - 40, 100, 40, 350) style:UITableViewStylePlain];
    [self addSubview:_rightToorBar];
    _rightToorBar.showsVerticalScrollIndicator = NO;
    self.rightToorBar.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.rightToorBar.alpha = 0.f; //  此处只能是把透明度设为0 不能直接设hidden为0
    self.rightToorBar.layer.cornerRadius = 3;
    
  
 
    
    //  日历按钮
    self.eventButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _eventButton.frame = Rect(40, ScreenHeight - 55, 80, 30);
    [_eventButton setTitle:@"今日记录" forState:UIControlStateNormal];
    _eventButton.tintColor = [UIColor whiteColor];
    _eventButton.titleLabel.font = myZiti;
    [_eventButton setBackgroundImage:[UIImage imageNamed:@"intro_menu_brown"] forState:UIControlStateNormal];
    [self addSubview:_eventButton];
    
    //  清空按钮
    self.cleanButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _cleanButton.frame = Rect(MaxX(_eventButton.frame) + 30, MinY(_eventButton.frame), 60, 30);
    [_cleanButton setTitle:@"清空" forState:UIControlStateNormal];
    _cleanButton.tintColor = [UIColor whiteColor];
    _cleanButton.titleLabel.font = myZiti;
    [_cleanButton setBackgroundImage:[UIImage imageNamed:@"intro_menu_brown"] forState:UIControlStateNormal];
    [self addSubview:_cleanButton];
    
    //  保存按钮
    self.savaButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _savaButton.frame = Rect(ScreenWidth - 90, MinY(_cleanButton.frame), 60, 30);
    [_savaButton setTitle:@"保存" forState:UIControlStateNormal];
    _savaButton.tintColor = [UIColor whiteColor];
    _savaButton.titleLabel.font = myZiti;
    [_savaButton setBackgroundImage:[UIImage imageNamed:@"intro_menu_brown"] forState:UIControlStateNormal];
    [self addSubview:_savaButton];
    
    
    

}
#pragma mark 重写手势的getter
- (UITapGestureRecognizer *)tapGR
{
    if (_tapGR == nil) {
        _tapGR = [[UITapGestureRecognizer alloc] init];
        //  讲手势添加到view上
        [_xinzhi addGestureRecognizer:_tapGR];
        
    }
    
    //  返回手势
    return _tapGR;
    
}

- (UILongPressGestureRecognizer *)longPressGR
{
    if (_longPressGR == nil) {
        _longPressGR = [UILongPressGestureRecognizer new];
        [_rightToorBar addGestureRecognizer:_longPressGR];
    }
    return _longPressGR;
    
}



@end
