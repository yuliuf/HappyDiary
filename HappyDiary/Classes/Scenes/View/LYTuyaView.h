//
//  LYTuyaView.h
//  HappyDiary
//
//  Created by 刘翔宇 on 14-6-26.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//


@interface LYTuyaView : UIView

@property(nonatomic,strong) NSMutableArray *lineArray;//创建一个数组
@property (nonatomic, assign) NSInteger colorTag; //  画壁颜色
//@property (nonatomic, retain) UIButton *saveButton; //  保存涂鸦按钮
@property (nonatomic, strong) UIButton *cancleButton;//  取消按钮
@property (nonatomic, strong) UIButton *deleteButton;//  回删按钮

@end
