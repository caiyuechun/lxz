//
//  OrderListViewController.m
//  chuangyi
//
//  Created by caiyc on 17/8/10.
//  Copyright © 2017年 changce. All rights reserved.
//  我发布的出租

#import "DistubeDViewController.h"
#import "DistubeGViewController.h"
#import "OrderCell.h"
#import "MydisRentCell.h"
//#import "OrderDetailViewController.h"
#import "PayViewController.h"
#import "WriteShipViewController.h"
//#import "ShipTrackViewController.h"
//#import "CommetGoodViewController.h"
//#import "PayResultViewController.h"
@interface DistubeDViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *dataSouce;
@property(nonatomic,strong)NSString *types;//状态

@end

@implementation DistubeDViewController
-(void)viewWillAppear:(BOOL)animated
{
    
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
    [self initNaviView:[UIColor whiteColor] hasLeft:1 leftColor:nil title:@"我发布的出租" titleColor:[UIColor blackColor] right:@"" rightColor:nil rightAction:nil];
    self.view.backgroundColor = viewcontrollerColor;
    self.moveLa = [[UILabel alloc]initWithFrame:CGRectMake(0, 48, screen_width/5, 2)];
    self.types = @"";
    
    self.moveLa.backgroundColor = BASE_COLOR;
    [self.topView addSubview:self.moveLa];
    self.tableView.delegate =self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
      // Do any additional setup after loading the view from its nib.
}
-(void)loadData{
    
    NSDictionary *param = @{@"user_id":[XTool GetDefaultInfo:USER_INFO][USER_ID],@"type":self.types};
    [self postWithURLString:@"/goods/myrentlist" parameters:param success:^(id response) {
        SLog(@"我的发布数据%@",response);
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
    MydisRentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MydisRentCell" owner:self options:nil]lastObject];
    }
    [cell bindData:self.dataSouce[indexPath.section]];
     cell.handel_Btn.tag = indexPath.section;
//    if([self.dataSouce[indexPath.section][@"pay_status"]integerValue]==0){
//        cell.handel_Btn.tag = indexPath.section;
//       
//    }
      [cell.handel_Btn addTarget:self action:@selector(handels:) forControlEvents:UIControlEventTouchUpInside];
   // __weak DistubeDViewController *weakSelf = self;
//    cell.handel = ^(UIButton *sender){
//        NSString *orderId = weakSelf.dataSouce[indexPath.section][@"order_id"];
//        NSString *titles = sender.titleLabel.text;
//    if([sender.titleLabel.text isEqualToString:@"去付款"])
//    {
////        PayResultViewController *vc = [[PayResultViewController alloc]init];
////        vc.order_Dic = self.dataSouce[indexPath.section];
////        [weakSelf pushView:vc];
//        PayViewController *vc = [[PayViewController alloc]init];
//        vc.orderStr = weakSelf.dataSouce[indexPath.section][@"order_sn"];
//        vc.cashStr = weakSelf.dataSouce[indexPath.section][@"order_amount"];
//       // vc.order_Dic = weakSelf.dataSouce[indexPath.section];
//        [weakSelf pushView:vc];
//
//    }
//        if([titles isEqualToString:@"取消订单"])
//        {
//            [weakSelf cancelOrder:orderId];
//        }
//        if([titles isEqualToString:@"查看物流"])
//        {
//            [weakSelf checkShipwithCode:self.dataSouce[indexPath.section][@"shipping_code"] andShipNum:self.dataSouce[indexPath.section][@"invoice_no"]];
//        }
//        if([titles isEqualToString:@"确认收货"])
//        {
//            [weakSelf confirmOrder:orderId];
//        }
//        if([titles isEqualToString:@"评价"])
//        {
//            [weakSelf commentOrder:self.dataSouce[indexPath.section]];
//        }
//        if([titles isEqualToString:@"退货"])
//        {
//            [weakSelf returnOrder:self.dataSouce[indexPath.section]];
//        }
   // };
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 207;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DistubeGViewController *vc = [[DistubeGViewController alloc]init];
    vc.goodId = self.dataSouce[indexPath.section][@"goods_id"];
    [self pushView:vc];
//    OrderDetailViewController *vc = [[OrderDetailViewController alloc]init];
//    vc.order_id = self.dataSouce[indexPath.section][@"order_id"];
//    [self pushView:vc];
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
#pragma mark 支付检测费用
-(void)handels:(UIButton *)sender{
    if([sender.titleLabel.text isEqualToString:@"支付检测费用"]){
    PayViewController *vc= [[PayViewController alloc]init];
    NSDictionary *dic = self.dataSouce[sender.tag];
    vc.cashStr = dic[@"order_amount"];
    vc.orderStr = dic[@"order_sn"];
    [self pushView:vc];
    }else if ([sender.titleLabel.text isEqualToString:@"填写快递单号"]){
        NSInteger index = sender.tag;
        WriteShipViewController *vc = [[WriteShipViewController alloc]init];
        vc.goodDic = self.dataSouce[index];
        [self pushView:vc];
    }
    
}
//查看物流
-(void)checkShipwithCode:(NSString *)shipCode andShipNum:(NSString *)shipNum
{
//    ShipTrackViewController *vc = [[ShipTrackViewController alloc]init];
//   vc.shipCode = shipCode;
//   vc.invoice_no = shipNum;
//    [self pushView:vc];

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
//    CommetGoodViewController *vc = [[CommetGoodViewController alloc]init];
//    //vc.dataDic = dic;
//    vc.order_id = dic[@"order_id"];
//    vc.type = @"1";
//    [self pushView:vc];
    
}
//退货
-(void)returnOrder:(NSDictionary *)dic
{
//    CommetGoodViewController *vc = [[CommetGoodViewController alloc]init];
//    //vc.dataDic = dic;
//    vc.order_id = dic[@"order_id"];
//    vc.type = @"0";
//    vc.order_Sn = dic[@"order_sn"];
//    [self pushView:vc];

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
    //0全部，1待收货2待审核3审核通过4审核失败
    switch (sender.tag) {
        case 0:
            self.types = @"";
            break;
            case 1:
            self.types = @"1";
            break;
            case 2:
            self.types = @"2";
            break;
            case 3:
            self.types = @"3";
            break;
            case 4:
            self.types = @"4";
            break;
        default:
            break;
    }
    self.moveLa.frame = CGRectMake(screen_width/5*sender.tag, 48, screen_width/5, 2);
    [self loadData];
}
@end
