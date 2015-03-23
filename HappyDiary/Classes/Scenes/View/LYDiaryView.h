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

@property (nonatomic, retain) UIButton *weatherBtn; //  天气按钮
@property (nonatomic, retain) UILabel *timeLabel; //  时间
@property (nonatomic, retain) UILabel *weekLabel;  // 星期
@property (nonatomic, retain) UIButton *toolButton;  //  工具按钮
//@property (nonatomic, retain) UITextView *content;  //  正文
@property (nonatomic, assign) UITapGestureRecognizer *tapGR; //  手势
@property (nonatomic, retain) UITextField *title;   //  标题
@property (nonatomic, retain) UIImageView *xinzhi;
@property (nonatomic, retain) UIButton *savaButton;  //  保存按钮
@property (nonatomic, retain) UIButton *cleanButton;  //  清空按钮
@property (nonatomic, retain) UIButton *eventButton;  //  跳转到日历按钮

@property (nonatomic , retain) UIImageView *bookImageView;
@property (nonatomic , retain) UIImageView *titleImageView;

@property (nonatomic, retain) LYToolBarView *toolBarView;  //  左侧工具栏
@property (nonatomic, retain) UITableView *rightToorBar;  //  右侧子工具栏

@property (nonatomic, assign) UILongPressGestureRecognizer *longPressGR;  //  tableview添加长按手势
//@property (nonatomic, assign) UIView *decoIcon;  //  接收需要编辑的装饰图


@end
