//
//  LYToolBarView.h
//  HappyDiary
//
//  Created by 刘翔宇 on 14-6-24.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYToolBarView : UIScrollView

@property (nonatomic, retain) NSArray *toolArray;

#pragma mark 用数组初始化工具条
- (id)initWithFrame:(CGRect)frame withArray:(NSArray *)Array;
@end