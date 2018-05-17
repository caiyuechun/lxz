//
//  ShipTrakCell.m
//  SHOP
//
//  Created by caiyc on 17/3/28.
//  Copyright © 2017年 changce. All rights reserved.
//

#import "ShipTrakCell.h"

@implementation ShipTrakCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.cicleLb.layer.cornerRadius = 8;
    self.cicleLb.layer.masksToBounds = 1;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
