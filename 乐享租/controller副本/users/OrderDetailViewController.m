//
//  OrderDetailViewController.m
//  chuangyi
//
//  Created by caiyc on 17/8/10.
//  Copyright © 2017年 changce. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "OrdersnCell.h"
#import "OrderGoodsCell.h"
#import "OrderPriceInfoCell.h"
#import "PayViewController.h"
#import "ShipTrackViewController.h"
#import "CommetGoodViewController.h"
#import "ContiRentViewController.h"
#import "BuyRentViewController.h"
#import "PayZViewController.h"
@interface OrderDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSDictionary *orderDic;
@property(nonatomic,strong)NSMutableArray *goodsList;
@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNaviView:[UIColor whiteColor] hasLeft:1 leftColor:nil title:@"订单详情" titleColor:[UIColor blackColor] right:@"" rightColor:nil rightAction:nil];
    self.view.backgroundColor = viewcontrollerColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.goodsList = [NSMutableArray array];
    
    [self loadData];
      // Do any additional setup after loading the view from its nib.
}
-(void)loadData
{
    NSDictionary *param = @{@"user_id":[XTool GetDefaultInfo:USER_INFO][USER_ID],@"id":self.order_id};
    [self postWithURLString:@"/user/getorderdetail" parameters:param success:^(id response) {
        SLog(@"订单详情数据%@",response);
        if(response)
        {
            [self.goodsList removeAllObjects];
          //  [self.goodsList addObject:@"0"];
            self.orderDic = response[@"result"];
            for(int i=0;i<[self.orderDic[@"goods_list"]count];i++)
            {
                [ self.goodsList addObject:self.orderDic[@"goods_list"][i]];
            }
       //     [self.goodsList addObject:@"last"];
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];

}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(section==0)
    {
        return CGFLOAT_MIN;
    }else if (section==1)
    {
        return 100;
    }else return CGFLOAT_MIN;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if(section==1)
    {
        NSDictionary *diction = self.orderDic;
        UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, 100)];
//        UILabel *heji = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 50, 50)];
//        heji.text = @"合计：";
//        heji.font = [UIFont systemFontOfSize:15];
//        UILabel *pricetotal = [[UILabel alloc]initWithFrame:CGRectMake(60, 0, 100, 50)];
//        pricetotal.textColor = PRICE_COLOR;
//        pricetotal.font = [UIFont systemFontOfSize:15];
//     //   pricetotal.text = [NSString stringWithFormat:@"¥%@",self.orderDic[@"order_amount"]];
        NSString*price = [NSString stringWithFormat:@"合计：¥%@",self.orderDic[@"order_amount"]];
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:price ];
        [AttributedStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:ICONNAME size:16] range:NSMakeRange(0, price.length)];
//       pricetotal.attributedText = AttributedStr;
//
//        [footView addSubview:heji];
//        [footView addSubview:pricetotal];
        
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
        [footView addSubview:handelView];
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        btn.frame = CGRectMake(screen_width-85, 8, 77, 35);
//        btn.layer.borderColor = viewcontrollerColor.CGColor;
//        btn.layer.borderWidth = 0.8;
//        [btn setTitleColor:BASE_COLOR forState:UIControlStateNormal];
//
//        //[btn setTitle:@"支付" forState:UIControlStateNormal];
//        btn.titleLabel.font = [UIFont systemFontOfSize:15];
//       // btn.backgroundColor = BASE_COLOR;
//        [footView addSubview:btn];
//        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
//        btn1.frame = CGRectMake(screen_width-175, 8, 80, 35);
//        
//        btn1.titleLabel.font = [UIFont systemFontOfSize:15];
//        btn1.backgroundColor = BASE_COLOR;
//        [footView addSubview:btn1];
//        [btn addTarget:self action:@selector(handeOrder:) forControlEvents:UIControlEventTouchUpInside];
//        [btn1 addTarget:self action:@selector(handeOrder:) forControlEvents:UIControlEventTouchUpInside];
//        NSDictionary *diction = self.orderDic;
//        NSString *leftStr = @"";
//        NSString *rightStr = @"";
//        if([diction[@"order_status_code"]isEqualToString:@"CANCEL"])
//        {
//            btn1.hidden = 1;
//            btn.hidden = 1;
//        }
//        if([diction[@"order_status_desc"]isEqualToString:@"待支付"])
//        {
//            leftStr = @"去付款";
//            rightStr = @"取消订单";
//        }
//        if([diction[@"order_status_desc"]isEqualToString:@"待发货"]||[diction[@"order_status_desc"]isEqualToString:@"已完成"])
//        {
//            btn.hidden = 1;
//            btn1.hidden = 1;
//        }
//        if([diction[@"isreturn"]integerValue]==1)
//        {
//            btn.hidden = 1;
//            btn1.hidden = 1;
//
//        }
//
//
//        if([diction[@"order_status_desc"]isEqualToString:@"待收货"])
//        {
//            rightStr = @"确认收货";
//            leftStr = @"查看物流";
//            btn.backgroundColor = BASE_COLOR;
//            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//
//             btn1.hidden = 1;
//        }
//        if([diction[@"order_status_desc"]isEqualToString:@"待评价"])
//        {
//            BOOL showCom = 0;
//            for(int i =0;i<[diction[@"goods_list"]count];i++)
//            {
//                NSDictionary *goods = diction[@"goods_list"][i];
//                if([goods[@"is_comment"]boolValue]==0)
//                {
//                    showCom = 1;
//                }
//            }
//            rightStr = @"评价";
//            if(!showCom)
//            {
//                btn.hidden = 1;
//            }
//
//           rightStr = @"评价";
//           btn1.hidden = 1;
//        }
//        [btn1 setTitle:leftStr forState:UIControlStateNormal];
//        [btn setTitle:rightStr forState:UIControlStateNormal];
        
        return footView;
    }else return [[UIView alloc]initWithFrame:CGRectZero];
}

-(void)handeAction:(UIButton *)sender
{
    NSString *orderId = self.orderDic[@"order_id"];
    NSString *titles = sender.titleLabel.text;
    if([sender.titleLabel.text isEqualToString:@"去支付"])
    {
        
        NSInteger gtype = [self.orderDic[@"gtype"]integerValue];
        if(gtype==0){
            PayZViewController *vc = [[PayZViewController alloc]init];
            vc.orderStr = self.orderDic[@"order_sn"];
            vc.cashStr = self.orderDic[@"order_amount"];
            vc.order_Id = [NSString stringWithFormat:@"%@",self.orderDic[@"order_id"]];
            //  vc.order_Dic = self.orderDic;
            [self pushView:vc];

        }else{
        PayViewController *vc = [[PayViewController alloc]init];
        vc.orderStr = self.orderDic[@"order_sn"];
        vc.cashStr = self.orderDic[@"order_amount"];
        vc.order_Id = [NSString stringWithFormat:@"%@",self.orderDic[@"order_id"]];
      //  vc.order_Dic = self.orderDic;
        [self pushView:vc];
        }
        
    }
    if([titles isEqualToString:@"取消订单"])
    {
        [self cancelOrder:orderId];
    }
    if([titles isEqualToString:@"物流查询"])
    {
        [self checkShipwithCode:self.orderDic[@"shipping_code"] andShipNum:self.orderDic[@"invoice_no"]];
    }
    if([titles isEqualToString:@"确认收货"])
    {
        [self confirmOrder:orderId];
    }
    if([titles isEqualToString:@"评价"])
    {
        [self commentOrder:self.orderDic];
    }
    if([titles isEqualToString:@"退货"])
    {
        [self returnOrder:self.orderDic];
    }
    if([titles isEqualToString:@"归还"]){
     [self returnOrder:self.orderDic];
    }
    if([titles isEqualToString:@"购买"]){
        [self buyRent:self.orderDic];
    }
    if([titles isEqualToString:@"续租"]){
        [self continueRent:self.orderDic];
    }

}
//取消订单
-(void)cancelOrder:(NSString *)orderId{
    
    NSDictionary *paramter = @{@"user_id":[XTool GetDefaultInfo:USER_INFO][USER_ID],@"order_id":orderId};
    [self postWithURLString:@"/user/cancelorder" parameters:paramter success:^(id response) {
        NSLog(@"取消订单%@",response);
        [WToast showWithText:response[@"msg"]];
        if([response[@"status"]integerValue]==1)
        {
            
           [self loadData];
        }
        
    } failure:^(NSError *error) {
        
    }];
    
    
}
//查看物流
-(void)checkShipwithCode:(NSString *)shipCode andShipNum:(NSString *)shipNum
{
    ShipTrackViewController *vc = [[ShipTrackViewController alloc]init];
    vc.shipCode = shipCode;
    vc.invoice_no = shipNum;
    [self pushView:vc];
    
}
//确认收货
-(void)confirmOrder:(NSString *)orderId
{
    NSDictionary *paramter = @{@"user_id":[XTool GetDefaultInfo:USER_INFO][USER_ID],@"order_id":orderId};
    [self postWithURLString:@"/user/orderConfirm" parameters:paramter success:^(id response) {
        
        if([response[@"status"]integerValue]==1)
        {
            
            [self loadData];
        }
    } failure:^(NSError *error) {
        
    }];
}
//评价订单
-(void)commentOrder:(NSDictionary *)dic
{
    CommetGoodViewController *vc = [[CommetGoodViewController alloc]init];
    //vc.dataDic = dic;
    vc.order_id = dic[@"order_id"];
    vc.type = @"1";
    [self pushView:vc];
    
}
//退货 //归还
-(void)returnOrder:(NSDictionary *)dic
{
    CommetGoodViewController *vc = [[CommetGoodViewController alloc]init];
    //vc.dataDic = dic;
    vc.order_id = dic[@"order_id"];
    vc.type = @"0";
    vc.order_Sn = dic[@"order_sn"];
    [self pushView:vc];
    
}
//续租
-(void)continueRent:(NSDictionary *)order{
    ContiRentViewController *vc = [[ContiRentViewController alloc]init];
    vc.order_id = order[@"order_id"];
    vc.good_Id = order[@"goods_list"][0][@"goods_id"];
    [self pushView:vc];
}
//购买
-(void)buyRent:(NSDictionary *)order{
    BuyRentViewController *vc = [[BuyRentViewController alloc]init];
    vc.order_id = order[@"order_id"];
    vc.good_Id = order[@"goods_list"][0][@"goods_id"];
    [self pushView:vc];
    
}
//二手产品取消购买
-(void)cancenBuy:(NSString *)orderId{
    NSDictionary *paramter = @{@"user_id":[XTool GetDefaultInfo:USER_INFO][USER_ID],@"order_id":orderId};
    [self postWithURLString:@"/user/cancelold" parameters:paramter success:^(id response) {
        [WToast showWithText:response[@"msg"]];
        if([response[@"status"]integerValue]==1)
        {
            [self loadData];
        }
        
    } failure:^(NSError *error) {
        
    }];
}
//确认购买二手产品
-(void)confirmBuy:(NSString *)orderId{
    NSDictionary *paramter = @{@"user_id":[XTool GetDefaultInfo:USER_INFO][USER_ID],@"order_id":orderId};
    [self postWithURLString:@"/user/cofire_buy" parameters:paramter success:^(id response) {
        [WToast showWithText:response[@"msg"]];
        if([response[@"status"]integerValue]==1)
        {
            [self loadData];
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
     if(section==1)
     {
         return 40;
     }else
    return CGFLOAT_MIN;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
     if(section==1)
     {
         UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, 40)];
         UILabel *headLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, screen_width-10, 40)];
         headLb.text = [NSString stringWithFormat:@"共 (%lu) 件商品",[self.goodsList count]];
         headLb.font = [UIFont systemFontOfSize:15];
         headLb.textColor = RGB(100, 100, 100);
         [headView addSubview:headLb];
         return headView;
     }else return [[UIView alloc]initWithFrame:CGRectZero];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==1)
    {
        return [self.goodsList count];
    }
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
        OrdersnCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"OrdersnCell" owner:self options:nil]lastObject];
        cell.time.text = [NSString stringWithFormat:@"下单时间：%@",self.orderDic[@"add_time"]];
        cell.ordersn.text = [NSString stringWithFormat:@"订单编号：%@",self.orderDic[@"order_sn"]];
        return cell;
    }else if (indexPath.section==1)
    {
        static NSString *cellID = @"cell";
        OrderGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if(!cell)
        {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"OrderGoodsCell" owner:self options:nil]lastObject];
        }
        [cell bindData:self.goodsList[indexPath.row]];
        return cell;
    }else
    {
        OrderPriceInfoCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"OrderPriceInfoCell" owner:self options:nil]lastObject];
        [cell bindData:self.orderDic];
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
        return 70;
        
    }else if (indexPath.section==1)
    {
        return 100;
    }else
    {
        return 330;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
