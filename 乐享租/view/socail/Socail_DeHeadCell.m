//
//  Socail_DeHeadCell.m
//  乐享租
//
//  Created by caiyc on 18/3/14.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "Socail_DeHeadCell.h"

@implementation Socail_DeHeadCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
       [self.seeCount_Lab LabelWithIconStr:@"\U0000e6cf" inIcon:iconfont andSize:CGSizeMake(15, 15) andColor:BASE_GRAY_COLOR andiconSize:15];
    // Initialization code
}
-(void)bindData:(NSDictionary *)dic{
    self.time_lab.text = [NSString stringWithFormat:@"%@",dic[@"publish_time"]];
    self.title_Lab.text = dic[@"title"];
    self.see_Count.text = [NSString stringWithFormat:@"%@",dic[@"click"]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
