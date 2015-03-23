//
//  YCOneDetailView.h
//  Diary
//
//  Created by 孙震 on 14-6-19.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCOneDetailView : UIView

@property (nonatomic, retain) UIImageView *bgImageView;
@property (nonatomic, retain) UITextView *textView;
@property (nonatomic, retain) UIButton *changeImageButton;
@property (nonatomic, retain) UIButton *deleteButton;
@property (nonatomic, assign) UITapGestureRecognizer *tapGR;
@end
