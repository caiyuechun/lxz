//
//  RaiseCell.m
//  SHOP
//
//  Created by caiyc on 17/3/13.
//  Copyright © 2017年 changce. All rights reserved.
//

#import "RaiseCell.h"
//#import "raiseItem.h"
@implementation RaiseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.scroView.showsHorizontalScrollIndicator = 0;
}
-(void)bindData:(NSArray*)array
{
    self.scroView.contentSize = CGSizeMake(160*array.count, self.scroView.frame.size.height);
    for(int i =0;i<array.count;i++)
    {
        NSDictionary *item = array[i];
        UIView *itemview = [[UIView alloc]initWithFrame:CGRectMake(160*i, 5, 160, 217)];
        
        itemview.layer.shadowColor=[UIColor grayColor].CGColor;
        itemview.layer.shadowOffset = CGSizeMake(2,2);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
        itemview.layer.shadowOpacity = 0.1;//阴影透明度，默认0
        itemview.layer.shadowRadius = 2;//阴影半径，默认3 .layer.shadowOpacity = 0.8;//阴影透明度，默认0
        
       // itemview.backgroundColor = [UIColor redColor];
        
        UIImageView *images = [[UIImageView alloc]initWithFrame:CGRectMake(15, 5, 130, 130)];
        [images sd_setImageWithURL:[NSURL URLWithString:item[@"original_img"]]];
        [itemview addSubview:images];
        UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(0, 145, 160, 20)];
        name.textAlignment = NSTextAlignmentCenter;
        name.text = item[@"goods_name"];
        [itemview addSubview:name];
        name.font = [UIFont systemFontOfSize:15];
        
        UILabel *remark = [[UILabel alloc]initWithFrame:CGRectMake(8, 165, 144, 20)];
        remark.textAlignment = NSTextAlignmentCenter;
        remark.text = [item[@"goods_remark"]isEqualToString:@""]?@"暂无简介":item[@"goods_remark"];
        [itemview addSubview:remark];
        remark.textColor = [UIColor grayColor];
        remark.font = [UIFont systemFontOfSize:13];
        
       UILabel *prices = [[UILabel alloc]initWithFrame:CGRectMake(0, 185, 160, 20)];
        prices.textAlignment = NSTextAlignmentCenter;
//        price.text = item[@"shop_price"];
        [itemview addSubview:prices];
//        price.textColor = [UIColor redColor];
//        price.font = [UIFont systemFontOfSize:14];
        [self.scroView addSubview:itemview];
        
        NSString*price =[NSString stringWithFormat:@"¥%@/月",item[@"shop_price"]];
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:price ];
        [AttributedStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:ICONNAME size:14] range:NSMakeRange(1, price.length-1)];
        [AttributedStr addAttribute:NSForegroundColorAttributeName value:PRICECOLOR range:NSMakeRange(0, price.length)];
        prices.attributedText = AttributedStr;

//        UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(160, 0, 1, 217)];
//        line.backgroundColor = viewcontrollerColor;
//        [itemview addSubview:line];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickItem:)];
        itemview.tag = i;
        [itemview addGestureRecognizer:tap];
       

    }
    
}
-(void)clickItem:(UIGestureRecognizer *)ges
{
    NSInteger index = ges.view.tag;
    self.clickItems(index);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
