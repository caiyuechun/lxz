//
//  OrderPriceInfoCell.m
//  chuangyi
//
//  Created by caiyc on 17/8/10.
//  Copyright © 2017年 changce. All rights reserved.
//

#import "OrderPriceInfoCell.h"

@implementation OrderPriceInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)bindData:(NSDictionary *)dic
{
    self.consignee.text = dic[@"consignee"];
    self.phone.text = dic[@"mobile"];
    self.address.text =[NSString stringWithFormat:@"%@%@%@%@",dic[@"provincename"],dic[@"cityname"],dic[@"districtname"], dic[@"address"]];
    self.paytype.text = @"支付方式：微信";
   // self.orderamout.text = [NSString stringWithFormat:@"商品合计：¥%@", dic[@"goods_price"]];
    NSString*price =[NSString stringWithFormat:@"租金合计：¥%@", dic[@"rent_price"]];
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:price ];
    [AttributedStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:ICONNAME size:13] range:NSMakeRange(5, price.length-5)];
     [AttributedStr addAttribute:NSForegroundColorAttributeName value:PRICECOLOR range:NSMakeRange(5, price.length-5)];
    self.orderamout.attributedText = AttributedStr;

  // self.counsPrice.text =  [NSString stringWithFormat:@"优惠券抵扣：¥%@", dic[@"coupon_price"]];
    NSString*prices =[NSString stringWithFormat:@"余额抵扣：¥%@", dic[@"user_money"]];
    NSMutableAttributedString *AttributedStrs = [[NSMutableAttributedString alloc]initWithString:prices ];
    [AttributedStrs addAttribute:NSFontAttributeName value:[UIFont fontWithName:ICONNAME size:13] range:NSMakeRange(5, prices.length-5)];
    [AttributedStrs addAttribute:NSForegroundColorAttributeName value:PRICECOLOR range:NSMakeRange(5, prices.length-5)];
  //  self.counsPrice.attributedText = AttributedStrs;
    
  //  self.shipPrice.text =  [NSString stringWithFormat:@"邮费：¥%@", dic[@"shipping_price"]];
    NSString*pricess = [NSString stringWithFormat:@"邮费：¥%@", dic[@"shipping_price"]];
    NSMutableAttributedString *AttributedStrss = [[NSMutableAttributedString alloc]initWithString:pricess ];
    [AttributedStrss addAttribute:NSFontAttributeName value:[UIFont fontWithName:ICONNAME size:13] range:NSMakeRange(3, pricess.length-3)];
    [AttributedStrss addAttribute:NSForegroundColorAttributeName value:PRICECOLOR range:NSMakeRange(3, pricess.length-3)];
    self.shipPrice.attributedText = AttributedStrss;
    
    
    NSString*pricesss = [NSString stringWithFormat:@"优惠券抵扣：¥%@", dic[@"coupon_price"]];
    NSMutableAttributedString *AttributedStrsss = [[NSMutableAttributedString alloc]initWithString:pricesss ];
    [AttributedStrsss addAttribute:NSFontAttributeName value:[UIFont fontWithName:ICONNAME size:13] range:NSMakeRange(6, pricesss.length-6)];
    [AttributedStrsss addAttribute:NSForegroundColorAttributeName value:PRICECOLOR range:NSMakeRange(6, pricesss.length-6)];
    self.couponsPrice.attributedText = AttributedStrsss;

    NSString*pricessss = [NSString stringWithFormat:@"积分抵扣：¥%@", dic[@"integral_money"]];
    NSMutableAttributedString *AttributedStrssss = [[NSMutableAttributedString alloc]initWithString:pricessss ];
    [AttributedStrssss addAttribute:NSFontAttributeName value:[UIFont fontWithName:ICONNAME size:13] range:NSMakeRange(5, pricessss.length-5)];
    [AttributedStrssss addAttribute:NSForegroundColorAttributeName value:PRICECOLOR range:NSMakeRange(5, pricessss.length-5)];
  //  self.interLb.attributedText = AttributedStrsss;

    //self.couponsPrice.text =

    
    
if([dic[@"pucaddress"]count]>0)
{
    self.sendtype.text = [NSString stringWithFormat:@"自提点：%@",dic[@"pucaddress"][@"pickup_name"]];
}else
{
    self.sendtype.text = [NSString stringWithFormat:@"运输快递：%@",dic[@"shipping_name"]];
}
//    if([dic[@"pay_name"]isEqualToString:@""]){
//    self.paytypes.text = @"支付方式：暂无";
//    }else{
//     self.paytypes.text =[NSString stringWithFormat:@"支付方式：%@",dic[@"pay_name"]];
//    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
