//
//  SettlementViewController.m
//  chuangyi
//
//  Created by caiyc on 17/8/9.
//  Copyright © 2017年 changce. All rights reserved.
//  租赁的结算页面

#import "SettlementZViewController.h"
#import "AddressDef.h"
#import "ZOrderInfoCell.h"
#import "OrderGoodsCell.h"
#import "AddressListViewController.h"
#import "PayViewController.h"
//#import "ShipListViewController.h"
#import "OrderListViewController.h"
//#import "SPayClient.h"
//#import "SPHTTPManager.h"
//#import "SPConst.h"
//#import <XMLReader.h>
//#import "SPRequestForm.h"
#import "ConpousListViewController.h"
//#import "ConpousViewController.h"
//#import "ConpousListViewController.h"
@interface SettlementZViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UITextFieldDelegate>
@property(nonatomic,strong)NSDictionary *addressDic;
@property(nonatomic,strong)NSDictionary *settleDic;
@property(nonatomic,strong)NSMutableArray *goodArr;
@property(nonatomic,strong)NSMutableArray *cartList;
@property(nonatomic,strong)NSString *addressId;
@property(nonatomic,strong)NSString *shipCode;
@property(nonatomic,strong)NSString *ShipPrice;
@property(nonatomic,strong)NSString *ShipName;
@property(assign)BOOL allshipFree;
@property(nonatomic,strong)NSDictionary *user_Add;
@property(assign)CGFloat shipFee;
@property(nonatomic,strong)NSString *conpousId;//优惠券Id
@property(nonatomic,strong)NSDictionary *conpousDic;//优惠券数据
@property(nonatomic,strong)NSString *counpPrice;
@property(nonatomic,strong)NSString *coupsPriceNum;
@property(nonatomic,strong)NSString *goodPriceNum;
@property(nonatomic,strong)NSString *interNum;//用户输入的积分数量
@property(assign)CGFloat intergprice;//积分抵扣的钱
@property(assign)CGFloat pointpre;//积分兑换比例
@property(assign)CGFloat userMoeny;
@property(assign)BOOL havaPick;
@property(assign)BOOL selectShip;
@property(assign)BOOL seletUserMoney;
@property(assign)NSInteger sendType;//配送方式，0是自提，1是配送
@property(assign)BOOL overs;//是否超过1000
@property(assign)CGFloat coun_Price;//优惠券钱
@property(assign)BOOL selectSevice;//是否勾选免赔

@end

@implementation SettlementZViewController
-(void)wftPay
{
//    NSString *service = @"unified.trade.pay";
//    NSString *version =@"1.0";
//    NSString *charset =@"UTF-8";
//    NSString *sign_type = @"MD5";
//    NSString *mch_id = @"102595494168";
//    NSString *out_trade_no = @"201455447787878";
//    NSString *device_info = @"WP10000100001";
//    NSString *body = @"购买商品";
//    NSInteger total_fee = 1;
//    NSString *mch_create_ip = @"127.0.0.1";
//    NSString *notify_url =@"http://wap.tenpay.com/tenpay.asp";
//    NSString *time_start;
//    NSString *time_expire;
//    NSString *nonce_str = @"1507531762Nx85JSnGEtSca3uWS073HK";
//    
//    
//    NSNumber *amount = [NSNumber numberWithInteger:total_fee];
    
    //生成提交表单
//    NSDictionary *postInfo = [[SPRequestForm sharedInstance]
//                              spay_pay_gateway:service
//                              version:version
//                              charset:charset
//                              sign_type:sign_type
//                              mch_id:mch_id
//                              out_trade_no:out_trade_no
//                              device_info:device_info
//                              body:body
//                              total_fee:total_fee
//                              mch_create_ip:mch_create_ip
//                              notify_url:notify_url
//                              time_start:time_start
//                              time_expire:time_expire
//                              nonce_str:nonce_str];
//    
//    __weak typeof(self) weakSelf = self;
//    
//    
//    //调用支付预下单接口
//    [[SPHTTPManager sharedInstance] post:kSPconstWebApiInterface_spay_pay_gateway
//                                paramter:postInfo
//                                 success:^(id operation, id responseObject) {
//                                     
//                                     
//                                     //返回的XML字符串,如果解析有问题可以打印该字符串
//                                     //        NSString *response = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
//                                     
//                                     NSError *erro;
//                                     //XML字符串 to 字典
//                                     //!!!! XMLReader最后节点都会设置一个kXMLReaderTextNodeKey属性
//                                     //如果要修改XMLReader的解析，请继承该类然后再去重写，因为SPaySDK也是调用该方法解析数据，如果修改了会导致解析失败
//                                     NSDictionary *info = [XMLReader dictionaryForXMLData:(NSData *)responseObject error:&erro];
//                                     
//                                     NSLog(@"预下单接口返回数据-->>\n%@",info);
//                                     
//                                     
//                                     //判断解析是否成功
//                                     if (info && [info isKindOfClass:[NSDictionary class]]) {
//                                         
//                                         NSDictionary *xmlInfo = info[@"xml"];
//                                         
//                                         NSInteger status = [xmlInfo[@"status"][@"text"] integerValue];
//                                         
//                                         //判断SPay服务器返回的状态值是否是成功,如果成功则调起SPaySDK
//                                         if (status == 0) {
//                                             
//                                             // [weakSelf.hud hide:YES];
//                                             
//                                             //获取SPaySDK需要的token_id
//                                             NSString *token_id = xmlInfo[@"token_id"][@"text"];
//                                             
//                                             //获取SPaySDK需要的services
//                                            // NSString *services = xmlInfo[@"services"][@"text"];
//                                             
//                                             if (1) {
//                                                 //                                                 pay.alipay.native.towap
//                                                 //                                                 pay.weixin.app
//                                                 //调起SPaySDK支付
//                                                 [[SPayClient sharedInstance] pay:self
//                                                                           amount:amount
//                                                                spayTokenIDString:token_id
//                                                                payServicesString:@"pay.weixin.app"
//                                                                           finish:^(SPayClientPayStateModel *payStateModel,
//                                                                                    SPayClientPaySuccessDetailModel *paySuccessDetailModel) {
//                                                                               
//                                                                               //更新订单号
//                                                                               // weakSelf.out_trade_noText.text = [NSString spay_out_trade_no];
//                                                                               
//                                                                               
//                                                                               if (payStateModel.payState == SPayClientConstEnumPaySuccess) {
//                                                                                   
//                                                                                   NSLog(@"支付成功");
//                                                                                   NSLog(@"支付订单详情-->>\n%@",[paySuccessDetailModel description]);
//                                                                               }else{
//                                                                                   NSLog(@"支付失败，错误号:%d",payStateModel.payState);
//                                                                               }
//                                                                               
//                                                                           }];
//                                                 
//                                                 
//                                             }else{
//                                                 
//                                                 //                                                 [weakSelf swiftlyPay:amount spayTokenIDString:token_id payServicesString:services];
//                                             }
//                                             
//                                         }else{
//                                             //                                             weakSelf.hud.labelText = xmlInfo[@"message"][@"text"];
//                                             //                                             [weakSelf.hud hide:YES afterDelay:2.0];
//                                         }
//                                     }else{
//                                         //                                         weakSelf.hud.labelText = @"预下单接口，解析数据失败";
//                                         //                                         [weakSelf.hud hide:YES afterDelay:2.0];
//                                     }
//                                     
//                                     
//                                 } failure:^(id operation, NSError *error) {
//                                     
//                                     //                                     weakSelf.hud.labelText = @"调用预下单接口失败";
//                                     //                                     [weakSelf.hud hide:YES afterDelay:2.0];
//                                     NSLog(@"调用预下单接口失败-->>\n%@",error);
//                                 }];
//    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:1];
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    [self wftPay];
//    return;
    self.sendType = 1;
    self.conpousId = @"";
    self.goodArr = [NSMutableArray array];
    self.ShipPrice = @"¥0.0";
    self.coun_Price = 0;
    self.userMoeny = 0.0;
    self.intergprice = 0.0;
    self.counpPrice = @"- ¥0.0";
    self.coupsPriceNum = @"0.0";
    self.goodPriceNum = @"0.0";
    self.shipCode = @"shunfeng";
    //self.interNum = @"0";
    self.overs = 0;
    self.cartList =[NSMutableArray array];
//    [self.cartList addObject:@"0"];
//    [self.cartList addObject:@"1"];
    self.price.textColor = PRICE_COLOR;
    self.paybtn.backgroundColor = BASE_COLOR;
    [self initNaviView:[UIColor whiteColor] hasLeft:1 leftColor:nil title:@"填写订单" titleColor:[UIColor blackColor] right:@"" rightColor:nil rightAction:nil];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.tableView.showsHorizontalScrollIndicator = 0;
    
    self.corver_View.hidden = 1;
    self.sevice_View.layer.cornerRadius = 5;
    self.sevice_View.layer.masksToBounds = 1;
    self.corver_View.backgroundColor = RGBA(0, 0, 0, .5);
    self.sevice_Tv.userInteractionEnabled = 0;
    UITapGestureRecognizer *sevice_Tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideCorver)];
    [self.corver_View addGestureRecognizer:sevice_Tap];
  //  self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    NSDictionary *param = @{@"user_id":[XTool GetDefaultInfo:USER_INFO][USER_ID]};
    [self postWithURLString:@"/cart/cart2" parameters:param success:^(id response) {
        SLog(@"计算页面数据%@",response);
        if(response)
        {
            self.pointpre = [response[@"result"][@"pointpre"]floatValue];
            if([[response[@"result"][@"addressList"]allKeys] count]>0)
            {
                self.user_Add = response[@"result"][@"addressList"];
                self.addressDic = response[@"result"][@"addressList"];
            }
            self.settleDic = response[@"result"];
//            NSString *disstr = self.settleDic[@"userInfo"][@"discount"];
//            CGFloat dis = [disstr floatValue];
              self.shipFee =[self.settleDic[@"postFee"]floatValue];
            CGFloat totalss = [self.settleDic[@"totalPrice"][@"ordertotal"]floatValue]+self.shipFee;
            
            
            NSString *price = [NSString stringWithFormat:@"实付：¥%.2f",totalss];
          
            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:price ];
            [AttributedStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:ICONNAME size:16] range:NSMakeRange(4, price.length-4)];
            self.price.attributedText = AttributedStr;

            self.goodPriceNum = [NSString stringWithFormat:@"%@",self.settleDic[@"totalPrice"][@"ordertotal"]];
         //   self.sevice_Tv.text = self.settleDic[@"server"][@"content"];
          
//            if(self.shipFee>1){
//
//                
//                CGFloat total = self.shipFee+totalss;
//                NSString *price= [NSString stringWithFormat:@"实付：¥%.2f",total];
//                
//                NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:price ];
//                [AttributedStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:ICONNAME size:16] range:NSMakeRange(4, price.length-4)];
//                self.price.attributedText = AttributedStr;
//
//            }
            
            for(int i =0;i<[self.settleDic[@"cartList"] count];i++)
            {
                NSDictionary *gooddic = self.settleDic[@"cartList"][i];
                [self.cartList addObject:gooddic];

            }
            if([self.settleDic[@"picklist"]count]==0)
            {
                self.selectShip = 1;
            }
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(missKb)];
    [self.tableView addGestureRecognizer:tap];
    // Do any additional setup after loading the view from its nib.
}
-(void)hideCorver{
    self.corver_View.hidden = 1;
}
-(void)missKb
{
    [self.view endEditing:1];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==2)
    {
        return self.cartList.count;
    }else return 1;
//    if(section>1)
//    {
//        return [self.cartList count];
//    }
//    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0){
    static NSString *cellId = @"cell";
    AddressDef *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(!cell)
    {
        cell =[[[NSBundle mainBundle]loadNibNamed:@"AddressDef" owner:self options:nil]lastObject];
    }
        if(self.user_Add)
        {
            [cell bindData:self.user_Add];
            cell.noAdd.hidden = 1;
        }else
        {
            cell.noAdd.hidden =0;
        }
        cell.clicks =^(){
        
            AddressListViewController *vc = [[AddressListViewController alloc]init];
            vc.needback = 1;
            vc.select = ^(NSDictionary *dic){
                //            NSMutableDictionary *dics = [[NSMutableDictionary alloc]initWithDictionary:self.settleDic];
                //            [dics setObject:dic forKey:@"addressList"];
                [self cacuShipPrice];
                self.user_Add = dic;
                [self.tableView reloadData];
                
            };
            [self pushView:vc];

        
        };
    
    return cell;
    }else if(indexPath.section==1)
    {
        ZOrderInfoCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"ZOrderInfoCell" owner:self options:nil]lastObject];
       // cell.shipFee.text = self.ShipPrice;
        NSMutableAttributedString *AttributedStrss = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥%.2f", self.shipFee]];
        cell.scroTf.delegate = self;
        cell.scroTf.text = self.interNum;
        [AttributedStrss addAttribute:NSFontAttributeName value:[UIFont fontWithName:ICONNAME size:16] range:NSMakeRange(1, AttributedStrss.length-1)];
        cell.shipFee.attributedText = AttributedStrss;
        

        
     
        NSMutableAttributedString *AttributedStrs = [[NSMutableAttributedString alloc]initWithString: self.counpPrice ];
        [AttributedStrs addAttribute:NSFontAttributeName value:[UIFont fontWithName:ICONNAME size:16] range:NSMakeRange(3, self.counpPrice.length-3)];
       cell.youhuiPrice.attributedText = AttributedStrs;


//        CGFloat total_Fee =[ self.settleDic[@"totalPrice"][@"total_fee"]floatValue];
//        CGFloat users = [self.settleDic[@"userInfo"][@"user_money"]floatValue];
//        CGFloat motyss = 0;
//        if(total_Fee<users)
//        {
//            motyss = total_Fee;
//        }
//      //  cell.usermoneyLb.text =[NSString stringWithFormat:@"余额抵扣%.2f元",motyss];
//        NSString *disUser = [NSString stringWithFormat:@"-¥%.2f",self.userMoeny];
//        NSMutableAttributedString *AttributedStrsss = [[NSMutableAttributedString alloc]initWithString: disUser ];
//        [AttributedStrsss addAttribute:NSFontAttributeName value:[UIFont fontWithName:ICONNAME size:16] range:NSMakeRange(1, self.ShipPrice.length-1)];
//        cell.disUserMoney.attributedText = AttributedStrsss;
//        
//        NSString *inter = [NSString stringWithFormat:@"-¥%.2f",self.intergprice];
//        NSMutableAttributedString *AttributedStr_ = [[NSMutableAttributedString alloc]initWithString: inter];
//        [AttributedStr_ addAttribute:NSFontAttributeName value:[UIFont fontWithName:ICONNAME size:16] range:NSMakeRange(1, inter.length-1)];
//        cell.interprice.attributedText = AttributedStr_;
        
        
        
        CGFloat goodPrices = [self.goodPriceNum floatValue];
        
        CGFloat totals = self.shipFee+goodPrices-self.userMoeny-self.intergprice-[self.coupsPriceNum floatValue];
        NSString *prices= [NSString stringWithFormat:@"实付：¥%.2f",totals];
        
        NSMutableAttributedString *AttributedStrssssssss = [[NSMutableAttributedString alloc]initWithString:prices ];
        [AttributedStrssssssss addAttribute:NSFontAttributeName value:[UIFont fontWithName:ICONNAME size:16] range:NSMakeRange(4, prices.length-4)];
        self.price.attributedText = AttributedStrssssssss;


  __weak ZOrderInfoCell *weakCell = cell;
//        if(self.seletUserMoney)
//        {
//             [cell.selectUsermoeny ButtonWithIconStr:@"\U0000e7b2" inIcon:iconfont andSize:CGSizeMake(30, 30) andColor:BASE_COLOR andiconSize:20];
//        }else
//        {
//              [cell.selectUsermoeny ButtonWithIconStr:@"\U0000e7b2" inIcon:iconfont andSize:CGSizeMake(30, 30) andColor:[UIColor lightGrayColor] andiconSize:20];
//            
//        }
//        cell.sleectUserMoney = ^(){
//            self.seletUserMoney = !self.seletUserMoney;
//            if(self.seletUserMoney)
//            {
//                [weakCell.selectUsermoeny ButtonWithIconStr:@"\U0000e7b2" inIcon:iconfont andSize:CGSizeMake(30, 30) andColor:BASE_COLOR andiconSize:20];
//                self.userMoeny = motyss;
//               
//            }else
//            {
//                [weakCell.selectUsermoeny ButtonWithIconStr:@"\U0000e7b2" inIcon:iconfont andSize:CGSizeMake(30, 30) andColor:[UIColor lightGrayColor] andiconSize:20];
//                self.userMoeny = 0.00;
//            }
//            NSString *disUser = [NSString stringWithFormat:@"-¥%.2f",self.userMoeny];
//            NSMutableAttributedString *AttributedStrsss = [[NSMutableAttributedString alloc]initWithString: disUser ];
//            [AttributedStrsss addAttribute:NSFontAttributeName value:[UIFont fontWithName:ICONNAME size:16] range:NSMakeRange(1, self.ShipPrice.length-1)];
//            weakCell.disUserMoney.attributedText = AttributedStrsss;
//            
//          
//
//            
//            NSString *disstr = self.settleDic[@"userInfo"][@"discount"];
//            CGFloat dis = [disstr floatValue];
//
//            CGFloat goodPrice = [self.goodPriceNum floatValue];
//           
//            CGFloat total = self.shipFee+goodPrice-self.userMoeny-[ self.coupsPriceNum floatValue];
//            NSString *price= [NSString stringWithFormat:@"实付：¥%.2f",total];
//            
//            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:price ];
//            [AttributedStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:ICONNAME size:16] range:NSMakeRange(4, price.length-4)];
//            self.price.attributedText = AttributedStr;
//            
//            
//        };
        NSString *str = @"可用0张";
        if(self.havaPick)
        {
             [cell.pickSelctBtn ButtonWithIconStr:@"\U0000e606" inIcon:iconfont andSize:CGSizeMake(30, 30) andColor:BASE_COLOR andiconSize:20];
              [cell.shipSelectBtn ButtonWithIconStr:@"\U0000e606" inIcon:iconfont andSize:CGSizeMake(30, 30) andColor:[UIColor lightGrayColor] andiconSize:20];
        }else
        {
            [cell.pickSelctBtn ButtonWithIconStr:@"\U0000e606" inIcon:iconfont andSize:CGSizeMake(30, 30) andColor:[UIColor lightGrayColor] andiconSize:20];
          //   [cell.shipSelectBtn ButtonWithIconStr:@"\U0000e606" inIcon:iconfont andSize:CGSizeMake(30, 30) andColor:[UIColor grayColor] andiconSize:20];
        }
        if(self.selectShip)
        {
            [cell.shipSelectBtn ButtonWithIconStr:@"\U0000e606" inIcon:iconfont andSize:CGSizeMake(30, 30) andColor:BASE_COLOR andiconSize:20];
            [cell.pickSelctBtn ButtonWithIconStr:@"\U0000e606" inIcon:iconfont andSize:CGSizeMake(30, 30) andColor:[UIColor lightGrayColor] andiconSize:20];
        }else
        {
            [cell.shipSelectBtn ButtonWithIconStr:@"\U0000e606" inIcon:iconfont andSize:CGSizeMake(30, 30) andColor:[UIColor lightGrayColor] andiconSize:20];

        }
      
        cell.checkboxSelct=^(){
            if([self.settleDic[@"picklist"]count]==0)
            {
                return ;
            }
            self.selectShip = !self.selectShip;
            if(self.selectShip)
            {
                self.havaPick = 0;
                [weakCell.shipSelectBtn ButtonWithIconStr:@"\U0000e606" inIcon:iconfont andSize:CGSizeMake(30, 30) andColor:BASE_COLOR andiconSize:20];
                [weakCell.pickSelctBtn ButtonWithIconStr:@"\U0000e606" inIcon:iconfont andSize:CGSizeMake(30, 30) andColor:[UIColor lightGrayColor] andiconSize:20];

            }else{
                [weakCell.shipSelectBtn ButtonWithIconStr:@"\U0000e606" inIcon:iconfont andSize:CGSizeMake(30, 30) andColor:[UIColor lightGrayColor] andiconSize:20];

            }
            
        };
                if([self.settleDic[@"couponList"]count]>0)
        {
            str =  [NSString stringWithFormat:@"可用%lu张",[self.settleDic[@"couponList"]count]];
        }
        cell.youhuiquanLb.text = str;
        if(self.ShipName)
        {
            cell.shipName.text = self.ShipName;
        }else
        {
            cell.shipName.text = @"选择物流";
        }
      //  CGFloat dis = [[NSString stringWithFormat:@"¥%@",self.settleDic[@"userInfo"][@"discount"]]];
//        NSString *disstr = self.settleDic[@"userInfo"][@"discount"];
//        CGFloat dis = [disstr floatValue];
        NSString *price =  [NSString stringWithFormat:@"¥%@",self.settleDic[@"totalPrice"][@"trent_amount"]];
                NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:price ];
        
                [AttributedStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:ICONNAME size:16] range:NSMakeRange(1, price.length-1)];
                [AttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(1, price.length-1)];
                     cell.price.attributedText = AttributedStr;
//        if(dis<1)
//        {
//        NSString *tot =[NSString stringWithFormat:@"¥%.2f(折扣%.2f)", dis *[price floatValue],dis];
//        
//        NSLog(@"产品价格===%@===%@====%f",tot,price,dis);
//        
//        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:tot ];
//        
//        [AttributedStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:ICONNAME size:16] range:NSMakeRange(1, tot.length-9)];
//        [AttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(tot.length-8, 8)];
//             cell.price.attributedText = AttributedStr;
//        }else
//        {
//            NSString *tot =[NSString stringWithFormat:@"¥%.2f", dis *[price floatValue]];
//            
//            NSLog(@"产品价格===%@===%@====%f",tot,price,dis);
//            
//            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:tot ];
//            
//            [AttributedStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:ICONNAME size:16] range:NSMakeRange(1, tot.length-1)];
//        //    [AttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(tot.length+1, 5)];
//            cell.price.attributedText = AttributedStr;
//
//        }
//        
      //  cell.price.attributedText = AttributedStr;

        __weak SettlementZViewController *weakSelf = self;
        
//        cell.slectPick = ^(){
//            //选择自提
//            [weakCell.pickselfLb LabelWithIconStr:@"\U0000e7b2" inIcon:iconfont andSize:CGSizeMake(20, 20) andColor:BASE_COLOR andiconSize:20];
//            [weakCell.sendLb LabelWithIconStr:@"\U0000e7b2" inIcon:iconfont andSize:CGSizeMake(20, 20) andColor:[UIColor lightGrayColor] andiconSize:20];
//            weakSelf.sendType = 0;//0表示自提
//            weakSelf.shipCode = @"shentong";
//            weakSelf.shipFee = 0.00;
//            weakCell.shipFee.text = [NSString stringWithFormat:@"¥%.2f",weakSelf.shipFee];
//            
//            NSString *disstr = self.settleDic[@"userInfo"][@"discount"];
//            CGFloat dis = [disstr floatValue];
//            
//            CGFloat goodPrice = [self.goodPriceNum floatValue]*dis;
//            
//            CGFloat total = self.shipFee+goodPrice-self.userMoeny;
//            NSString *price= [NSString stringWithFormat:@"实付：¥%.2f",total];
//            
//            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:price ];
//            [AttributedStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:ICONNAME size:16] range:NSMakeRange(4, price.length-4)];
//            self.price.attributedText = AttributedStr;
//
//
//        };

//        cell.slectShip=^(){
//           //选择配送
//            [weakCell.sendLb LabelWithIconStr:@"\U0000e7b2" inIcon:iconfont andSize:CGSizeMake(20, 20) andColor:BASE_COLOR andiconSize:20];
//            [weakCell.pickselfLb LabelWithIconStr:@"\U0000e7b2" inIcon:iconfont andSize:CGSizeMake(20, 20) andColor:[UIColor lightGrayColor] andiconSize:20];
//            weakSelf.sendType = 1;
//            self.shipFee = [self.settleDic[@"postFee"]floatValue];
////            weakSelf.shipCode = @"shunfeng";
////            if(self.overs){
////                
////                self.shipFee = 0.00;
////            }
//
//            // weakSelf.shipFee = 25;
//            weakCell.shipFee.text = [NSString stringWithFormat:@"¥%.2f",weakSelf.shipFee];
//            
//            NSString *disstr = self.settleDic[@"userInfo"][@"discount"];
//            CGFloat dis = [disstr floatValue];
//            
//            CGFloat goodPrice = [self.goodPriceNum floatValue]*dis;
//            
//            CGFloat total = self.shipFee+goodPrice-self.userMoeny;
//            NSString *price= [NSString stringWithFormat:@"实付：¥%.2f",total];
//            
//            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:price ];
//            [AttributedStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:ICONNAME size:16] range:NSMakeRange(4, price.length-4)];
//            self.price.attributedText = AttributedStr;
//
//
//        };
//        if(self.sendType==0)
//        {
//            [weakCell.pickselfLb LabelWithIconStr:@"\U0000e7b2" inIcon:iconfont andSize:CGSizeMake(20, 20) andColor:BASE_COLOR andiconSize:20];
//            [weakCell.sendLb LabelWithIconStr:@"\U0000e7b2" inIcon:iconfont andSize:CGSizeMake(20, 20) andColor:[UIColor lightGrayColor] andiconSize:20];
//
//        }else
//        {
//            [weakCell.sendLb LabelWithIconStr:@"\U0000e7b2" inIcon:iconfont andSize:CGSizeMake(20, 20) andColor:BASE_COLOR andiconSize:20];
//            [weakCell.pickselfLb LabelWithIconStr:@"\U0000e7b2" inIcon:iconfont andSize:CGSizeMake(20, 20) andColor:[UIColor lightGrayColor] andiconSize:20];
//            weakSelf.sendType = 1;
//
//        }
        cell.slectyouhui = ^(){
            ConpousListViewController *vc  = [[ConpousListViewController alloc]init];
            vc.dataArr = self.settleDic[@"couponList"];
            vc.needback = 0;
            vc.conpous = ^(NSDictionary *dic){
                weakSelf.conpousId = dic[@"id"];
                weakSelf.counpPrice = [NSString stringWithFormat:@"- ¥%@", dic[@"money"]];
                //                NSString *price =  [NSString stringWithFormat:@"实付：¥%.2f",total];
                //                NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:price ];
                //                [AttributedStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:ICONNAME size:16] range:NSMakeRange(5, price.length-5)];
                //                self.price.attributedText = AttributedStr;
                
                weakSelf.coupsPriceNum =  [NSString stringWithFormat:@"%@", dic[@"money"]];;
                CGFloat goodPrice = [self.goodPriceNum floatValue];
                CGFloat couposPrice = [self.coupsPriceNum floatValue];
                CGFloat total = self.shipFee+goodPrice-couposPrice;
                // self.price.text = [NSString stringWithFormat:@"实付：¥%.2f",total];
                NSString *price =  [NSString stringWithFormat:@"实付：¥%.2f",total];
                NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:price ];
                [AttributedStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:ICONNAME size:16] range:NSMakeRange(5, price.length-5)];
                self.price.attributedText = AttributedStr;
                
                
                [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
            };
            [weakSelf pushView:vc];

        
        
        
        };
        return cell;
    }else
    {
        static NSString *cellId = @"cells";
        OrderGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if(!cell)
        {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"OrderGoodsCell" owner:self options:nil]lastObject];
        }
        [cell bindData:self.cartList[indexPath.row]];
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    return 107;
    else if(indexPath.section==1) return 205;
    else return 100;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
   if(section==1)
    {
        return 10.0;
    }
    if(section>1)
    {
        return 40;
    }else return CGFLOAT_MIN;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section>1)
    {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, 40)];
    UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, screen_width, 40)];
    name.font = [UIFont systemFontOfSize:15];
        name.text =[NSString stringWithFormat: @"共 (%lu) 件商品",[self.cartList count]];
    //name.text = self.cartList[section][@"name"];
        view.backgroundColor = viewcontrollerColor;
        //view.backgroundColor = [UIColor redColor];
    [view addSubview:name];
    return view;
    }
    if(section==0)
    {
        return [[UIView alloc]initWithFrame:CGRectZero];
    }else
    {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, 10)];
        view.backgroundColor = viewcontrollerColor;
        return view;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(section>1)
    {
//        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, 40)];
//        UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, screen_width, 40)];
//        name.font = [UIFont systemFontOfSize:15];
//        name.text =[NSString stringWithFormat: @"共 (%lu) 件商品",[self.cartList count]];
//        //name.text = self.cartList[section][@"name"];
//        view.backgroundColor = viewcontrollerColor;
//        //view.backgroundColor = [UIColor redColor];
//        [view addSubview:name];
        return 300.0f;
    }
else
    return CGFLOAT_MIN;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if(section>1)
    {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, 300)];
        UILabel*feeLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 30)];
        feeLab.text = @"待冻结金额";
        feeLab.font = [UIFont systemFontOfSize:15];
        
        UILabel *check_Lab1 = [[UILabel alloc]initWithFrame:CGRectMake(105, 15, 20, 20)];
        [check_Lab1 LabelWithIconStr:@"\U0000e66b" inIcon:iconfont andSize:CGSizeMake(20, 20) andColor:BUTTON_COLOR andiconSize:20];
        check_Lab1.tag = 878781;
        [view addSubview:feeLab];
        [view addSubview:check_Lab1];
        
        UIButton *yaj_Btn = [UIButton buttonWithType:UIButtonTypeCustom];
        yaj_Btn.frame = CGRectMake(0, 0, 150, 50);
        [yaj_Btn addTarget:self action:@selector(checkYaj) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:yaj_Btn];
        
        UILabel *yaj_Lab = [[UILabel alloc]initWithFrame:CGRectMake(screen_width-180, 10, 170, 30)];
        NSString *price1 = [NSString stringWithFormat:@"%@",self.settleDic[@"totalPrice"][@"tdeposit_amount"]];
        NSString *price1_1 = [NSString stringWithFormat:@"押金：%@元",price1];
        //yaj_Lab.text = [NSString stringWithFormat:@"押金：%@元",price1];
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:price1_1 ];
        [AttributedStr addAttribute:NSForegroundColorAttributeName value:BUTTON_COLOR range:NSMakeRange(3, price1_1.length-3)];
        yaj_Lab.attributedText = AttributedStr;
       yaj_Lab.font = [UIFont systemFontOfSize:15];
        yaj_Lab.textAlignment = NSTextAlignmentRight;
        
        UILabel *zuj_Lab = [[UILabel alloc]initWithFrame:CGRectMake(screen_width-180, 40, 170, 30)];
        NSString *price2 = [NSString stringWithFormat:@"%@",self.settleDic[@"totalPrice"][@"trent_amount"]];
        NSString *price2_1 = [NSString stringWithFormat:@"租金：%@元",price2];
        //yaj_Lab.text = [NSString stringWithFormat:@"押金：%@元",price1];
        NSMutableAttributedString *AttributedStr1 = [[NSMutableAttributedString alloc]initWithString:price2_1 ];
        [AttributedStr1 addAttribute:NSForegroundColorAttributeName value:BUTTON_COLOR range:NSMakeRange(3, price2_1.length-3)];
        zuj_Lab.attributedText = AttributedStr1;

        zuj_Lab.font = [UIFont systemFontOfSize:15];
        zuj_Lab.textAlignment = NSTextAlignmentRight;
        
        UILabel *total_Lab = [[UILabel alloc]initWithFrame:CGRectMake(screen_width-180, 70, 170, 30)];
        total_Lab.text = @"总计：3000元";
        total_Lab.font = [UIFont systemFontOfSize:15];
        total_Lab.textAlignment = NSTextAlignmentRight;
        
        [view addSubview:yaj_Lab];
        [view addSubview:zuj_Lab];
       // [view addSubview:total_Lab];
        
        UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(30, 90, screen_width, 40)];
        name.font = [UIFont systemFontOfSize:14];
        name.text = @"购买免赔服务";
        name.textAlignment = NSTextAlignmentLeft;
        
        UILabel *price = [[UILabel alloc]initWithFrame:CGRectMake(10, 130, screen_width, 20)];
        price.font = [UIFont systemFontOfSize:14];
        price.text =[NSString stringWithFormat:@"免赔服务费：¥%@/件",self.settleDic[@"server"][@"sprice"]];
        price.textColor = BUTTON_COLOR;
        price.textAlignment = NSTextAlignmentLeft;

        
        UILabel *check_Lab = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, 20, 20)];
        [check_Lab LabelWithIconStr:@"\U0000e606" inIcon:iconfont andSize:CGSizeMake(15, 15) andColor:BASE_GRAY_COLOR andiconSize:15];
        check_Lab.tag = 87878;
        
        UIButton *btns = [UIButton buttonWithType:UIButtonTypeCustom];
        btns.frame = CGRectMake(0, 90, screen_width, 40);
        [btns addTarget:self action:@selector(selelctSevice) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(10, 150, screen_width, 30);
        [btn setTitle:@"什么是免赔服务?" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(checkSevice) forControlEvents:UIControlEventTouchUpInside];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //name.text = self.cartList[section][@"name"];
        view.backgroundColor = viewcontrollerColor;
        
        [view addSubview:name];
        [view addSubview:check_Lab];
        [view addSubview:price];
        [view addSubview:btns];
        [view addSubview:btn];
        return view;
    }else{
    return [[UIView alloc]initWithFrame:CGRectZero];
    }

}
-(void)selelctSevice{
    self.selectSevice = !self.selectSevice;
   
        CGFloat goodPrice = [self.settleDic[@"totalPrice"][@"ordertotal"] floatValue];
NSInteger nums =  [self.settleDic[@"totalPrice"][@"num"] integerValue];
        CGFloat sevicePrice = 0.00;
    if(self.selectSevice){
        sevicePrice =  [self.settleDic[@"server"][@"sprice"] floatValue]*nums;
    }
        //  CGFloat couposPrice = [self.coupsPriceNum floatValue];
        CGFloat couposPrice = [self.coupsPriceNum floatValue];
        CGFloat total = self.shipFee+goodPrice-couposPrice+sevicePrice;
        NSString *price= [NSString stringWithFormat:@"实付：¥%.2f",total];
        
        
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:price ];
        [AttributedStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:ICONNAME size:16] range:NSMakeRange(4, price.length-4)];
        self.price.attributedText = AttributedStr;
    
    

    
    
    UILabel *label = (UILabel *)[self.view viewWithTag:87878];
    label.textColor = self.selectSevice?BUTTON_COLOR:BASE_GRAY_COLOR;
}
-(void)checkYaj{
    self.corver_View.hidden = 0;
    self.sevice_Tv.text = self.settleDic[@"server"][@"frozen"];
}
-(void)checkSevice{
    self.corver_View.hidden = 0;
     self.sevice_Tv.text = self.settleDic[@"server"][@"content"];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if(indexPath.section==0)
//    {
//    if(indexPath.row==0)
//    {
//        AddressListViewController *vc = [[AddressListViewController alloc]init];
//        vc.needback = 1;
//        vc.select = ^(NSDictionary *dic){
////            NSMutableDictionary *dics = [[NSMutableDictionary alloc]initWithDictionary:self.settleDic];
////            [dics setObject:dic forKey:@"addressList"];
//            self.user_Add = dic;
//            [self cacuShipPrice];
//            [self.tableView reloadData];
//        
//        };
//        [self pushView:vc];
//    }
//    }
}
//输入框结束编辑
-(void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"结束编辑");
    self.interNum = textField.text;
    self.intergprice =[self.interNum floatValue]/self.pointpre;

    NSLog(@"积分抵扣==%.2f,%@,%.2f",self.intergprice,self.interNum,self.pointpre);
//    self.intergprice =[NSString stringWithFormat:@"%.2f", [self.interNum integerValue]/self.pointpre];
    [self.tableView reloadData];
}
-(void)cacuShipPrice
{
    if(!self.user_Add)
    {
        [WToast showWithText:@"请选择地址"];
        return;
       // return @"111" ;
    }
//    NSString *weight ;
//    int weigh = 0;
//    for(int i =0;i< [self.settleDic[@"cartList"]count];i++)
//    {
//        NSDictionary *dics = self.settleDic[@"cartList"][i];
//
//        if([dics[@"is_free_shipping"]integerValue]==0)
//        {
//            weigh= weigh+[dics[@"goods_num"]intValue]*[dics[@"weight"]intValue];
//            self.allshipFree = 0;
//        }else
//        {
//            self.allshipFree = 1;
//            self.ShipPrice = @"包邮";
//            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
//        }
//
//
//    }
//    weight = [NSString stringWithFormat:@"%d",weigh];
    NSDictionary *paramter = @{@"weight":self.settleDic[@"totalPrice"][@"weight"],@"province":self.user_Add[@"province"],@"city":self.user_Add[@"city"],@"district":self.user_Add[@"district"]};
    
    [self postWithURLString:@"/cart/sendfree" parameters:paramter success:^(id response) {
        NSLog(@"计算快递费用：%@",response);
        self.ShipPrice = [NSString stringWithFormat:@"¥%@",response[@"result"]];
        self.shipFee = [response[@"result"]floatValue];
        


        CGFloat goodPrice = [self.settleDic[@"totalPrice"][@"total_fee"] floatValue];
      //  CGFloat couposPrice = [self.coupsPriceNum floatValue];
        CGFloat couposPrice = [self.coupsPriceNum floatValue];
        CGFloat total = self.shipFee+goodPrice-couposPrice;
         NSString *price= [NSString stringWithFormat:@"实付：¥%.2f",total];
  
        
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:price ];
        [AttributedStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:ICONNAME size:16] range:NSMakeRange(4, price.length-4)];
        self.price.attributedText = AttributedStr;

        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
    } failure:^(NSError *error) {
        
    }];
    
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
-(void)loadShopcar
{
    if(![XTool GetDefaultInfo:USER_INFO])return;
    //if([XTool GetDefaultInfo:SHOPCARDATA])return;
    NSDictionary *userDic = [XTool GetDefaultInfo:USER_INFO];
    NSDictionary *dic = @{@"user_id":[NSString stringWithFormat:@"%@",userDic[USER_ID]]};
    [self postWithURLString:@"/Cart/cartList" parameters:dic success:^(id response) {
        NSLog(@"获取购物车数据:%@",response);
        if(response)
        {
            //   [XTool SaveDefaultInfo:response Key:SHOPCARDATA];
            NSString *nums =  [NSString stringWithFormat:@"%@",[response objectForKey:@"result"][@"total_price"][@"num"]];
            [XTool SaveDefaultInfo:nums Key:SHOPCARNUMS];
            NSDictionary *userDic = @{@"num":nums};
            [[NSNotificationCenter defaultCenter]postNotificationName:@"addshopNumber" object:userDic];
            
            
            
        }
    } failure:^(NSError *error) {
        
    }];
    
}

- (IBAction)payNow:(UIButton *)sender {
   // [self wftPay];
    if(!self.user_Add)
    {
        [WToast showWithText:@"请选择地址"];
        return;
    }
      NSDictionary *param = @{@"deductibles":[NSString stringWithFormat:@"%d",self.selectSevice], @"user_id":[XTool GetDefaultInfo:USER_INFO][USER_ID],@"address_id":self.user_Add[@"address_id"],@"shipping_code":self.shipCode,@"act":@"submit_order",@"money":[NSString stringWithFormat:@"%d",self.seletUserMoney],@"coupon_id":self.conpousId,@"pay_points":self.interNum};
      [self postWithURLString:@"/cart/cart3" parameters:param success:^(id response) {
        NSLog(@"下单接口%@",response);
      
        if([[response objectForKey:@"status"]integerValue]==1)
        {
            [WToast showWithText:response[@"msg"]];
            OrderListViewController *vc = [[OrderListViewController alloc]init];
            vc.sattus = @"";
            [self loadShopcar];
            [self pushView:vc];

        }
    } failure:^(NSError *error) {
        
    }];
}
@end
