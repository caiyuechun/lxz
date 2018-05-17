//
//  ProcssCell.m
//  乐享租
//
//  Created by caiyc on 18/3/23.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "ProcssCell.h"

@implementation ProcssCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
