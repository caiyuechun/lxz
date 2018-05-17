//
//  GoodsInfoCell.m
//  chuangyi
//
//  Created by caiyc on 17/8/4.
//  Copyright © 2017年 changce. All rights reserved.
//

#import "GoodsInfoCells.h"

@implementation GoodsInfoCells

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.price.textColor = PRICECOLOR;
    self.checkLb.layer.cornerRadius = 5;
    // Initialization code
}
-(void)bindData:(NSDictionary *)diction
{
    self.name.text = [diction[@"goods_name"]isEqualToString:@""]?@"暂无名称": diction[@"goods_name"];
    self.remark.text = [diction[@"goods_remark"]isEqualToString:@""]?@"暂无简介":diction[@"goods_remark"];
   NSString *shopPrice = @"";
    NSInteger length = 0;
    if(diction[@"flash_sale"][@"price"])
    {
      shopPrice = [NSString stringWithFormat:@"¥%@ ¥%@", diction[@"flash_sale"][@"price"],diction[@"shop_price"]];
        NSString *str = [NSString stringWithFormat:@"%@",diction[@"flash_sale"][@"price"]];
        length = [str length];
//        length = [diction[@"flash_sale"][@"price"]length];
        //shopPrice = [NSString stringWithFormat:@"¥%@",diction[@"shop_price"]];
    }else
    {
        if([diction[@"market_price"]integerValue]==0)
        {
            shopPrice = [NSString stringWithFormat:@"¥%@ ¥%@", diction[@"shop_price"],diction[@"market_price"]];
            NSString *str = [NSString stringWithFormat:@"%@",diction[@"shop_price"]];
            length = [str length];

        }else
        {
       shopPrice = [NSString stringWithFormat:@"¥%@", diction[@"shop_price"]];
        NSString *str = [NSString stringWithFormat:@"%@",diction[@"shop_price"]];
        length = [str length];
        }
//        self.price.text =[NSString stringWithFormat:@"¥%@", diction[@"shop_price"]];
//        shopPrice = [NSString stringWithFormat:@"¥%@",diction[@"market_price"]];
    }
   // NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:shopPrice ];
    [attribtStr addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(length+1, shopPrice.length-length-1)];
    [attribtStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:ICONNAME size:13] range:NSMakeRange(length+1, shopPrice.length-length-1)];
    [attribtStr addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(length+1, shopPrice.length-length-1)];
    
    [attribtStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:ICONNAME size:20] range:NSMakeRange(1, length)];
    
    self.price.attributedText = attribtStr;
    self.active_Lab.text = diction[@"activity_description"];


   // self.sales.text = [NSString stringWithFormat:@"已售:%@", diction[@"sales_sum"]];
    NSString *texts = [NSString stringWithFormat:@"已售:%@", diction[@"sales_sum"]];;
    NSDictionary *attributeDict = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0],
                                    NSForegroundColorAttributeName: BASE_COLOR};
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:texts];
    [attrStr setAttributes:attributeDict range:NSMakeRange(3, texts.length-3)];
    self.sales.attributedText = attrStr;

    self.commentNum.text = [NSString stringWithFormat:@"%@",diction[@"comment_count"]];
    CGFloat heights = 0.0;
    if([self.name.text isEqualToString:@""])
    {
        heights = 0.0;
    }else
    heights = [self.name getAttributedStringHeightWidthValue:screen_width-20];
    NSLog(@"名字文本高度…%f",heights);
    CGRect nameOldRect = self.name.frame;
    self.name.frame = CGRectMake(nameOldRect.origin.x, nameOldRect.origin.y, screen_width-20, heights);
    CGFloat remarkHei = 44;
//    if(![self.remark.text isEqualToString:@""])
//    {
//    remarkHei=  [self.remark getAttributedStringHeightWidthValue:screen_width-20];
//    }else
//    {
//        remarkHei = 0.0;
//    }

    CGRect remarkOldRect = self.remark.frame;
    NSLog(@"其实高度%f",heights+15);
  
    self.remark.frame = CGRectMake(remarkOldRect.origin.x, heights+15,  self.active_Lab.frame.size.width-20, remarkHei);
    
    CGRect priceOldRect = self.price.frame;
    CGRect oldPriceRect = self.oldPrice.frame;
      self.active_Lab.frame = CGRectMake(0,  heights+10+remarkHei,  self.active_Lab.frame.size.width, 20);
    CGFloat heightss = 0.0;
    if([diction[@"activity_description"]isEqualToString:@""]){
        heightss =heights+10+remarkHei;
    }else{
      heightss =heights+30+remarkHei;
    }
    self.price.frame = CGRectMake(priceOldRect.origin.x, heightss, priceOldRect.size.width, priceOldRect.size.height);
   
    
    self.oldPrice.frame = CGRectMake(oldPriceRect.origin.x, heightss, oldPriceRect.size.width, oldPriceRect.size.height);
    CGRect saleOldRect = self.sales.frame;
    self.sales.frame =CGRectMake(saleOldRect.origin.x, heightss, saleOldRect.size.width, saleOldRect.size.height);
  //  CGRect saleOldRect = self.sales.frame;

 //    CGRect saleOldRect = self.sales.frame;
   // self.sales.frame = CGRectMake(saleOldRect.origin.x, remarkHei+heights+30, saleOldRect.size.width, saleOldRect.size.height);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)checkAllComment:(UIButton *)sender {
    self.checkAllcomm();
}
@end
