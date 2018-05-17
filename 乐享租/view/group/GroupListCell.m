//
//  GroupListCell.m
//  SHOP
//
//  Created by caiyc on 16/12/1.
//  Copyright © 2016年 changce. All rights reserved.
//

#import "GroupListCell.h"

@implementation GroupListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectview.backgroundColor = BASE_COLOR;
   // self.selectview.hidden = 1;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
