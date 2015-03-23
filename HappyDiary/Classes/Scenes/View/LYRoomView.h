//
//  LYRoomView.h
//  HappyDiary
//
//  Created by liuyu on 14-6-22.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYRoomView : UIView

@property (nonatomic, strong) LYButtonImageView *book;  //  书本
@property (nonatomic, strong) LYButtonImageView *store; //  储物盒
@property (nonatomic, strong) LYButtonImageView *setting;   //  设置
@property (nonatomic, strong) LYButtonImageView *specialDay; // 特殊日记录板
@property (nonatomic, strong) LYButtonImageView *photo1;
@property (nonatomic, strong) LYButtonImageView *photo2;
@property (nonatomic, strong) UILabel *date;// 日期
@property (nonatomic, strong) UILabel *day;  // 几号
@property (nonatomic, strong) UITapGestureRecognizer *tap;
@end
