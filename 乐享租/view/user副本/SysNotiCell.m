//
//  SysNotiCell.m
//  乐享租
//
//  Created by caiyc on 18/5/3.
//  Copyright © 2018年 changce. All rights reserved.
//   系统消息

#import "SysNotiCell.h"

@implementation SysNotiCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.icon_Lab LabelWithIconStr:@"\U0000e639" inIcon:iconfont andSize:CGSizeMake(20, 20) andColor:BASE_GRAY_COLOR andiconSize:20];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
