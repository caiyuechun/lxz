//
//  Socail_ComentCell.m
//  乐享租
//
//  Created by caiyc on 18/3/14.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "Socail_ComentCell.h"

@implementation Socail_ComentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    self.icon_Img.layer.masksToBounds = 1;
    self.icon_Img.layer.cornerRadius = 25;
    // Initialization code
}
-(void)bindData:(NSDictionary *)dic{
    [self.icon_Img sd_setImageWithURL:[NSURL URLWithString:dic[@"head_pic"]] placeholderImage:nil];
    self.timeLabel.text = [NSString stringWithFormat:@"%@",dic[@"add_time"]];
    self.nickName.text = dic[@"nickname"];
    self.content.text = dic[@"content"];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
