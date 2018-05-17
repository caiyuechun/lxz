//
//  RetOrderCells.m
//  乐享租
//
//  Created by caiyc on 18/5/8.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "RetOrderCells.h"

@implementation RetOrderCells

- (void)awakeFromNib {
    [super awakeFromNib];
    self.images.contentMode = UIViewContentModeScaleAspectFit;
    // Initialization code
}
-(void)bindData:(NSDictionary *)diction
{
    
    self.order_Sn.text = [NSString stringWithFormat:@"订单编号：%@",diction[@"order_sn"]];
    self.reason_Lab.text = [NSString stringWithFormat:@"备注：%@", diction[@"reason"]];
    [self.images sd_setImageWithURL:[NSURL URLWithString:diction[@"img"]] placeholderImage:nil];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
