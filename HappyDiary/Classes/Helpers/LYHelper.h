//
//  LYHelper.h
//  HappyDiary
//
//  Created by liuyu on 14-7-2.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYHelper : NSObject


+ (NSString *)getCurrentTime;

+ (UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size;

+ (void)shakeAnimationForView:(UIView *) view;
@end
