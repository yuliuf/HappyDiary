//
//  LYDiaryView.h
//  HappyDiary
//
//  Created by liuyu on 14-6-20.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYToolBarView.h"


@interface LYDiaryView : UIView<UIGestureRecognizerDelegate , UITextViewDelegate>

@property (nonatomic, strong) UIButton *weatherBtn; //  天气按钮
@property (nonatomic, strong) UILabel *timeLabel; //  时间
@property (nonatomic, strong) UILabel *weekLabel;  // 星期
@property (nonatomic, strong) UIButton *toolButton;  //  工具按钮
//@property (nonatomic, retain) UITextView *content;  //  正文
@property (nonatomic, weak) UITapGestureRecognizer *tapGR; //  手势
@property (nonatomic, strong) UITextField *title;   //  标题
@property (nonatomic, strong) UIImageView *xinzhi;
@property (nonatomic, strong) UIButton *savaButton;  //  保存按钮
@property (nonatomic, strong) UIButton *cleanButton;  //  清空按钮
@property (nonatomic, strong) UIButton *eventButton;  //  跳转到日历按钮

@property (nonatomic , strong) UIImageView *bookImageView;
@property (nonatomic , strong) UIImageView *titleImageView;

@property (nonatomic, strong) LYToolBarView *toolBarView;  //  左侧工具栏
@property (nonatomic, strong) UITableView *rightToorBar;  //  右侧子工具栏

@property (nonatomic, weak) UILongPressGestureRecognizer *longPressGR;  //  tableview添加长按手势
//@property (nonatomic, assign) UIView *decoIcon;  //  接收需要编辑的装饰图


@end
