//
//  MessCommentCell.m
//  乐享租
//
//  Created by caiyc on 18/3/24.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "MessCommentCell.h"

@implementation MessCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.icon_Img.layer.masksToBounds = 1;
    self.icon_Img.layer.cornerRadius = 25;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
