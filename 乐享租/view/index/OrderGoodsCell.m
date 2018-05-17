//
//  OrderGoodsCell.m
//  chuangyi
//
//  Created by caiyc on 17/8/10.
//  Copyright © 2017年 changce. All rights reserved.
//

#import "OrderGoodsCell.h"

@implementation OrderGoodsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.price.textColor = PRICE_COLOR;
     self.selectionStyle = UITableViewCellSelectionStyleNone;
     self.image.contentMode = UIViewContentModeScaleAspectFit;
    // Initialization code
}
-(void)bindData:(NSDictionary *)dic
{
    NSString *str = dic[@"original_img"];

  //  NSString *str = userDic[@"head_pic"];
//    NSString *urlStr = @"";
//    if([str rangeOfString:@"http://"].location !=NSNotFound)//_roaldSearchText
//    {
//        
//        urlStr = str;
//    }
//    else
//    {
//        urlStr = [NSString stringWithFormat:@"%@%@",BASE_SERVICE,str];
//    }

// NSString *url = [NSString stringWithFormat:@"%@%@",BASE_SERVICE,dic[@"original_img"]];
    [self.image sd_setImageWithURL:[NSURL URLWithString:str]];
    self.name.text = dic[@"goods_name"];
   if([dic[@"spec_key_name"]isEqualToString:@""])
   {
       self.spec.text = @"暂无规格";
   }
   else self.spec.text = dic[@"spec_key_name"];
    if([dic[@"month_num"]integerValue]>0){
        
        NSString *price= [NSString stringWithFormat:@"周期：%@个月  ¥%@/月  服务费  ¥%@",dic[@"month_num"],dic[@"goods_price"],dic[@"server_price"]];
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:price ];
        [AttributedStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:ICONNAME size:13] range:NSMakeRange(0, price.length)];
        self.price.attributedText = AttributedStr;

    }else{
    NSString *price= [NSString stringWithFormat:@"¥%@",dic[@"goods_price"]];
   NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:price ];
    [AttributedStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:ICONNAME size:16] range:NSMakeRange(1, price.length-1)];
    self.price.attributedText = AttributedStr;
    }
    
    self.nums.text =  [NSString stringWithFormat:@"x%@",dic[@"goods_num"]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
