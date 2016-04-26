//
//  SalesMoneyView.m
//  guoping
//
//  Created by zhisu on 15/10/28.
//  Copyright © 2015年 zhisu. All rights reserved.
//

#import "SalesMoneyView.h"
@interface SalesMoneyView ()

@property(nonatomic,retain)UILabel *label1;
@property(nonatomic,retain)UILabel *label2;
@property(nonatomic,retain)UILabel *labelNumeber;

@end

@implementation SalesMoneyView

-(instancetype)initWithFrame:(CGRect)frame
{
    
    
    if (self = [super initWithFrame:frame]) {
        
        
        [self createTitleLabel];
        
    }
    return self;
}


-(void)createTitleLabel
{
    
    
    
    self.label1 = [[UILabel alloc]init];
    //self.label1.backgroundColor = [UIColor redColor];
    self.label1.frame =CGRectMake(ScreenWidth/2.30, 26, 100, 20);
    self.label1.textColor = [UIColor colorWithRed:255.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1];
    self.label1.font = [UIFont systemFontOfSize:16];
    
    [self addSubview:self.label1];
    
    
    self.label2 = [[UILabel alloc]init];
    self.label2.frame =CGRectMake(ScreenWidth/1.33, 26, 100, 20);
    self.label2.textColor = [UIColor grayColor];
    self.label2.font = [UIFont systemFontOfSize:16];
    

    [self addSubview:self.label2];

    
    
    self.labelNumeber = [[UILabel alloc]init];
    self.labelNumeber.frame =CGRectMake(ScreenWidth/7.1, 26, 100, 20);
    self.labelNumeber.textColor = [UIColor colorWithRed:255.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1];
    self.labelNumeber.font = [UIFont systemFontOfSize:16];
    
    [self addSubview:self.labelNumeber];
    
    

    
}
- (void)setCellModel:(SalesMoneyModel *)cellModel
{
    _cellModel = cellModel;
    
    self.label1.text = [NSString stringWithFormat:@"¥ %.2f",cellModel.Data.doubleValue];
    self.label2.text = [NSString stringWithFormat:@"¥ %.2f",cellModel.Data.doubleValue];
    
    
#pragma mark————增加折扣价格的下划线
     NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥ %.2f",cellModel.Data.doubleValue]];
     [string setAttributes:@{NSStrikethroughStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]} range:NSMakeRange(0, string.length)];
     
     self.label2.attributedText = string;
    
    
    
    
//    //售价
//    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:18]};
//    
//    //动态计算出宽度
//    CGSize size1 = [self.label1.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options: NSStringDrawingUsesLineFragmentOrigin  attributes:attribute context:nil].size;
//    
//    
//    CGRect frame1 = self.label1.frame;
//    frame1.size.width = size1.width;
//    frame1.origin.x =ScreenWidth/1.1-size1.width;
//    
//    self.label1.frame = frame1;
    
    

}
-(void)setCellModelNumber:(SeNumberModel *)cellModelNumber
{
    
    _cellModelNumber = cellModelNumber;
    
    self.labelNumeber.text = [NSString stringWithFormat:@"%.2f",cellModelNumber.Data.doubleValue];
    
//    //售价
//    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:18]};
//    
//    //动态计算出宽度
//    CGSize size1 = [self.labelNumeber.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options: NSStringDrawingUsesLineFragmentOrigin  attributes:attribute context:nil].size;
//    
//    
//    CGRect frame1 = self.labelNumeber.frame;
//    frame1.size.width = size1.width;
//    frame1.origin.x =ScreenWidth/1.1-size1.width;
//    
//    self.labelNumeber.frame = frame1;
    
    
}
@end
