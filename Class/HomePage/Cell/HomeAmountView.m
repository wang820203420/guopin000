//
//  HomeAmountView.m
//  guoping
//
//  Created by zhisu on 15/10/14.
//  Copyright (c) 2015年 zhisu. All rights reserved.
//

#import "HomeAmountView.h"

@interface HomeAmountView ()
{
    //数据
    NSArray *_modelArray;
    UILabel *YuanLabel;
    UILabel *biLabel;
    
    
    
}

@property(nonatomic,retain)UILabel *label;
@property(nonatomic,retain)UILabel *label1;


@end


@implementation HomeAmountView



-(instancetype)initWithFrame:(CGRect)frame
{
    
    
    if (self = [super initWithFrame:frame]) {
        
        
        [self createTitleLabel];
        
    }
    return self;
}


-(void)createTitleLabel
{
    
        //销售背景
    UIImageView *SaleView = [MyUtil createIamgeViewFrame:CGRectMake(12, 12,ScreenWidth-24, ScreenHeight/6.2) imageName:@"hz_bg@2x 17-03-57-635"];
    [self addSubview:SaleView];
    
    
     YuanLabel= [MyUtil createLabelFrame:CGRectMake(ScreenWidth/2.2, ScreenHeight/7.7, 20, 20) title:@"元" textAlignment:NSTextAlignmentLeft];
    YuanLabel.textColor = [UIColor colorWithRed:74.0/255.0 green:159.0/255.0 blue:60.0/255.0 alpha:1];
    YuanLabel.font = [UIFont systemFontOfSize:14];
    YuanLabel.adjustsFontSizeToFitWidth = YES;
    //YuanLabel.backgroundColor = [UIColor blueColor];
    [self addSubview:YuanLabel];
    
    self.label = [[UILabel alloc]init];
    self.label.frame =CGRectMake(ScreenWidth/11, ScreenHeight/9.5,50, 40);
    //self.label.backgroundColor = [UIColor redColor];
    self.label.textColor = [UIColor colorWithRed:72.0/255.0 green:159.0/255.0 blue:97.0/255.0 alpha:1];
    self.label.font = [UIFont systemFontOfSize:30];
    [self addSubview:self.label];
    
    
    
    
    
    
    biLabel= [MyUtil createLabelFrame:CGRectMake(ScreenWidth/1.37, ScreenHeight/7.7, 20, 20) title:@"笔" textAlignment:NSTextAlignmentLeft];
        biLabel.textColor = [UIColor colorWithRed:74.0/255.0 green:159.0/255.0 blue:60.0/255.0 alpha:1];
        biLabel.font = [UIFont systemFontOfSize:14];
        biLabel.adjustsFontSizeToFitWidth = YES;
    //biLabel.backgroundColor = [UIColor blueColor];
    [self addSubview:biLabel];

    self.label1 = [[UILabel alloc]init];
    self.label1.frame =CGRectMake(ScreenWidth/1.8, ScreenHeight/9.5, 50, 40);
    self.label1.textColor = [UIColor colorWithRed:72.0/255.0 green:159.0/255.0 blue:97.0/255.0 alpha:1];
    //self.label1.backgroundColor = [UIColor redColor];
    self.label1.font = [UIFont systemFontOfSize:30];
    [self addSubview:self.label1];
    
    
}


-(void)setCellModel:(HomePageModel *)cellModel
{
    
    _cellModel = cellModel;
    
    self.label.text = cellModel.SaleAmount.stringValue;
    self.label1.text = cellModel.SaleCount.stringValue;
    
    
    
    //总金额
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:30]};
    
    //动态计算出宽度
    CGSize size1 = [self.label.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options: NSStringDrawingUsesLineFragmentOrigin  attributes:attribute context:nil].size;
    
    
    CGRect frame1 =  self.label.frame;
    frame1.size.width = size1.width;
    //frame1.origin.x =ScreenWidth/8;
    
    self.label.frame = frame1;
    
    
    //计算 元  的位置
    CGRect framey =  YuanLabel.frame;
    //framey.size.width = size1.width+10;
    framey.origin.x =ScreenWidth/11+size1.width;
    YuanLabel.frame = framey;
    
    
    
    
    
    
    
    //笔数
    NSDictionary *attribute1 = @{NSFontAttributeName: [UIFont systemFontOfSize:30]};
    
    //动态计算出宽度
    CGSize size2 = [self.label1.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options: NSStringDrawingUsesLineFragmentOrigin  attributes:attribute1 context:nil].size;
    
    
    CGRect frame2 =  self.label1.frame;
    frame2.size.width = size2.width;
    //frame2.origin.x =ScreenWidth/1.5-size2.width;
    
    self.label1.frame = frame2;
    
    
      //计算 笔  的位置
    CGRect frameb =  biLabel.frame;
    //framey.size.width = size1.width+10;
    frameb.origin.x =ScreenWidth/1.8+size2.width;
    biLabel.frame = frameb;
    
    
    
}

@end
