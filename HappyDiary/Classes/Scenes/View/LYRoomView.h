//
//  LYRoomView.h
//  HappyDiary
//
//  Created by liuyu on 14-6-22.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYRoomView : UIView

@property (nonatomic, retain) LYButtonImageView *book;  //  书本
@property (nonatomic, retain) LYButtonImageView *store; //  储物盒
@property (nonatomic, retain) LYButtonImageView *setting;   //  设置
@property (nonatomic, retain) LYButtonImageView *specialDay; // 特殊日记录板
@property (nonatomic, retain) LYButtonImageView *photo1;
@property (nonatomic, retain) LYButtonImageView *photo2;
@property (nonatomic, retain) UILabel *date;// 日期
@property (nonatomic, retain) UILabel *day;  // 几号
@property (nonatomic, assign) UITapGestureRecognizer *tap;
@end
