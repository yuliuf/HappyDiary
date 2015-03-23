//
//  LYRoomView.m
//  HappyDiary
//
//  Created by liuyu on 14-6-22.
//  Copyright (c) 2014年 RainbowYu. All rights reserved.
//

#import "LYRoomView.h"
#import "lxyUserTableModel.h"

@implementation LYRoomView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addAllViews];
    }
    return self;
}
- (void)addAllViews
{
    //  背景
//    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"myroom_base"]];
    UIImageView *bacgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"myroom_base"]];
    bacgroundView.frame = self.bounds;
    [self addSubview:bacgroundView];
    [bacgroundView release];
    
    //  装饰图
    UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"myroom_amuselogo.png"]];
    logo.frame = Rect(160, 8, 48, 60);
    [self addSubview:logo];
    [logo release];
    
    // specialDay-content
    self.specialDay = [[[LYButtonImageView alloc] initWithFrame:Rect(60, MinY(logo.frame) + 30, 97, 66)] autorelease];
    self.specialDay.image = [UIImage imageNamed:@"myroom_specialday_bg.png"];
    self.specialDay.content.text = @"special day";
    [self addSubview:_specialDay];
    // specialDay-边框
    UIImageView *border = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"myroom_specialday.png"]];
    border.frame = Rect(_specialDay.frame.origin.x - 20, _specialDay.frame.origin.y - 20, 129, 97);
    [self addSubview:border];
    [border release];

    //  相片框1
    UIImageView *photoBorder = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"myroom_photoframe.png"]] autorelease];
    photoBorder.frame = Rect(138, ScreenHeight/4, 71, 92);
    [self addSubview:photoBorder];
        UIImageView *photoBorder2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"myroom_photoframe.png"]];
    photoBorder2.frame = Rect(MaxX(photoBorder.frame) + 8, MinY(photoBorder.frame) + 15, 71, 92);
    [self addSubview:photoBorder2];
    [photoBorder2 release];
    
    //  照片
    NSMutableArray *userArray = [[lxyDataBase shareLxyDataBase] searchAllDataFromUserTable];
    NSString *imagePath1 = nil;
    NSString *imagePath2 = nil;
    UIImage *image1 = nil;
    UIImage *image2 = nil;
    if (userArray.count == 0) {
        lxyUserTableModel *user = [[[lxyUserTableModel alloc] initWithID:0 andName:nil andPWD:nil andBirthday:nil andHeaderImage:nil andIntroduce:nil andPhoto1:nil andPhoto2:nil] autorelease];
        [[lxyDataBase shareLxyDataBase] insertToUserTableWithOneUserTableModel:user];
        imagePath1 = [[NSBundle mainBundle] pathForResource:@"myroom_photo0" ofType:@"png"];
        imagePath2 = [[NSBundle mainBundle] pathForResource:@"myroom_photo1" ofType:@"png"];
        image1 = [[UIImage alloc] initWithContentsOfFile:imagePath1];
        image2 = [[UIImage alloc] initWithContentsOfFile:imagePath2];
    } else {
        lxyUserTableModel *user = userArray[0];
        imagePath1 = user.user_photo1;
        imagePath2 = user.user_photo2;
        
        //photo0照片的路径是否是空
        if ([imagePath1 isEqualToString:@"(null)"]) {
            imagePath1 = [[NSBundle mainBundle] pathForResource:@"myroom_photo0" ofType:@"png"];
            image1 = [[UIImage alloc] initWithContentsOfFile:imagePath1];
        } else {
            image1 = [[UIImage alloc] initWithContentsOfFile:imagePath1];
        }
        
        //photo2照片的路径是否是空
        if ([imagePath2 isEqualToString:@"(null)"]) {
            imagePath2 = [[NSBundle mainBundle] pathForResource:@"myroom_photo1" ofType:@"png"];
            image2 = [[UIImage alloc] initWithContentsOfFile:imagePath2];
        } else {
            image2 = [[UIImage alloc] initWithContentsOfFile:imagePath2];
        }
    }
//    UIImage *image1 = [[UIImage alloc] initWithContentsOfFile:imagePath1];
//    UIImage *image2 = [[UIImage alloc] initWithContentsOfFile:imagePath2];
    
    self.photo1 = [[[LYButtonImageView alloc] initWithImage:image1] autorelease];
    [image1 release];
    self.photo1.frame = Rect(143, MinY(photoBorder.frame)+ 5, 61, 65);
    self.photo1.tag = 200;
    [self addSubview:_photo1];
    
    self.photo2 = [[[LYButtonImageView alloc] initWithImage: image2] autorelease];
    [image2 release];
    self.photo2.frame = Rect(MaxX(photoBorder.frame) + 8 + 5, MinY(photoBorder.frame) + 15 + 5, 61, 65);
    self.photo2.tag = 201;
    [self addSubview:_photo2];
    
    //  设置（backup）
    self.setting = [[[LYButtonImageView alloc] initWithImage:[UIImage imageNamed:@"setting.png"]] autorelease];
    self.setting.tag = 3;
    self.setting.frame = Rect(MinX(photoBorder.frame) + 30, ScreenHeight / 1.8, 80, 96);
    [self addSubview:_setting];
    
    //  时间
    self.date = [[[UILabel alloc] initWithFrame:Rect(99, MinY(_setting.frame) + 10, 42, 20)] autorelease];
    self.date.text = [[LYHelper getCurrentTime] substringToIndex:7];
    self.date.font = [UIFont fontWithName:ziti size:15.f];
    self.date.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_date];
    
    self.day = [[[UILabel alloc] initWithFrame:Rect(MinX(_date.frame), MaxY(_date.frame), 42, 40)] autorelease];
    self.day.textAlignment = NSTextAlignmentCenter;
    self.day.font = [UIFont fontWithName:ziti size:28];
    self.day.text = [[LYHelper getCurrentTime] substringWithRange:NSMakeRange(8, 2)];
    self.day.userInteractionEnabled = YES;
//    self.day.backgroundColor = [UIColor yellowColor];
    [self addSubview:_day];

    //  日记本
    self.book = [[[LYButtonImageView alloc] initWithImage:[UIImage imageNamed:@"myroom_diary.png"]] autorelease];
    self.book.frame = Rect(MaxX(_day.frame) - 20, MaxY(_setting.frame) + 10, 95, 90);
    self.book.tag = 0;
    [self addSubview:_book];
    
    // 沙漏
    self.store = [[[LYButtonImageView alloc] initWithImage:[UIImage imageNamed:@"hourglass"]] autorelease];
    self.store.frame = Rect(MaxX(_setting.frame) - 20, MinY(_setting.frame) + 20, 110, 130);
    self.store.tag = 2;
    [self addSubview:_store];
    
    //  台灯
    UIImageView *light = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"myroom_light.png"]];
    light.frame = self.bounds;
    [self addSubview:light];
    [light release];
    
    //  咖啡动画
    UIImageView *coffee = [[UIImageView alloc] initWithFrame:Rect(40, ScreenHeight / 4 * 1.8, 50, 150)];
    NSArray *array = @[@"myroom_coffeeani1", @"myroom_coffeeani2", @"myroom_coffeeani3", @"myroom_coffeeani4"];
    NSMutableArray *imageArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < array.count; i ++) {
        UIImage *image = [UIImage imageNamed:array[i]];
        [imageArray addObject:image];
    }
    coffee.animationImages = imageArray;
    [imageArray release];
    coffee.animationDuration = 2.f;
    [coffee startAnimating];
    
    [self addSubview:coffee];
    [coffee release];

}

- (UITapGestureRecognizer *)tap
{

    if (_tap == nil) {
        _tap = [[UITapGestureRecognizer alloc] init];
        [self.day addGestureRecognizer:_tap];
    }
    return _tap;
}

@end
