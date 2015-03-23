//
//  lxyBaseView.h
//  EventController
//
//  Created by 刘翔宇 on 14-6-20.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface lxyBaseView : UIView

//@property (nonatomic , retain) UIImageView *bookImageView;
//@property (nonatomic , retain) UIImageView *titleImageView;

@property (nonatomic, strong) UITapGestureRecognizer *doubleTapGR;
@property (nonatomic, strong) UILabel *showStatusBarLabel;

@end
