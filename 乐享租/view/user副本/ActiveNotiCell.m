//
//  ActiveNotiCell.m
//  乐享租
//
//  Created by caiyc on 18/5/3.
//  Copyright © 2018年 changce. All rights reserved.
//  活动通知

#import "ActiveNotiCell.h"

@implementation ActiveNotiCell

- (void)awakeFromNib {
    [super awakeFromNib];
     self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.thumb.frame = CGRectMake(8, 8, screen_width-16, 160);
    [self.thumb setContentScaleFactor:[[UIScreen mainScreen] scale]];
    self.thumb.contentMode =  UIViewContentModeScaleAspectFill;
    self.thumb.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.thumb.clipsToBounds  = YES;

    // Initialization code
}
-(void)bindData:(NSDictionary *)dic{
    [self.thumb sd_setImageWithURL:[NSURL URLWithString:dic[@"thumb"]] placeholderImage:nil];
    self.time_Lab.text = [NSString stringWithFormat:@"活动时间：%@",dic[@"publish_time"]];
    self.title_Lab.text = dic[@"title"];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
