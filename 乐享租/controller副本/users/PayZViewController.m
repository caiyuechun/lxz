//
//  PayViewController.m
//  SHOP
//
//  Created by caiyc on 17/4/14.
//  Copyright © 2017年 changce. All rights reserved.
//

#import "PayZViewController.h"
#import "Order.h"
#import "APAuthV2Info.h"
#import "RSADataSigner.h"
//#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>
@interface PayZViewController ()
@property(assign)BOOL AliPay;
@property(assign)BOOL WeixinPay;
@property (weak, nonatomic) IBOutlet UIView *weixinView;
@property(nonatomic,strong)NSString *payType;
@end

@implementation PayZViewController
-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"页面出现");
}
//立即支付F
- (IBAction)payAction:(UIButton *)sender {
    ///Flower/index
    NSDictionary *user_Dic = [XTool GetDefaultInfo:USER_INFO];
      NSDictionary *param = @{@"order_sn":self.orderStr,@"user_id":user_Dic[USER_ID]};
    NSString *url = @"/Flower/index";
    if(self.iscontinue==1){
    url = @"/Flower/renew";
    }
    [self postWithURLString:url parameters:param success:^(id response) {
        if(response){
            NSString*url = response[@"result"];
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:url]];
        }
    } failure:^(NSError *error) {
        
    }];
//    if(!self.payType)
//    {
//        [WToast showWithText:@"选择支付方式"];
//        return;
//    }
//    [self payAli];
//    if(self.ischarge==0){
//        if([self.payType isEqualToString:@"ali"])
//        {
//            //    [self payAliTest];
//            [self payAli];
//        }
//        else [self payWeixin];
//
//    }else{
//    NSDictionary *diction = @{@"order_sn":self.orderStr};
//    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
//    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", nil]];
//    /**
//     *  可以接受的类型
//     */
//    manager.requestSerializer=[AFJSONRequestSerializer serializer];
//    /**
//     *  请求队列的最大并发数
//     */
//    //    manager.operationQueue.maxConcurrentOperationCount = 5;
//    /**
//     *  请求超时的时间
//     */
//    //    manager.requestSerializer.timeoutInterval = 5;
//    NSString *urlString = [NSString stringWithFormat:@"%@/user/orderstock",BASE_URL];
//    NSLog(@"urlstr ===%@",urlString);
//    // NSDictionary *diction = @{@"order_sn":self.orderStr};
//    [manager GET:urlString parameters:diction success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"请求返回%@",responseObject);
//       
//            if([[responseObject objectForKey:@"status"]integerValue]==1)
//            {
//              //  success(responseObject);
//                if([self.payType isEqualToString:@"ali"])
//                {
//                //    [self payAliTest];
//                    [self payAli];
//                }
//                else [self payWeixin];
//
//            }
//            else
//            {
//                [WToast showWithText:responseObject[@"msg"]];
//               // success(nil);
//            }
//            
//            
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//
//    }];
//    }

   
//    [self getWithURLString:@"/user/orderstock" parameters:diction success:^(id response) {
//        NSLog(@"....支付前返回数据%@",response);
//        if(response)
//        {
//            if([self.payType isEqualToString:@"ali"])
//            {
//                [self payAli];
//            }
//            else [self payWeixin];
//
//           
//        }
//    } failure:^(NSError *error) {
//        NSLog(@"错误信息===%@",error);
//    }];

  }
- (IBAction)selectAli:(UIButton *)sender {
    self.aliSelectLb.textColor = [UIColor orangeColor];
    self.weixinSelectLb.textColor = [UIColor grayColor];
    self.payType = @"ali";
    
}
- (IBAction)selectWeixn:(UIButton *)sender {
    self.aliSelectLb.textColor = [UIColor grayColor];
    self.weixinSelectLb.textColor = [UIColor orangeColor];
    self.payType = @"weixin";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.weixinView.hidden = 1;
    NSDictionary *user_Dic = [XTool GetDefaultInfo:USER_INFO];
    if([user_Dic[@"role"]integerValue]==1||[user_Dic[@"role"]integerValue]==0||self.ischarge==1){
        self.hide_View.hidden = 1;
//        [WToast showWithText:@"你不是业务员，暂无无权限查看"];
//        return;
    }

    [self initNaviView:[UIColor whiteColor] hasLeft:1 leftColor:[UIColor grayColor] title:@"支付" titleColor:[UIColor blackColor] right:@"" rightColor:nil rightAction:nil];
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(paynoti:) name:@"paynoti" object:nil];
    self.view.backgroundColor = viewcontrollerColor;
    
    self.orderNum.text = [NSString stringWithFormat:@"订单编号：%@", self.orderStr];
    self.cashNum.text = [NSString stringWithFormat:@"订单金额：%@元", self.cashStr];
    [self.aliSelectLb LabelWithIconStr:@"\U0000e606" inIcon:iconfont andSize:CGSizeMake(30, 30) andColor:[UIColor grayColor] andiconSize:25];
    [self.weixinSelectLb LabelWithIconStr:@"\U0000e606" inIcon:iconfont andSize:CGSizeMake(30, 30) andColor:[UIColor grayColor] andiconSize:25];
    // Do any additional setup after loading the view from its nib.
}
//支付宝
-(void)paynoti:(NSNotification *)no
{
    NSLog(@".....%@",no.userInfo[@"payResult"]);
    NSDictionary *payDic = no.userInfo[@"payResult"];
    if([payDic[@"resultStatus"]integerValue]==6001)
    {
        NSLog(@"用户取消支付");
    }
    if([payDic[@"resultStatus"]integerValue]==9000)
    {
        NSLog(@"用户支付成功");
        [WToast showWithText:@"支付成功"];
        [self.navigationController popToRootViewControllerAnimated:YES];
//        NSDictionary *paramter = @{@"order_sn":self.orderStr,@"status":@"1",@"transaction":no.userInfo[@"payType"]};
//        [self getWithURLString:@"/payment/returnurl" parameters:paramter success:^(id response) {
//            if(response)
//            {
//                [WToast showWithText:@"付款成功"];
//                [self.navigationController popViewControllerAnimated:NO];
//                //[self loadData];
//            }
//            NSLog(@"支付之后回调服务器%@",response);
//        } failure:^(NSError *error) {
//            NSLog(@"支付之后回调失败服务器%@",error);
//        }];
    }
    
}

-(void)payWeixin{
    
//    [WToast showWithText:@"商家暂未开放次支付方式"];
//    return;
    NSString *url = @"/pay/wpp";
    if(self.ischarge==1){
        url = @"/pay/wpp";
    }

       NSDate *senddate = [NSDate date];
     NSString *date2 = [NSString stringWithFormat:@"%ld", (long)[senddate timeIntervalSince1970]];
    NSDictionary *paramter = @{@"order_sn":self.orderStr,@"user_id":[XTool GetDefaultInfo:USER_INFO][USER_ID],@"time":date2};
    
    [self getWithURLString:url parameters:paramter success:^(id response) {
        NSLog(@"...微信返回%@",response);
        if(response)
        {
        
//            PayReq* req             = [[PayReq alloc] init];
//           // req.
//            req.partnerId           = @"1502115251";
//            req.prepayId            = response[@"result"][@"prepayid"];
//          //  req.nonceStr            = [self createnonceStr];
//            req.nonceStr            = response[@"result"][@"noncestr"];
//            req.timeStamp = [response[@"result"][@"timestamp"]intValue];
//            req.package             = @"Sign=WXPay";
//            req.sign                = response[@"result"][@"sign"];
//            [WXApi sendReq:req];
        }
    } failure:^(NSError *error) {
        
    }];
//    NSString *partnerId = 
    
}
-(void)payAliTest{
    //重要说明
    //这里只是为了方便直接向商户展示支付宝的整个支付流程；所以Demo中加签过程直接放在客户端完成；
    //真实App里，privateKey等数据严禁放在客户端，加签过程务必要放在服务端完成；
    //防止商户私密数据泄露，造成不必要的资金损失，及面临各种安全风险；
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
//    NSString *appID = @"2018032402439953";
//    
//    // 如下私钥，rsa2PrivateKey 或者 rsaPrivateKey 只需要填入一个
//    // 如果商户两个都设置了，优先使用 rsa2PrivateKey
//    // rsa2PrivateKey 可以保证商户交易在更加安全的环境下进行，建议使用 rsa2PrivateKey
//    // 获取 rsa2PrivateKey，建议使用支付宝提供的公私钥生成工具生成，
//    // 工具地址：https://doc.open.alipay.com/docs/doc.htm?treeId=291&articleId=106097&docType=1
//    NSString *rsa2PrivateKey = @"MIIEowIBAAKCAQEAwwBHIyH5BJdbf5DbAjh8zXwSbNbtLTKkBGbRCYWTrx2aAGrzM2SAov6HxtFKe6lFDUu7BhSCVyJ6uddLOahf4t1eC8NkAioWSbpJzyawis2VDtd91h83eyI9Q/9yAsUjWLFI6HKfO5LY3x06jez/rUA+Gs4a5WrpZ06T3K3e8qRokMaFmGxTQLkPN4OES690drOJxU0YDVBxhjkyc6pJ8PyU+jQ6Y+p5riZkkbsRvZHtrmlRtdfGo0gHOBxPIi6mw6sJP6y4i9TuCWSjtmj2h6DD1eLo5xMSXCiSnjMyuKyhShfgmvINh4qiFa+2CN2AO6V+AK3rZ3E43H7uC5JPgQIDAQABAoIBAQCd43O19qPyG7tyJo+t1J74oiUpCz0vA3naNoW69/UELSuseuxACHg/gWfei0eLqRrIETF1UtXWR4ynPLMkFDjPL/4d+C7ZscoqGDP7DpCTUrIGOmUhIlWB1c9VZ1eg9o4QGju2OljDm7sNrFTk5ah/Vyzx9z+/0jj59J20aPPD8gCtmMu2tSUzXDvvuA7gjuP10bYyKCkbOqNv6jwzMSyyvZyP9IO/66vhm96M9YOApAwor2OTm0DZesflGPw1727lRmVhjhlBT80prtrKKB26dEGWBhzUKGJ6GBWMGM7+AGNNe9wTbL1Blvg/xP5Kefki1Gldtn9Ne0I7K6U9OsWBAoGBAOl8kwyKnvvYjr+r51cSYmI3qekZ7E6o+u3jcWr3vB0paiMjJyt+1g9PbC88mm0Bxq8n1swblzrs7Ne11wLaOXNs0w4MicFa/1W6lzjsKTZ9QTvRpimGYCExNKOowNT5feyxOat7e2UaFJiv0wLoQw6zxX6vxhJ6KpWOmr6yYujNAoGBANXNuDum3YhN4A65tjJG28/g/jkGAcAS/xtNMCiZ7mgyZD/8tuV/7OBAgj61BCiBZum1t9x3GQqqrtpKunc+D1g2l2YvYEeCdR1z/Q9uVy2FmN0lWmnNR6eh7bislmYgrRj0Q8giZI26XD8W6QVWSZu6/ImNgBR/ictfk/uWoNGFAoGAArCXtRZHvJkDE/wz/xHMJluDzpao3UMfGOx82wGdnixi96KpCdw9NRHyKh0lnknd8xifZdyPgnNGSzniDztaXBUN3WSRlbOpq2Ap69L0qpcI0Fqa8nGE2/0IITaJeiqho79q7anPgxuozxV/ddIdK6cwiEQYIRBdOznYWIgPkaUCgYAwenDntbJNkbrYG+vgAokc3ZtHOsFy19vYSOw+iIiyP5rTl22xJAyF3JqrtUe4F39KRtXlu2uGK6VyAbe+CehYzCgQF3XxQPdlMkOTGCXUQJKksi+KBe3VaLYKRbfkeExHeDtWSdYa/MKl24ACocoW8ZMJbXg5LaIE5ysaxNC6MQKBgFpV/WozAC5CsDzj6h/hTl3Cv8cb9tDo3+lAc5iVol+QXCXGPMFs5L/03IfDxQyhcfOenQQyFN2iGSoAq+lJ8imAJwOoLFzuw8iVK23He0M9Mhiv3N9Rx1j+rdFhQqPT2pwMwzSpIvzUZXeMqi3tHWCP6UHCoQw3V3ALk0a1ekg4";
//    NSString *rsaPrivateKey = @"MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAwwBHIyH5BJdbf5DbAjh8zXwSbNbtLTKkBGbRCYWTrx2aAGrzM2SAov6HxtFKe6lFDUu7BhSCVyJ6uddLOahf4t1eC8NkAioWSbpJzyawis2VDtd91h83eyI9Q/9yAsUjWLFI6HKfO5LY3x06jez/rUA+Gs4a5WrpZ06T3K3e8qRokMaFmGxTQLkPN4OES690drOJxU0YDVBxhjkyc6pJ8PyU+jQ6Y+p5riZkkbsRvZHtrmlRtdfGo0gHOBxPIi6mw6sJP6y4i9TuCWSjtmj2h6DD1eLo5xMSXCiSnjMyuKyhShfgmvINh4qiFa+2CN2AO6V+AK3rZ3E43H7uC5JPgQIDAQAB";
//    /*============================================================================*/
//    /*============================================================================*/
//    /*============================================================================*/
//    
//    //partner和seller获取失败,提示
//    if ([appID length] == 0 ||
//        ([rsa2PrivateKey length] == 0 && [rsaPrivateKey length] == 0))
//    {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
//                                                        message:@"缺少appId或者私钥。"
//                                                       delegate:self
//                                              cancelButtonTitle:@"确定"
//                                              otherButtonTitles:nil];
//        [alert show];
//        return;
//    }
//    
//    /*
//     *生成订单信息及签名
//     */
//    //将商品信息赋予AlixPayOrder的成员变量
//    Order* order = [Order new];
//    
//    // NOTE: app_id设置
//    order.app_id = appID;
//    //order.biz_content.seller_id = @"2088721721466457";
//    // NOTE: 支付接口名称
//    order.method = @"alipay.trade.app.pay";
//    
//    // NOTE: 参数编码格式
//    order.charset = @"utf-8";
//    
//    // NOTE: 当前时间点
//    NSDateFormatter* formatter = [NSDateFormatter new];
//    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    order.timestamp = [formatter stringFromDate:[NSDate date]];
//    
//    // NOTE: 支付版本
//    order.version = @"1.0";
//    order.notify_url = @"http://lgxn.ynthgy.com/api/payment/alipayNotify";
//    
//    // NOTE: sign_type 根据商户设置的私钥来决定
//    //   order.sign_type = (rsa2PrivateKey.length > 1)?@"RSA2":@"RSA";
//    order.sign_type = @"RSA";
//    // NOTE: 商品数据
//    order.biz_content = [BizContent new];
//    order.biz_content.body = @"商品购买";
//    order.biz_content.subject = @"商品购买";
//    order.biz_content.out_trade_no =  self.orderStr; //订单ID（由商家自行制定）
//    // order.biz_content.order_SN = self.orderStr;
//    
//    order.biz_content.timeout_express = @"30m"; //超时时间设置
//    // order.biz_content.total_amount = [NSString stringWithFormat:@"%.2f", 0.01]; //商品价格
//    order.biz_content.total_amount =self.cashStr; //商品价格
//    
//    
//    //将商品信息拼接成字符串
//    NSString *orderInfo = [order orderInfoEncoded:NO];
//    NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
//    NSLog(@"orderSpec = %@",orderInfo);
//    
//    // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
//    //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
//    NSString *signedString = nil;
//    RSADataSigner* signer = [[RSADataSigner alloc] initWithPrivateKey:((rsa2PrivateKey.length > 1)?rsa2PrivateKey:rsaPrivateKey)];
//    if ((rsa2PrivateKey.length > 1)) {
//        signedString = [signer signString:orderInfo withRSA2:YES];
//    } else {
//        signedString = [signer signString:orderInfo withRSA2:NO];
//    }
//    
//    // NOTE: 如果加签成功，则继续执行支付
//    if (signedString != nil) {
//        //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
//        NSString *appScheme = @"luoge";
//        
//        // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
//        NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
//                                 orderInfoEncoded, signedString];
//        
//        // NOTE: 调用支付结果开始支付
//        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
//            NSLog(@"reslut = %@",resultDic);
//        }];
//    }
//    

}
//-(void)onResp:(BaseResp*)resp{
//    if ([resp isKindOfClass:[PayResp class]]){
//        PayResp*response=(PayResp*)resp;
//        switch(response.errCode){
//            case WXSuccess:
//                //服务器端查询支付通知或查询API返回的结果再提示成功
//                NSLog(@"支付成功");
//                [WToast showWithText:@"支付成功"];
//                break;
//            default:
//                [WToast showWithText:@"支付失败，请重试"];
//                NSLog(@"支付失败，retcode=%d",resp.errCode);
//                break;
//        }
//    }
//}

//微信支付加密
//-(NSString *) md5:(NSString *)str
//{
//    const char *cStr = [str UTF8String];
//    unsigned char digest[CC_MD5_DIGEST_LENGTH];
//    CC_MD5( cStr, (unsigned int)strlen(cStr), digest );
//    
//    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
//    
//    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
//        [output appendFormat:@"%02X", digest[i]];
//    
//    return output;
//}
-(NSString*)createnonceStr;
{
    char data[32];
    for (int x=0;x<32;data[x++] = (char)('A' + (arc4random_uniform(26))));
    
    return [[NSString alloc] initWithBytes:data length:32 encoding:NSUTF8StringEncoding];
}
-(void)payAli
{
  
NSString *url = @"/payment/alipay_good";
    if(self.ischarge==1){
    url = @"/payment/alipay_rechange";
    }
    NSDictionary *user_Dic = [XTool GetDefaultInfo:USER_INFO];
    NSDictionary *param = @{@"order_sn":self.orderStr,@"user_id":user_Dic[USER_ID]};
   
    [self postWithURLString:url parameters:param success:^(id response) {
        NSLog(@"服务器加签结果==%@",response);
        if(response){
              NSString *appScheme = @"lxz";
            NSString *order_Str  = response[@"result"];
            [[AlipaySDK defaultService] payOrder:order_Str fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
            }];

        }
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

- (IBAction)payOffline:(UIButton *)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确定" message:@"确定选择线下支付" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSDictionary *user_Dic = [XTool GetDefaultInfo:USER_INFO];
        NSDictionary *param = @{@"user_id":user_Dic[USER_ID],@"order_id":self.order_Id};
        [self postWithURLString:@"/payment/cod" parameters:param success:^(id response) {
            // [WToast showWithText:response[@"msg"]];
            if(response){
                [WToast showWithText:@"成功"];
                [self.navigationController popViewControllerAnimated:NO];
            }
        } failure:^(NSError *error) {
            
        }];

    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"再想想" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:confirm];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
   }
@end
