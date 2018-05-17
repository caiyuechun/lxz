//
//  IntergerCell.m
//  SHOP
//
//  Created by caiyc on 17/4/12.
//  Copyright © 2017年 changce. All rights reserved.
//

#import "IntergerCell.h"

@implementation IntergerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)bindData:(NSDictionary *)diction
{
    self.descLb.text = diction[@"desc"];
    self.timeLb.text = diction[@"change_time"];
    self.scro.text = [NSString stringWithFormat:@"+ %@",diction[@"pay_points"]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
