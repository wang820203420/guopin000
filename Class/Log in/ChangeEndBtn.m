//
//  ChangeBtn.m
//  JuAnXing
//
//  Created by wangqian on 15/5/19.
//  Copyright (c) 2015年 wangqian. All rights reserved.
//

#import "ChangeEndBtn.h"
#define kTitleImageSpace (ScreenWidth/2.5)
@implementation ChangeEndBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.imageView.contentMode = UIViewContentModeCenter;
    }
    return self;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    NSString * title = [self titleForState:UIControlStateNormal];
    UIImage * image = [self imageForState:UIControlStateNormal];
    CGSize stringSize =  [title sizeWithFont:[UIFont systemFontOfSize:15]];
    CGFloat titleW = stringSize.width;
    CGFloat titleH = contentRect.size.height;
    CGFloat titleX = (contentRect.size.width - (stringSize.width + kTitleImageSpace + image.size.width)) /2;
    CGFloat titleY = 0.0f;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    NSString * title = [self titleForState:UIControlStateNormal];
    UIImage * image = [self imageForState:UIControlStateNormal];
    CGSize stringSize =  [title sizeWithFont:[UIFont systemFontOfSize:15]];
    CGFloat imageW = image.size.width;
    CGFloat imageH = contentRect.size.height;
    CGFloat imageX = (contentRect.size.width - (stringSize.width + kTitleImageSpace + image.size.width)) /2 + stringSize.width + kTitleImageSpace;
    CGFloat imageY = 0.0f;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

@end
