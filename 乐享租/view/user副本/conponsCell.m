//
//  conponsCell.m
//  chuangyi
//
//  Created by caiyc on 17/9/7.
//  Copyright © 2017年 changce. All rights reserved.
//

#import "conponsCell.h"

@implementation conponsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.rightView.layer.borderColor = RGB(200, 200, 200).CGColor;
    self.rightView.layer.borderWidth = 0.8;
    // Initialization code
}
-(void)bindData:(NSDictionary *)dic AndType:(NSString *)types
{
    if([types isEqualToString:@"0"]){
        self.userBtn.hidden = 0;
       
    }else{
        self.userBtn.hidden = 1;
    }
    
    if([types isEqualToString:@"1"]){
        self.mutaLb.text = @"使用时间";
        self.statime.text =[NSString stringWithFormat:@"%@", dic[@"use_time"]];
    }else{
        self.mutaLb.text = @"开始时间";
        self.statime.text =[NSString stringWithFormat:@"%@", [self datesToString: dic[@"send_time"]]];
    }
    self.value.text = [NSString stringWithFormat:@"¥%@",dic[@"money"]];
    self.name.text = dic[@"name"];
    self.sendtime.text =[NSString stringWithFormat:@"%@", dic[@"send_time"]];
    
  //  NSString *statime = [XTool currentDateWithFormat: [NSString stringWithFormat:@"%@", dic[@"use_time"]]];
    
   
    self.endtime.text = [NSString stringWithFormat:@"%@", dic[@"use_end_time"]];
    self.condition.text = [NSString stringWithFormat:@"满%@元使用",dic[@"condition"]];
   //  [self.userBtn setTitle:@"立即领取" forState:UIControlStateNormal];
    //    self.statime.text = [NSDate dateChangetime:dic[@"send_time"]];
    //    self.endtime.text = [NSDate dateChangetime:dic[@"use_end_time"]];
//    NSString *start = [self datesToString:dic[@"use_start_time"]];
//    NSString *end =[self datesToString:dic[@"use_end_time"]];
    self.timess.hidden = 1;
//    if([types integerValue]==0)
//    {
       self.botomImg.image = [UIImage imageNamed:@"优惠券@3x_03"];
//    }else
//    {
//        if([types isEqualToString:@"1"]||[types isEqualToString:@"2"])
//        {
//            self.statusImg.image = [UIImage imageNamed:@"状态@3x_03"];
//        }else
//        {
           self.statusImg.image = [UIImage imageNamed:@"状态@3x_06"];
//        }
//        self.botomImg.image = [UIImage imageNamed:@"优惠券@3x_06"];
//        [self.userBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//        self.userBtn.userInteractionEnabled = 0;
//        [self.userBtn setTitle:@"已使用" forState:UIControlStateNormal];
//    }
//    if([types isEqualToString:@""])
//    {
//        [self.userBtn setTitle:@"立即领取" forState:UIControlStateNormal];
//        self.statusImg.image = [UIImage imageNamed:@"状态@3x_06"];
//    }
}

-(void)bindData:(NSDictionary *)dic andType:(NSString *)types
{
    self.value.text = [NSString stringWithFormat:@"%@",dic[@"money"]];
    self.name.text = dic[@"name"];
    self.condition.text = [NSString stringWithFormat:@"订单满%@元使用",dic[@"condition"]];
//    self.statime.text = [NSDate dateChangetime:dic[@"send_time"]];
//    self.endtime.text = [NSDate dateChangetime:dic[@"use_end_time"]];
    NSString *start = [self datesToString:dic[@"use_start_time"]];
    NSString *end =[self datesToString:dic[@"use_end_time"]];
    self.timess.text = [NSString stringWithFormat:@"%@-%@",start,end];
    if([types integerValue]==0)
    {
        self.botomImg.image = [UIImage imageNamed:@"优惠券@3x_03"];
    }else 
    {
        if([types isEqualToString:@"1"]||[types isEqualToString:@"2"])
        {
            self.statusImg.image = [UIImage imageNamed:@"状态@3x_03"];
        }else
        {
            self.statusImg.image = [UIImage imageNamed:@"状态@3x_06"];
        }
         self.botomImg.image = [UIImage imageNamed:@"优惠券@3x_06"];
//        [self.userBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        self.userBtn.userInteractionEnabled = 0;
     //   [self.userBtn setTitle:@"已使用" forState:UIControlStateNormal];
    }
    if([types isEqualToString:@""])
    {
//        [self.userBtn setTitle:@"立即领取" forState:UIControlStateNormal];
         self.statusImg.image = [UIImage imageNamed:@"状态@3x_06"];
    }
}
-(NSString *)datesToString:(NSString *)str
{
    NSTimeInterval time =[str doubleValue];//因为时差问题要加8小时 == 28800 sec
    
    NSDate*detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    
    //    NSLog(@"date:%@",[detaildate description]);
    
    //实例化一个NSDateFormatter对象
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    //设定时间格式,这里可以设置成自己需要的格式
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString*currentDateStr = [dateFormatter stringFromDate:detaildate];
    return currentDateStr;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)use:(UIButton *)sender {
    self.use();
}
@end
