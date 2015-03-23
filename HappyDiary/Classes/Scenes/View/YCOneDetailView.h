//
//  YCOneDetailView.h
//  Diary
//
//  Created by 孙震 on 14-6-19.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCOneDetailView : UIView

@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIButton *changeImageButton;
@property (nonatomic, strong) UIButton *deleteButton;
@property (nonatomic, strong) UITapGestureRecognizer *tapGR;
@end
