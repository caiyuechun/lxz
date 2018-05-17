//
//  OrderListViewController.m
//  chuangyi
//
//  Created by caiyc on 17/8/10.
//  Copyright © 2017年 changce. All rights reserved.
//

#import "OrderListViewController.h"
#import "OrderCell.h"
#import "OrderDetailViewController.h"
#import "PayViewController.h"
#import "PayZViewController.h"
#import "ShipTrackViewController.h"
#import "CommetGoodViewController.h"
#import "ContiRentViewController.h"
#import "BuyRentViewController.h"
#import "ReturnGoodViewController.h"
//#import "PayResultViewController.h"
@interface OrderListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *dataSouce;

@end

@implementation OrderListViewController
-(void)viewWillAppear:(BOOL)animated
{
//    self.view.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
//    //x和y的最终值为1
//    [UIView animateWithDuration:1 animations:^{
//        self.view.layer.transform = CATransform3DMakeScale(1, 1, 1);
//    }];
    [self loadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSouce = [NSMutableArray array];
    if([self.sattus isEqualToString:@""])
    {
        
    }else
    {
        self.topView.hidden =1;
        self.tableView.frame = CGRectMake(0, 65, self.tableView.frame.size.width, self.tableView.frame.size.height+50);
    }
    //self.sattus = @"";
    [self initNaviView:[UIColor whiteColor] hasLeft:1 leftColor:nil title:@"客户订单" titleColor:[UIColor blackColor] right:@"" rightColor:nil rightAction:nil];
    self.view.backgroundColor = viewcontrollerColor;
    self.moveLa = [[UILabel alloc]initWithFrame:CGRectMake(0, 48, screen_width/5, 2)];
    
    self.moveLa.backgroundColor = BASE_COLOR;
    [self.topView addSubview:self.moveLa];
    self.tableView.delegate =self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = 0;
    
      // Do any additional setup after loading the view from its nib.
}
-(void)loadData{
    
    NSDictionary *param = @{@"user_id":[XTool GetDefaultInfo:USER_INFO][USER_ID],@"type":self.sattus};
    [self postWithURLString:@"/user/getorderlist" parameters:param success:^(id response) {
        SLog(@"订单数据%@",response);
        if(response)
        {
        
            self.dataSouce = response[@"result"];
            if(self.dataSouce.count==0)
            {
                [WToast showWithText:@"暂无数据"];
            }
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
 //   return 5;
    return self.dataSouce.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cell";
    OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"OrderCell" owner:self options:nil]lastObject];
    }
    [cell bindData:self.dataSouce[indexPath.section]];
    __weak OrderListViewController *weakSelf = self;
    cell.handel = ^(UIButton *sender){
        NSString *orderId = weakSelf.dataSouce[indexPath.section][@"order_id"];
        NSString *titles = sender.titleLabel.text;
    if([sender.titleLabel.text isEqualToString:@"去支付"])
    {
//        PayResultViewController *vc = [[PayResultViewController alloc]init];
//        vc.order_Dic = self.dataSouce[indexPath.section];
//        [weakSelf pushView:vc];
        
//        NSString *url = @"alipays://platformapi/startapp?appId=20000067&url=https%3A%2F%2Fmapi.alipay.com%2Fgateway.do%3F_input_charset%3Dutf-8%26amount%3D0.1%26notify_url%3Dhttp%253A%252F%252Flxz.ynthgy.com%252Fapi%252Fpayment%252FalipayNotify%26order_title%3D%25E6%2597%25A0%25E7%25BA%25BF%25E9%25A2%2584%25E6%258E%2588%25E6%259D%2583%26out_order_no%3D201805041653498158%26out_request_no%3D201805041653498158%26partner%3D2088031889272312%26pay_mode%3DWIRELESS%26payee_user_id%3D2088031889272312%26product_code%3DFUND_PRE_AUTH%26scene_code%3DHOTEL%26service%3D%2Balipay.fund.auth.create.freeze.apply%26sign%3Dojo6qT%252FMOuHdPkUGeJu9bm60Yvsdmto6JdDvFvtdqOApBKK1oAP3%252FNeNtu4RKFX%252FnUx3tM%252FUac%252F0soZRdqmv%252Btmh5AFLFZntBTq%252BYs6wp%252BY25kOCssdNfzgrbvgkFYmUPNi5MP5IsT9fk3lACxyM9llBSWDpKcmigSv%252F7tnIhoo%253D%26sign_type%3DRSA";
//        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:url]];
        
        if([weakSelf.dataSouce[indexPath.section][@"gtype"]integerValue]==0){
            PayZViewController *vc = [[PayZViewController alloc]init];
            vc.orderStr = weakSelf.dataSouce[indexPath.section][@"order_sn"];
            vc.cashStr = weakSelf.dataSouce[indexPath.section][@"order_amount"];
            // vc.order_Dic = weakSelf.dataSouce[indexPath.section];
            [weakSelf pushView:vc];

        }else{
        PayViewController *vc = [[PayViewController alloc]init];
        vc.orderStr = weakSelf.dataSouce[indexPath.section][@"order_sn"];
        vc.cashStr = weakSelf.dataSouce[indexPath.section][@"order_amount"];
       // vc.order_Dic = weakSelf.dataSouce[indexPath.section];
        [weakSelf pushView:vc];
        }

    }
        if([titles isEqualToString:@"取消订单"])
        {
            [weakSelf cancelOrder:orderId];
        }
        if([titles isEqualToString:@"物流查询"])
        {
            [weakSelf checkShipwithCode:self.dataSouce[indexPath.section][@"shipping_code"] andShipNum:self.dataSouce[indexPath.section][@"invoice_no"]];
        }
        if([titles isEqualToString:@"确认收货"])
        {
            [weakSelf confirmOrder:orderId];
        }
        if([titles isEqualToString:@"评价"])
        {
            [weakSelf commentOrder:self.dataSouce[indexPath.section]];
        }
        if([titles isEqualToString:@"退货"])
        {
            [weakSelf returnOrder:self.dataSouce[indexPath.section]];
        }
        if([titles isEqualToString:@"取消购买"]){
            [weakSelf cancenBuy:orderId];
        }
        if([titles isEqualToString:@"确认购买"]){
            [weakSelf confirmBuy:orderId];
        }
        if([titles isEqualToString:@"归还"]){
         [weakSelf returnOrder:self.dataSouce[indexPath.section]];
        }
        if([titles isEqualToString:@"续租"]){
            
            [weakSelf continueRent:self.dataSouce[indexPath.section]];
        }
        if([titles isEqualToString:@"购买"]){
            [weakSelf buyRent:self.dataSouce[indexPath.section]];
        }
    };
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    //待付款
        if([self.dataSouce[indexPath.section][@"gtype"]integerValue]==0){
            //租赁订单
            if([self.dataSouce[indexPath.section][@"deductibles"]integerValue]==1){
            return 174+150;
            }else return 174+100;
        }
        else{
//            if([self.dataSouce[indexPath.section][@"order_status_desc"]isEqualToString:@"已取消"]){
//                return 174+50;
//            }else
        return 174+100;
        }
        
 
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderDetailViewController *vc = [[OrderDetailViewController alloc]init];
    vc.order_id = self.dataSouce[indexPath.section][@"order_id"];
    [self pushView:vc];
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
//查看物流
-(void)checkShipwithCode:(NSString *)shipCode andShipNum:(NSString *)shipNum
{
    ShipTrackViewController *vc = [[ShipTrackViewController alloc]init];
   vc.shipCode = shipCode;
   vc.invoice_no = shipNum;
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
//确认收货
-(void)confirmOrder:(NSString *)orderId
{
    NSDictionary *paramter = @{@"user_id":[XTool GetDefaultInfo:USER_INFO][USER_ID],@"order_id":orderId};
    [self postWithURLString:@"/user/orderConfirm" parameters:paramter success:^(id response) {
       
        if([response[@"status"]integerValue]==1)
        {
            [WToast showWithText:@"已收货"];
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
//退货 //归还商品
-(void)returnOrder:(NSDictionary *)dic
{
    ReturnGoodViewController *vc = [[ReturnGoodViewController alloc]init];
  //  CommetGoodViewController *vc = [[CommetGoodViewController alloc]init];
    //vc.dataDic = dic;
    vc.order_id = dic[@"order_id"];
    vc.type = @"0";
    vc.order_Sn = dic[@"order_sn"];
    [self pushView:vc];

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
//切换状态
- (IBAction)changeStatus:(UIButton *)sender {
    switch (sender.tag) {
        case 0:
            self.sattus = @"";
            break;
            case 1:
            self.sattus = @"WAITPAY";
            break;
            case 4:
            self.sattus = @"RENEW";
            break;
            case 2:
            self.sattus = @"WAITRECEIVE";
            break;
            case 3:
            self.sattus = @"WAITCCOMMENT";
            break;
        default:
            break;
    }
    self.moveLa.frame = CGRectMake(screen_width/5*sender.tag, 48, screen_width/5, 2);
    [self loadData];
}
@end
