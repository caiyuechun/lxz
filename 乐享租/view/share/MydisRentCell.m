//
//  MydisRentCell.m
//  乐享租
//
//  Created by caiyc on 18/5/3.
//  Copyright © 2018年 changce. All rights reserved.
//  我发布的出租样式

#import "MydisRentCell.h"

@implementation MydisRentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.handel_Btn.layer.masksToBounds = 1;
    self.handel_Btn.layer.borderColor = RGB(100, 100, 100).CGColor;
    self.handel_Btn.layer.borderWidth = 0.8;
    self.handel_Btn.layer.cornerRadius = 15;
    // Initialization code
}
- (IBAction)handelAction:(UIButton *)sender {
}
-(void)bindData:(NSDictionary *)dic{
    self.num_Lab.text = [NSString stringWithFormat:@"编号：%@",dic[@"order_sn"]];
    self.time_Lab.text = dic[@"time"];
    self.status_Lab.text = dic[@"status_name"];
    [self.thumb sd_setImageWithURL:[NSURL URLWithString:dic[@"original_img"]] placeholderImage:nil];
    
    if([dic[@"pay_status"]integerValue]==0){
        [self.handel_Btn setTitle:@"支付检测费用" forState:UIControlStateNormal];
    }
    if([dic[@"pay_status"]integerValue]==1){
      [self.handel_Btn setTitle:@"填写快递单号" forState:UIControlStateNormal];
    }
    self.name_Lab.text = dic[@"goods_name"];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
