//
//  GoodListTableViewCell.m
//  chuangyi
//
//  Created by yncc on 17/8/8.
//  Copyright © 2017年 changce. All rights reserved.
//

#import "GoodListTableViewCell.h"

@implementation GoodListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)bindData:(NSDictionary *)dicInfo{
    [_goodIcon sd_setImageWithURL:[NSURL URLWithString:[dicInfo objectForKey:@"original_img"]] placeholderImage:[UIImage imageNamed:@"goods_icon"]];
    [_goodName setText:[dicInfo objectForKey:@"goods_name"]];
    [_goodDescribe setText:[dicInfo objectForKey:@"goods_remark"]];
    [_goodPrice setText:[NSString stringWithFormat:@"￥%@",[dicInfo objectForKey:@"shop_price"]]];
    [_goodScals setText:[NSString stringWithFormat:@"月销：%@",[dicInfo objectForKey:@"sales_sum"]]];
    
}

@end
