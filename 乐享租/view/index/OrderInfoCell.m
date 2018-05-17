//
//  OrderInfoCell.m
//  chuangyi
//
//  Created by caiyc on 17/8/10.
//  Copyright © 2017年 changce. All rights reserved.
//

#import "OrderInfoCell.h"

@implementation OrderInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
     self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = viewcontrollerColor;
    self.price.textColor = PRICE_COLOR;
    self.shipFee.textColor = PRICE_COLOR;
    self.youhuiPrice.textColor = PRICE_COLOR;
    self.disUserMoney.textColor = PRICE_COLOR;
    self.interprice.textColor = PRICE_COLOR;
    [self.selectUsermoeny ButtonWithIconStr:@"\U0000e7b2" inIcon:iconfont andSize:CGSizeMake(30, 30) andColor:[UIColor lightGrayColor] andiconSize:20];
    [self.pickselfLb LabelWithIconStr:@"\U0000e7b2" inIcon:iconfont andSize:CGSizeMake(20, 20) andColor:[UIColor lightGrayColor] andiconSize:20];
    [self.sendLb LabelWithIconStr:@"\U0000e7b2" inIcon:iconfont andSize:CGSizeMake(20, 20) andColor:[UIColor lightGrayColor] andiconSize:20];


    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)SelctShip:(UIButton *)sender {
    self.slectShip();
}
- (IBAction)selctYouhui:(UIButton *)sender {
    self.slectyouhui();
}

- (IBAction)slectShip:(id)sender {
    self.checkboxSelct();
   // self.slectShip();
}
- (IBAction)selectPick:(UIButton *)sender {
    self.slectPick();
}
- (IBAction)selectUserMoney:(UIButton *)sender {
    self.sleectUserMoney();
}
//选择自提
- (IBAction)pickself:(UIButton *)sender {
    self.slectPick();
}
//选择配送
- (IBAction)send:(UIButton *)sender {
    self.slectShip();
}
@end
