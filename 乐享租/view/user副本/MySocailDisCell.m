//
//  MySocailDisCell.m
//  乐享租
//
//  Created by caiyc on 18/5/3.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "MySocailDisCell.h"

@implementation MySocailDisCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.check_Lab LabelWithIconStr:@"\U0000e606" inIcon:iconfont andSize:CGSizeMake(20, 20) andColor:BASE_GRAY_COLOR andiconSize:20];
    // Initialization code
}
-(void)bindData:(NSDictionary *)dic{
    NSString *str = dic[@"isselect"];
    if([str isEqualToString:@"0"]){
       // [dic setObject:@"1" forKey:@"isselect"];
        self.check_Lab.textColor = BASE_GRAY_COLOR;
    }else{
     //   [dic setObject:@"0" forKey:@"isselect"];
        self.check_Lab.textColor = BUTTON_COLOR;
    }

    [self.thumb sd_setImageWithURL:[NSURL URLWithString:dic[@"thumb"]] placeholderImage:nil];
    self.time_Lab.text = dic[@"publish_time"];
    self.title_Lab.text = dic[@"title"];
    self.cat_Name.text = [NSString stringWithFormat:@"文章分类：%@",dic[@"catename"]];
    self.coment_Lab.text =dic[@"newcoment"];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)select:(UIButton *)sender {
    self.check();
}
@end
