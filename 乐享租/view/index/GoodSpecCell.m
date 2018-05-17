//
//  GoodSpecCell.m
//  chuangyi
//
//  Created by caiyc on 17/8/7.
//  Copyright © 2017年 changce. All rights reserved.
//

#import "GoodSpecCell.h"

@implementation GoodSpecCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.taozhuangNum.layer.borderColor = [UIColor redColor].CGColor;
    self.taozhuangNum.layer.borderWidth = 0.8;
    
    self.gou1.layer.masksToBounds = 1;
    self.gou1.layer.cornerRadius = 8;
    self.gou1.layer.borderWidth = 1;
    self.gou1.layer.borderColor = [UIColor redColor].CGColor;
    
    self.guo2.layer.masksToBounds = 1;
    self.guo2.layer.cornerRadius = 8;
    self.guo2.layer.borderWidth = 1;
    self.guo2.layer.borderColor = [UIColor redColor].CGColor;
    
    self.gou3.layer.masksToBounds = 1;
    self.gou3.layer.cornerRadius = 8;
    self.gou3.layer.borderWidth = 1;
    self.gou3.layer.borderColor = [UIColor redColor].CGColor;
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//选择规格
- (IBAction)clickSpec:(UIButton *)sender {
    self.clickSpec();
}
//选择套餐
- (IBAction)clickGrup:(UIButton *)sender {
    self.clickGroup();
}
//查看购买须知
- (IBAction)clickRule:(UIButton *)sender {
   // self.clickRuel();
}
//查看检测费用
- (IBAction)checkReport:(UIButton *)sender {
    self.checkreport();
}
//查看服务费用
- (IBAction)checkFee:(UIButton *)sender {
    self.clickRuel();
}
@end
