//
//  LYButtonImageView.h
//  HappyDiary
//
//  Created by liuyu on 14-6-22.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYButtonImageView : UIImageView

@property (nonatomic, retain)UILabel *content;
@property (nonatomic, assign)NSInteger tag;
- (void)addTarget:(id)target
           action:(SEL)action
 forControlEvents:(UIControlEvents)controlEvents;

@end
