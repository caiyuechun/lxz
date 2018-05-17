//
//  Index_RecomdCell.m
//  乐享租
//
//  Created by caiyc on 18/3/15.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "Index_RecomdCell.h"

@implementation Index_RecomdCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    self.price_Lab.textColor = PRICE_COLOR;
    self.oldPrice_Lab.textColor = PRICE_COLOR;
    // Initialization code
}
-(void)bindData:(NSDictionary *)dic{
    [self.img sd_setImageWithURL:[NSURL URLWithString:dic[@"original_img"]] placeholderImage:nil];
    self.name.text = dic[@"goods_name"];
    self.price_Lab.text = [NSString stringWithFormat:@"¥%@/月",dic[@"shop_price"]];
    self.percent.text = dic[@"newold"];
    self.desc.text = dic[@"goods_remark"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
