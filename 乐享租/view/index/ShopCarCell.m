//
//  ShopCarCell.m
//  乐享租
//
//  Created by caiyc on 18/3/14.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "ShopCarCell.h"

@implementation ShopCarCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
     [self.check_Lab LabelWithIconStr:@"\U0000e606" inIcon:iconfont andSize:CGSizeMake(15, 15) andColor:BASE_GRAY_COLOR andiconSize:15];
    self.price.textColor = PRICE_COLOR;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)bindData:(NSDictionary *)dic{
    NSString *str = [NSString stringWithFormat:@"%@",dic[@"original_img"]];
    
    [self.thumb sd_setImageWithURL:[NSURL URLWithString:str]];

    
    NSString*price = [NSString stringWithFormat:@"总计：¥ %@",dic[@"goods_fee"]];
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:price ];
    [AttributedStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:ICONNAME size:14] range:NSMakeRange(4, price.length-4)];
    self.price.attributedText = AttributedStr;
    
     self.name.text = dic[@"goods_name"];
    
    self.date.text = [NSString stringWithFormat:@"时间：%@月",dic[@"month_num"]];
    self.paytype.text = [NSString stringWithFormat:@"租金：%@/月",dic[@"goods_price"]];
    self.buytype.text = [NSString stringWithFormat:@"服务费：%@",dic[@"server_price"]];
    self.num_Tf.text = [NSString stringWithFormat:@"%@",dic[@"goods_num"]];
    
    if([dic[@"selected"]integerValue]==1){
    
    [self.check_Lab LabelWithIconStr:@"\U0000e606" inIcon:iconfont andSize:CGSizeMake(15, 15) andColor:BUTTON_COLOR andiconSize:15];
    }
    

}
- (IBAction)selectAction:(UIButton *)sender {
    self.select();
}
- (IBAction)add:(UIButton *)sender {
    NSInteger nums = [self.num_Tf.text integerValue];
    nums++;
    //self.numTf.text = @"111";
   // self.num_Tf.text = [NSString stringWithFormat:@"%ld",(long)nums];
    self.num_Tf.text = [NSString stringWithFormat:@"%ld",(long)nums];
    self.numAdd(nums);
}

- (IBAction)jian:(UIButton *)sender {
    NSInteger nums = [self.num_Tf.text integerValue];
    if(nums>1)
    {
        nums--;
        //self.numTf.text = @"111";
       // self.num_Tf.text = [NSString stringWithFormat:@"%ld",(long)nums];
        self.num_Tf.text = [NSString stringWithFormat:@"%ld",(long)nums];
        self.numAdd(nums);
    }

}
@end
