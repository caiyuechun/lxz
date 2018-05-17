//
//  OrderCell.m
//  chuangyi
//
//  Created by caiyc on 17/8/10.
//  Copyright © 2017年 changce. All rights reserved.
//

#import "OrderCell.h"

@implementation OrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
   self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.handleleft.backgroundColor = BASE_COLOR;
    [self.handleleft setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.handelright.layer.borderColor = viewcontrollerColor.CGColor;
    self.handelright.layer.borderWidth = 0.8;
    [self.handelright setTitleColor:BASE_COLOR forState:UIControlStateNormal];
    self.move_View.hidden = 1;
    self.image.contentMode = UIViewContentModeScaleAspectFit;
    // Initialization code
}
-(void)bindData:(NSDictionary *)diction
{
    
    self.orderSn.text = [NSString stringWithFormat:@"订单编号：%@",diction[@"order_sn"]];
    self.orderStatus.text = diction[@"order_status_desc"];
//    NSString *leftStr = @"";
//    NSString *rightStr = @"";
//    if([diction[@"order_status_code"]isEqualToString:@"CANCEL"])
//    {
//        self.handleleft.hidden = 1;
//        self.handelright.hidden = 1;
//    }
//    if([diction[@"order_status_desc"]isEqualToString:@"待付款"])
//    {
//        leftStr = @"去付款";
//        rightStr = @"取消订单";
//    }
//    if([diction[@"order_status_desc"]isEqualToString:@"待发货"]||[diction[@"order_status_desc"]isEqualToString:@"已完成"])
//    {
//        self.handleleft.hidden = 1;
//        self.handelright.hidden = 1;
//    }
//    if([diction[@"order_status_desc"]isEqualToString:@"待收货"])
//    {
//        rightStr = @"确认收货";
//        leftStr = @"查看物流";
//    }
//    if([diction[@"order_status_desc"]isEqualToString:@"待评价"])
//    {
//        BOOL showCom = 0;
//        for(int i =0;i<[diction[@"goods_list"]count];i++)
//        {
//            NSDictionary *goods = diction[@"goods_list"][i];
//            if([goods[@"is_comment"]boolValue]==0)
//            {
//                showCom = 1;
//            }
//        }
//        rightStr = @"评价";
//        if(!showCom)
//        {
//            self.handelright.hidden = 1;
//        }
//        self.handleleft.hidden = 1;
//       // leftStr = @"退货";
//    }
//    [self.handleleft setTitle:leftStr forState:UIControlStateNormal];
//    [self.handelright setTitle:rightStr forState:UIControlStateNormal];
    NSDictionary *goodDic = diction[@"goods_list"][0];
  //  NSString *url = [NSString stringWithFormat:@"%@%@",BASE_SERVICE,goodDic[@"original_img"]];
     NSString *url = [NSString stringWithFormat:@"%@",goodDic[@"original_img"]];
    [self.image sd_setImageWithURL:[NSURL URLWithString:url]];
    self.name.text = goodDic[@"goods_name"];
    self.status.text = diction[@"order_status_desc"];
    self.status.textColor = PRICE_COLOR;
    self.price.textColor = PRICE_COLOR;
//    CGFloat totals = [diction[@"total_amount"]floatValue]- [diction[@"coupon_price"]floatValue];
//    self.price.text = [NSString stringWithFormat:@"合计：¥%.2f",totals];
  //  self.price.text = [NSString stringWithFormat:@"合计：¥%@",diction[@"order_amount"]];
    NSString*price = [NSString stringWithFormat:@"合计：¥%@",diction[@"order_amount"]];
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:price ];
    [AttributedStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:ICONNAME size:14] range:NSMakeRange(0, price.length)];
    self.price.attributedText = AttributedStr;

   // self.num.text = [NSString stringWithFormat:@"共%@件商品",diction[@"goodsnum"]];
    self.num.text = [NSString stringWithFormat:@"共%lu件商品",[diction[@"goods_list"]count]];
   
        for(UIView *ve in self.move_View.subviews ){
            [ve removeFromSuperview];
        }
        UIView *handelView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, 100)];
        handelView.userInteractionEnabled = 1;
     //   handelView.backgroundColor = [UIColor grayColor];
        UILabel *totals = [[UILabel alloc]initWithFrame:CGRectMake(screen_width-200, 0, 190, 40)];
        totals.textAlignment = NSTextAlignmentRight;
        totals.attributedText = AttributedStr;
        totals.textColor = PRICECOLOR;
        [handelView addSubview:totals];
    if([diction[@"order_status"]integerValue]==0&&[diction[@"pay_status"]integerValue]==0){
        //待付款
        UIButton *paybtn = [UIButton buttonWithType:UIButtonTypeCustom];
        paybtn.frame = CGRectMake(screen_width-110, 52, 100, 36);
        [paybtn setTitle:@"去支付" forState:UIControlStateNormal];
        paybtn.backgroundColor = PRICECOLOR;
        paybtn.layer.cornerRadius = 18;
        paybtn.layer.masksToBounds = 1;
        paybtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [paybtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.frame = CGRectMake(screen_width-240, 52, 100, 36);
        [cancelBtn setTitle:@"取消订单" forState:UIControlStateNormal];
       // cancelBtn.backgroundColor = PRICECOLOR;
        cancelBtn.layer.cornerRadius = 18;
        cancelBtn.layer.masksToBounds = 1;
        cancelBtn.layer.borderWidth = 1;
        cancelBtn.layer.borderColor = RGB(200, 200, 200).CGColor;
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [cancelBtn setTitleColor:RGB(200, 200, 200) forState:UIControlStateNormal];
        [handelView addSubview:paybtn];
        [handelView addSubview:cancelBtn];
        paybtn.userInteractionEnabled = 1;
        cancelBtn.userInteractionEnabled = 1;
        
        [paybtn addTarget:self action:@selector(handeAction:) forControlEvents:UIControlEventTouchUpInside];
        [cancelBtn addTarget:self action:@selector(handeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    if([diction[@"order_status"]integerValue]<2&&[diction[@"pay_status"]integerValue]==1){
        //代收货
        //order_status
        UIButton *paybtn = [UIButton buttonWithType:UIButtonTypeCustom];
        paybtn.frame = CGRectMake(screen_width-110, 52, 100, 36);
        [paybtn setTitle:@"确认收货" forState:UIControlStateNormal];
        paybtn.backgroundColor = PRICECOLOR;
        paybtn.layer.cornerRadius = 18;
        paybtn.layer.masksToBounds = 1;
        paybtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [paybtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.frame = CGRectMake(screen_width-240, 52, 100, 36);
        [cancelBtn setTitle:@"物流查询" forState:UIControlStateNormal];
        // cancelBtn.backgroundColor = PRICECOLOR;
        cancelBtn.layer.cornerRadius = 18;
        cancelBtn.layer.masksToBounds = 1;
        cancelBtn.layer.borderWidth = 1;
        cancelBtn.layer.borderColor = RGB(200, 200, 200).CGColor;
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [cancelBtn setTitleColor:RGB(200, 200, 200) forState:UIControlStateNormal];
        
        UIButton *cancelBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn1.frame = CGRectMake(screen_width-360, 52, 100, 36);
        [cancelBtn1 setTitle:@"取消购买" forState:UIControlStateNormal];
        // cancelBtn.backgroundColor = PRICECOLOR;
        cancelBtn1.layer.cornerRadius = 18;
        cancelBtn1.layer.masksToBounds = 1;
        cancelBtn1.layer.borderWidth = 1;
        cancelBtn1.layer.borderColor = RGB(200, 200, 200).CGColor;
        cancelBtn1.titleLabel.font = [UIFont systemFontOfSize:15];
        [cancelBtn1 setTitleColor:RGB(200, 200, 200) forState:UIControlStateNormal];

        if([diction[@"gtype"]integerValue]==0||[diction[@"gtype"]integerValue]==2){
            [handelView addSubview:paybtn];
            [handelView addSubview:cancelBtn];
            if([diction[@"return"]integerValue]==1&&[diction[@"gtype"]integerValue]==0){
                [cancelBtn1 setTitle:@"归还" forState:UIControlStateNormal];
                [handelView addSubview:cancelBtn1];
            }
        }else{
        if([diction[@"gtype"]integerValue]==1&&[diction[@"surebuy"]integerValue]==1){
            //二手产品
           [cancelBtn setTitle:@"确认购买" forState:UIControlStateNormal];
            [paybtn setTitle:@"审核报告" forState:UIControlStateNormal];
            [handelView addSubview:paybtn];
            [handelView addSubview:cancelBtn];
            [handelView addSubview:cancelBtn1];
            
        }
        }

    
      
        
        [paybtn addTarget:self action:@selector(handeAction:) forControlEvents:UIControlEventTouchUpInside];
        [cancelBtn addTarget:self action:@selector(handeAction:) forControlEvents:UIControlEventTouchUpInside];
         [cancelBtn1 addTarget:self action:@selector(handeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    if([diction[@"order_status"]integerValue]==2){
        //已收货
        UIButton *paybtn = [UIButton buttonWithType:UIButtonTypeCustom];
        paybtn.frame = CGRectMake(screen_width-110, 52, 100, 36);
        [paybtn setTitle:@"评价" forState:UIControlStateNormal];
        paybtn.backgroundColor = PRICECOLOR;
        paybtn.layer.cornerRadius = 18;
        paybtn.layer.masksToBounds = 1;
        paybtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [paybtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.frame = CGRectMake(screen_width-240, 52, 100, 36);
        [cancelBtn setTitle:@"归还" forState:UIControlStateNormal];
        // cancelBtn.backgroundColor = PRICECOLOR;
        cancelBtn.layer.cornerRadius = 18;
        cancelBtn.layer.masksToBounds = 1;
        cancelBtn.layer.borderWidth = 1;
        cancelBtn.layer.borderColor = RGB(200, 200, 200).CGColor;
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [cancelBtn setTitleColor:RGB(200, 200, 200) forState:UIControlStateNormal];
        
        UIButton *cancelBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn1.frame = CGRectMake(screen_width-360, 52, 100, 36);
        [cancelBtn1 setTitle:@"续租" forState:UIControlStateNormal];
        // cancelBtn.backgroundColor = PRICECOLOR;
        cancelBtn1.layer.cornerRadius = 18;
        cancelBtn1.layer.masksToBounds = 1;
        cancelBtn1.layer.borderWidth = 1;
        cancelBtn1.layer.borderColor = RGB(200, 200, 200).CGColor;
        cancelBtn1.titleLabel.font = [UIFont systemFontOfSize:15];
        [cancelBtn1 setTitleColor:RGB(200, 200, 200) forState:UIControlStateNormal];
        
        if([diction[@"gtype"]integerValue]==0&&[diction[@"renew"]integerValue]==1){
            //租赁产品
           //  [handelView addSubview:cancelBtn];
             [handelView addSubview:cancelBtn1];
            
        }
        if([diction[@"gtype"]integerValue]==0&&[diction[@"return"]integerValue]==1){
            //租赁产品
            [handelView addSubview:cancelBtn];
       //  [handelView addSubview:cancelBtn1];
            
        }

        
        [handelView addSubview:paybtn];
      
        
        
        [paybtn addTarget:self action:@selector(handeAction:) forControlEvents:UIControlEventTouchUpInside];
        [cancelBtn addTarget:self action:@selector(handeAction:) forControlEvents:UIControlEventTouchUpInside];
         [cancelBtn1 addTarget:self action:@selector(handeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    if([diction[@"order_status"]integerValue]>3){
        //已完成
        UIButton *paybtn = [UIButton buttonWithType:UIButtonTypeCustom];
        paybtn.frame = CGRectMake(screen_width-110, 52, 100, 36);
        [paybtn setTitle:@"续租" forState:UIControlStateNormal];
        paybtn.backgroundColor = PRICECOLOR;
        paybtn.layer.cornerRadius = 18;
        paybtn.layer.masksToBounds = 1;
        paybtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [paybtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.frame = CGRectMake(screen_width-240, 52, 100, 36);
        [cancelBtn setTitle:@"购买" forState:UIControlStateNormal];
        // cancelBtn.backgroundColor = PRICECOLOR;
        cancelBtn.layer.cornerRadius = 18;
        cancelBtn.layer.masksToBounds = 1;
        cancelBtn.layer.borderWidth = 1;
        cancelBtn.layer.borderColor = RGB(200, 200, 200).CGColor;
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [cancelBtn setTitleColor:RGB(200, 200, 200) forState:UIControlStateNormal];
        
        UIButton *cancelBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn1.frame = CGRectMake(screen_width-360, 52, 100, 36);
        [cancelBtn1 setTitle:@"归还" forState:UIControlStateNormal];
        // cancelBtn.backgroundColor = PRICECOLOR;
        cancelBtn1.layer.cornerRadius = 18;
        cancelBtn1.layer.masksToBounds = 1;
        cancelBtn1.layer.borderWidth = 1;
        cancelBtn1.layer.borderColor = RGB(200, 200, 200).CGColor;
        cancelBtn1.titleLabel.font = [UIFont systemFontOfSize:15];
        [cancelBtn1 setTitleColor:RGB(200, 200, 200) forState:UIControlStateNormal];

        if([diction[@"gtype"]integerValue]==0&&[diction[@"renew"]integerValue]==1){
            //租赁产品
            [handelView addSubview:cancelBtn];
              [handelView addSubview:paybtn];
            
        }
        if([diction[@"gtype"]integerValue]==0&&[diction[@"return"]integerValue]==1){
            //租赁产品
            [handelView addSubview:cancelBtn1];
          //  [handelView addSubview:paybtn];
            
        }
        
        
      
        
        
        
        [paybtn addTarget:self action:@selector(handeAction:) forControlEvents:UIControlEventTouchUpInside];
        [cancelBtn addTarget:self action:@selector(handeAction:) forControlEvents:UIControlEventTouchUpInside];
        [cancelBtn1 addTarget:self action:@selector(handeAction:) forControlEvents:UIControlEventTouchUpInside];

    
    }
//    if([diction[@"order_status"]integerValue]==4){
//    //已完成
//        
//    }

    
        CGRect oldRct = self.move_View.frame;
        self.move_View.hidden = 0;
        if([diction[@"gtype"]integerValue]==0){
        //租赁订单
            if([diction[@"deductibles"]integerValue]==1){
            //免赔服务展示
                self.move_View.frame = CGRectMake(oldRct.origin.x, oldRct.origin.y, oldRct.size.width, 150);
                UILabel *mianpei = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 200, 50)];
                mianpei.text = @"免赔服务";
                mianpei.font = [UIFont systemFontOfSize:14];
                mianpei.textColor = RGB(100, 100, 100);
                [self.move_View addSubview:mianpei];
                UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(screen_width-80, 0, 70, 25)];
                lab.text = [NSString stringWithFormat: @"x%@",diction[@"goods_num"]];
                lab.textAlignment = NSTextAlignmentRight;
                lab.font = [UIFont systemFontOfSize:14];
                lab.textColor = RGB(100, 100, 100);
                
                UILabel *labs = [[UILabel alloc]initWithFrame:CGRectMake(screen_width-80, 25, 70, 25)];
                labs.text = [NSString stringWithFormat: @"x%@",diction[@"deductibles_price"]];
                labs.textAlignment = NSTextAlignmentRight;
                labs.font = [UIFont systemFontOfSize:14];
                labs.textColor = RGB(100, 100, 100);
                
                UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, screen_width-20, 1)];
                line.backgroundColor = viewcontrollerColor;
                
                
                [self.move_View addSubview:labs];
                [self.move_View addSubview:lab];
                [self.move_View addSubview:line];
                
                handelView.frame = CGRectMake(0, 51, screen_width, 100);
                [self.move_View addSubview:handelView];


            }else{
            //无免赔服务
                 self.move_View.frame = CGRectMake(self.move_View.frame.origin.x, self.move_View.frame.origin.y, self.move_View.frame.size.width, 100);
                handelView.frame = CGRectMake(0, 0, screen_width, 100);
                [self.move_View addSubview:handelView];

            }
        }else{
            self.move_View.frame = CGRectMake(self.move_View.frame.origin.x, self.move_View.frame.origin.y, self.move_View.frame.size.width, 100);
            handelView.frame = CGRectMake(0, 0, screen_width, 100);
            [self.move_View addSubview:handelView];

        }
   
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)handeAction:(UIButton *)sender{
    self.handel(sender);
}
//- (IBAction)leftAction:(UIButton *)sender {
//    self.handel(sender);
//    
//}
//- (IBAction)rightAction:(UIButton *)sender {
//     self.handel(sender);
//}
@end
