//
//  SocailNoImgCell.m
//  乐享租
//
//  Created by caiyc on 18/5/11.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "SocailNoImgCell.h"

@implementation SocailNoImgCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    [self.like_Lab LabelWithIconStr:@"\U0000e618" inIcon:iconfont andSize:CGSizeMake(15, 15) andColor:BASE_GRAY_COLOR andiconSize:15];
    [self.seeCount_Lab LabelWithIconStr:@"\U0000e6cf" inIcon:iconfont andSize:CGSizeMake(15, 15) andColor:BASE_GRAY_COLOR andiconSize:15];
    // Initialization code
}
-(void)bindData:(NSDictionary *)dic{
//    if([dic[@"thumb"]isEqualToString:@""]){
//        self.moveView.frame = CGRectMake(8, 0, screen_width-16, self.moveView.frame.size.height);
//        self.thunm.frame = CGRectMake(0, 0, screen_width, 0);
//    }else{
//        [self.thunm sd_setImageWithURL:[NSURL URLWithString:dic[@"thumb"]] placeholderImage:nil];
//    }
    self.title.text = dic[@"title"];
    self.time.text = [NSString stringWithFormat:@"%@", dic[@"add_time"]];
    self.like_Count.text = [NSString stringWithFormat:@"%@",dic[@"hot"]];
    self.see_Count.text =  [NSString stringWithFormat:@"%@",dic[@"click"]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
