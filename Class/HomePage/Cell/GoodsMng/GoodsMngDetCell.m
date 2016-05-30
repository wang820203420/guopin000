//
//  GoodsMngDetCell.m
//  guoping
//
//  Created by zhisu on 15/10/26.
//  Copyright © 2015年 zhisu. All rights reserved.
//

#import "GoodsMngDetCell.h"
#import "GoodsMngDetModel.h"


@interface GoodsMngDetCell ()
{
    
    NSString *data;
}

@property(nonatomic,strong)UILabel *GoodsName;
@property(nonatomic,strong)UILabel *GoodsCode;
@property(nonatomic,strong)UILabel *SaleState;
@property(nonatomic,strong)UITextView *RetailPrice;
@property(nonatomic,strong)UILabel *CurrentInventory;
@property(nonatomic,strong)UILabel *UnitName;
@property(nonatomic,strong)UILabel *UnitName1;
@end
@implementation GoodsMngDetCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    //创建cell
    NSString *cellID = @"cellID";
    GoodsMngDetCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    
    if (cell == nil) {
        
        cell = [[GoodsMngDetCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
 
    
    return cell;
    
    
}



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        
        UILabel *label = [MyUtil createLabelFrame:CGRectMake(10, 20, 100, 10) title:@"商品名称:" textAlignment:NSTextAlignmentLeft];
        label.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
        label.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:label];
        self.GoodsName = [[UILabel alloc]init];
        self.GoodsName.frame = CGRectMake(85, 20, 150, 10);
        self.GoodsName.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.GoodsName];
        
        
        
        UILabel *label1 = [MyUtil createLabelFrame:CGRectMake(10, 45, 200, 10) title:@"商品简码:" textAlignment:NSTextAlignmentLeft];
        label1.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
        label1.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:label1];
        self.GoodsCode = [[UILabel alloc]init];
        self.GoodsCode.frame = CGRectMake(85, 45, 150, 10);
        self.GoodsCode.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.GoodsCode];
        
        
        
        
        UILabel *label2 = [MyUtil createLabelFrame:CGRectMake(10, 70, 200, 10) title:@"商品状态:" textAlignment:NSTextAlignmentLeft];
        label2.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
        label2.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:label2];
        self.SaleState = [[UILabel alloc]init];
        self.SaleState.frame = CGRectMake(85,70, 150, 10);
        self.SaleState.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.SaleState];
        
        
        
        UILabel *label3 = [MyUtil createLabelFrame:CGRectMake(10, 122, 200, 10) title:@"库存" textAlignment:NSTextAlignmentLeft];
        label3.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
        label3.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:label3];
        //数字lable
        self.CurrentInventory = [[UILabel alloc]init];
        self.CurrentInventory.frame = CGRectMake(ScreenWidth/1.09, 117, 150, 20);
        self.CurrentInventory.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:self.CurrentInventory];
        //单位lable
        self.UnitName = [[UILabel alloc]init];
        self.UnitName.frame = CGRectMake(ScreenWidth/1.09, 117, 150, 20);
        self.UnitName.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:self.UnitName];
        
        
        
        
        UILabel *label4 = [MyUtil createLabelFrame:CGRectMake(10,172, 200, 10) title:@"售价" textAlignment:NSTextAlignmentLeft];
        label4.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
        label4.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:label4];
        
        //创建一个空白的文本编辑框输入的是  数字  UIKeyboardTypeDecimalPad
        self.RetailPrice = [[UITextView alloc]init];
        self.RetailPrice.frame = CGRectMake(ScreenWidth/1.2,159, 150, 30);
        self.RetailPrice.font = [UIFont systemFontOfSize:16];
        

        


        self.RetailPrice.delegate = self;
        self.RetailPrice.editable = NO;
        self.RetailPrice.returnKeyType = UIReturnKeyDone;
        self.RetailPrice.keyboardType = UIKeyboardTypeDecimalPad;//数字键盘加小数点
        //self.RetailPrice.keyboardType = UIKeyboardTypeURL;
        
        
        
        self.RetailPrice.scrollEnabled = NO;
        [self.contentView addSubview:self.RetailPrice];
        
        //拼接格式创建的单位lable
        self.UnitName1 = [[UILabel alloc]init];
        self.UnitName1.frame = CGRectMake(ScreenWidth/1.18, 167, 150, 20);
        self.UnitName1.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:self.UnitName1];
        
        
        
        //线条
        CGRect  Lowframe = CGRectMake(0, 99.5, ScreenWidth, 0.5);
        UIImageView *Lowimage = [MyUtil createIamgeViewFrame:Lowframe imageName:@"375x1@2x"];
        [self.contentView addSubview:Lowimage];
        
        //线条
        CGRect  Lowframe1 = CGRectMake(0, 0, ScreenWidth, 0.5);
        UIImageView *Lowimage1 = [MyUtil createIamgeViewFrame:Lowframe1 imageName:@"375x1@2x"];
        [self.contentView addSubview:Lowimage1];
        
        //线条
        CGRect  Lowframe2 = CGRectMake(0, 149.5, ScreenWidth, 0.5);
        UIImageView *Lowimage2 = [MyUtil createIamgeViewFrame:Lowframe2 imageName:@"375x1@2x"];
        [self.contentView addSubview:Lowimage2];
        
        //线条
        CGRect  Lowframe3 = CGRectMake(0, 199, ScreenWidth, 0.5);
        UIImageView *Lowimage3 = [MyUtil createIamgeViewFrame:Lowframe3 imageName:@"375x1@2x"];
        [self.contentView addSubview:Lowimage3];
        
        
    }
    
    return self;
    
}



-(void)setCellModel:(GoodsMngDetModel *)cellModel
{
    
    _cellModel = cellModel;
    
    self.GoodsName.text = _cellModel.GoodsName;
    self.GoodsCode.text = _cellModel.GoodsCode;
    self.SaleState.text= _cellModel.SaleState;
    self.UnitName.text = _cellModel.UnitName;
    self.UnitName1.text = [NSString stringWithFormat:@"元/%@",_cellModel.UnitName];
    
    self.CurrentInventory.text = [NSString stringWithFormat:@"%.2f",_cellModel.CurrentInventory.doubleValue];
 
    self.RetailPrice.text = [NSString stringWithFormat:@"%.2f",_cellModel.RetailPrice.doubleValue];
    
    
    
    //1.库存frame
    
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:16]};
    
    CGSize size1 = [self.CurrentInventory.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options: NSStringDrawingUsesLineFragmentOrigin  attributes:attribute context:nil].size;
    
    
    CGRect frame1 = self.CurrentInventory.frame;
    frame1.size.width = size1.width;
    frame1.origin.x =ScreenWidth/1.09-size1.width;
    
    self.CurrentInventory.frame = frame1;
    
    
    CGRect frame4 = self.UnitName.frame;
    //frame4.size.width = size1.width;
    frame4.origin.x =ScreenWidth/1.09;
    
    self.UnitName.frame = frame4;

    
    
    //2.售价frame

    NSDictionary *attribute1 = @{NSFontAttributeName: [UIFont systemFontOfSize:16]};
    
    CGSize size2 = [self.RetailPrice.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options: NSStringDrawingUsesLineFragmentOrigin  attributes:attribute1 context:nil].size;
    
    
    CGRect frame2 = self.RetailPrice.frame;
    frame2.size.width = size2.width+20;
    frame2.origin.x =ScreenWidth/1.2-size2.width;
    self.RetailPrice.frame = frame2;

    
    CGRect frame3 = self.UnitName1.frame;
    //frame3.size.width = size1.width;
    frame3.origin.x =ScreenWidth/1.18;
    self.UnitName1.frame = frame3;
    
    
}


@end
