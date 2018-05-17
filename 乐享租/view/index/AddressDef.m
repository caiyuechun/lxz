//
//  AddressDef.m
//  chuangyi
//
//  Created by caiyc on 17/8/9.
//  Copyright © 2017年 changce. All rights reserved.
//

#import "AddressDef.h"

@implementation AddressDef

- (void)awakeFromNib {
    [super awakeFromNib];
    //self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.defLb.layer.borderColor = BASE_COLOR.CGColor;
    self.defLb.layer.borderWidth = 0.8;
    self.defLb.textColor = BASE_COLOR;
    self.noAdd.hidden = 1;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click)];
    [self addGestureRecognizer:tap];
    // Initialization code
}
-(void)click
{
    self.clicks();
}
-(void)bindData:(NSDictionary *)dic
{
    NSLog(@"....dizhi...%@",dic[@"provincename"]);
    self.name.text = dic[@"consignee"];
    self.phone.text = dic[@"mobile"];
    self.address.text =[NSString stringWithFormat:@"%@%@%@%@",dic[@"provincename"],dic[@"cityname"] ,dic[@"districtname"],dic[@"address"]];
    if([dic[@"is_default"]boolValue]==0)
    {
        self.defLb.hidden = 1;
    }
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
