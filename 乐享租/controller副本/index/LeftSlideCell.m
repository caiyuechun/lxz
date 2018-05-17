//
//  LeftSlideCell.m
//  乐享租
//
//  Created by caiyc on 18/5/10.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "LeftSlideCell.h"

@implementation LeftSlideCell

- (void)awakeFromNib {
    [super awakeFromNib];
    NSInteger sizeX = 25;
    
    UIColor *icon_Color = BASE_GRAY_COLOR;
    [self.shop_Icon LabelWithIconStr:@"\U0000e611" inIcon:iconfont andSize:CGSizeMake(sizeX, sizeX) andColor:icon_Color andiconSize:sizeX];
    
     [self.order_Icon LabelWithIconStr:@"\U0000e87d" inIcon:iconfont andSize:CGSizeMake(sizeX, sizeX) andColor:icon_Color andiconSize:sizeX];
    
      [self.money_Icon LabelWithIconStr:@"\U0000e87d" inIcon:iconfont andSize:CGSizeMake(sizeX, sizeX) andColor:icon_Color andiconSize:sizeX];
    
      [self.noti_Icon LabelWithIconStr:@"\U0000e610" inIcon:iconfont andSize:CGSizeMake(sizeX, sizeX) andColor:icon_Color andiconSize:sizeX];

    self.shop_Num.layer.masksToBounds = 1;
    self.shop_Num.layer.cornerRadius = 10;
    self.shop_Num.hidden = 1;
    
    self.order_Num.layer.masksToBounds = 1;
    self.order_Num.layer.cornerRadius = 10;
    self.order_Num.hidden = 1;
    
    self.noti_Num.layer.masksToBounds = 1;
    self.noti_Num.layer.cornerRadius = 10;
    self.noti_Num.hidden = 1;
    

     
    
    self.icon_Img.layer.masksToBounds = 1;
    self.icon_Img.layer.cornerRadius = 30;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)leftAction:(UIButton *)sender {
    self.leftActions(sender.tag);
}
@end
