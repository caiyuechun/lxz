//
//  AssitCell.m
//  乐享租
//
//  Created by caiyc on 18/3/22.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "AssitCell.h"

@implementation AssitCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    [self.right_Lab LabelWithIconStr:@"\U0000e688" inIcon:iconfont andSize:CGSizeMake(20, 20) andColor:BASE_GRAY_COLOR andiconSize:20];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
