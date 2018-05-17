//
//  GroupCell.m
//  SHOP
//
//  Created by caiyc on 16/12/1.
//  Copyright © 2016年 changce. All rights reserved.
//  分类内容

#import "GroupCell.h"

@implementation GroupCell
- (IBAction)clickItem:(UIButton *)sender {
   // self.click();
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)bindData:(NSDictionary *)diction
{
    //NSString *imageUrl = [NSString stringWithFormat:@"%@%@",BASE_PATH,diction[@"image"]];
//    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_SERVICE, diction[@"image"]];
    self.button.userInteractionEnabled = 0;
    NSString *url = [NSString stringWithFormat:@"%@", diction[@"image"]];
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"logo180"]];
    self.iconImage.userInteractionEnabled = 0;
    self.name.text = diction[@"name"];
}
@end
