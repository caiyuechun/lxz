//
//  ConpoussCell.m
//  乐享租
//
//  Created by caiyc on 18/5/15.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "ConpoussCell.h"

@implementation ConpoussCell
- (IBAction)get:(UIButton *)sender {
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = viewcontrollerColor;
    self.content_View.layer.cornerRadius = 5;
    self.content_View.layer.masksToBounds = 1;
    self.logoY_Lab.textColor = PRICECOLOR;
    self.logoY_Lab.layer.borderColor = PRICECOLOR.CGColor;
    self.logoY_Lab.layer.cornerRadius = 10;
    self.logoY_Lab.layer.borderWidth = 1;
    self.price_Lab.textColor = PRICECOLOR;
    self.use_Btn.hidden = 1;
   // self.price_Lab.font = [UIFont fontWithName:iconfont size:<#(CGFloat)#>];
    // Initialization code
}
-(void)bindData:(NSDictionary *)dic{
    if([dic[@"type"]isEqualToString:@"0"]){
       // self.use_Btn.hidden = 0;
    }
    NSString*price = [NSString stringWithFormat: @"%@元",dic[@"money"]];
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:price ];
    [AttributedStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:ICONNAME size:20] range:NSMakeRange(0, price.length-1)];
    self.price_Lab.attributedText = AttributedStr;
    self.condition_Lab.text = [NSString stringWithFormat:@"满%@元使用",dic[@"condition"]];
    self.timeout_Lab.text = [NSString stringWithFormat:@"%@到期",dic[@"use_end_time"]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
