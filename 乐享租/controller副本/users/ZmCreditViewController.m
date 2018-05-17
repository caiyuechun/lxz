//
//  WriteShipViewController.m
//  乐享租
//
//  Created by caiyc on 18/3/23.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "ZmCreditViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "DataSigner.h"
//#import <ZMCreditSDK/ALCreditService.h>
//#import "ZmWebViewController.h"
#import "APAuthV2Info.h"
#import "RSADataSigner.h"
#import "CreditViewController.h"
@interface ZmCreditViewController ()
{
    dispatch_source_t _timer;
}
@end

@implementation ZmCreditViewController
-(void)credit:(NSNotification *)noti{
        NSDictionary *param = @{@"user_id":[XTool GetDefaultInfo:USER_INFO][USER_ID]};
        [self postWithURLString:@"/zhima/zm_success" parameters:param success:^(id response) {
            if(response){
                [self loadCreditUserInfo];
            }
        } failure:^(NSError *error) {
            
        }];
   

    
    
}
//获取认证成功的信息
-(void)loadCreditUserInfo{
       NSDictionary *param = @{@"user_id":[XTool GetDefaultInfo:USER_INFO][USER_ID]};
    [self postWithURLString:@"/zhima/userprower" parameters:param success:^(id response) {
        if(response){
            self.input_View.hidden = 1;
            self.result_View.hidden = 0;
            self.result_View.frame = CGRectMake(0, naviHei, screen_width, self.result_View.frame.size.height);
            self.next_Btn.hidden = 1;
            self.user_Name.text = [NSString stringWithFormat:@"姓名：%@",response[@"result"][@"true_name"]];
            self.level_Name.text = [NSString stringWithFormat:@"信用等级：%@",response[@"result"][@"levelname"]];
            self.idCard.text = [NSString stringWithFormat:@"身份证：%@",response[@"result"][@"idcard"]];

        }
    } failure:^(NSError *error) {
        
    }];

}
- (void)viewDidLoad {
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(credit:) name:@"credited" object:nil];
    [self initNaviView:nil hasLeft:1 leftColor:nil title:@"信用授权" titleColor:nil right:@"" rightColor:nil rightAction:nil];
    self.next_Btn.layer.masksToBounds = 1;
    self.next_Btn.layer.cornerRadius = 25;
    self.result_View.hidden = 1;
    [self loadStatus];
   // self.goodNum_Tf.text = [NSString stringWithFormat:@"%@",self.goodDic[@"goods_id"]];
    // Do any additional setup after loading the view from its nib.
}
-(NSDictionary *)convertjsonStringToDict:(NSString *)jsonString{
    
    NSDictionary *retDict = nil;
    if ([jsonString isKindOfClass:[NSString class]]) {
        NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        retDict = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:NULL];
        return  retDict;
    }else{
        return retDict;
    }
    
}
//先获取用户认证情况
-(void)loadStatus{
    NSDictionary*param = @{@"user_id":[XTool GetDefaultInfo:USER_INFO][USER_ID]};
    [self postWithURLString:@"/zhima/config" parameters:param success:^(id response) {
        if(response){
            
            NSInteger code_Res = [response[@"result"]integerValue];
            if(code_Res==1){
                //走第二步获取网页授权链接
              //  [self loadauthInfo];
            }else if (code_Res==2){
              //整个过程已经完成
              //  self.input_View.hidden = 1;
                self.input_View.hidden = 1;
                self.result_View.hidden = 0;
                self.result_View.frame = CGRectMake(0, naviHei, screen_width, self.result_View.frame.size.height);
                self.next_Btn.hidden = 1;
                [self loadCreditUserInfo];
            }
            else{
               //走第一步输入身份证和姓名
            }
        }
    } failure:^(NSError *error) {
        
    }];

}
-(void)loadauthInfo{
    NSDictionary *param = @{@"user_id":[XTool GetDefaultInfo:USER_INFO][USER_ID]};
[self postWithURLString:@"/zhima/zm_power" parameters:param success:^(id response) {
    if(response){
//    NSString *urls = response[@"result"];
//        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:urls]];
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
-(void)timeRequest{
    __block int timeout = 180; //倒计时时间
    
        if (timeout!=0) {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            
            _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
            
            dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
            dispatch_source_set_event_handler(_timer, ^{
                if(timeout<=0){ //倒计时结束，关闭
                    [WToast showWithText:@"认证超时"];
//
                    dispatch_source_cancel(_timer);
                    _timer = nil;
//                    dispatch_async(dispatch_get_main_queue(), ^{
//
//                    });
               }else{
                   NSDictionary*param = @{@"user_id":[XTool GetDefaultInfo:USER_INFO][USER_ID]};
                   [self postWithURLString:@"/zhima/config" parameters:param success:^(id response) {
                       if(response){
                           
                           NSInteger code_Res = [response[@"result"]integerValue];
                           if(code_Res==1){
                               dispatch_source_cancel(_timer);
                               [self autoAli];
                           }else if (code_Res==2){
                            dispatch_source_cancel(_timer);
                           }
                           else{
                           
                           }
                       }
                   } failure:^(NSError *error) {
                       
                   }];
                }
            });
            timeout--;
        }
      dispatch_resume(_timer);
}
//支付宝授权
-(void)autoAli{
    //生成auth info对象
    NSString *pid = @"2088031889272312";
    NSString *appID = @"2018042460018473";
    NSString *rsa2PrivateKey = @"MIIEowIBAAKCAQEA5bBfASMZjqjOUZ038t1g0xuz6c9pKKogr3xUJvo7dMKnxQiTAOGFYdaIfQ/1YDL7mhIMLeVNG/04hckW12wN76vRauOUc45pkjzURzn+ct+sktBUib1MwG1musUSHSjZMKdO0fVMUF0s5zQq5qc86ciXAQPnLUvQVgnek9rWd0ujQsi4j76GXmJJ30FClDOLDzf9+UJZyssvXCok6YS0IXQzUxTN8Ka2jt6vmPltojHP06SJtJ3J/Txqdmh/A/PvIaylzg1knb10u3Bz3JT8NY3+pyS7Pbrug0WVQhR1vXvRSot63c//G+A2rYfSN8nHIweCVlmFyJTtZ3bhPo2FMwIDAQABAoIBAHslOXqBmBU9egiV00ZZ3KyywJ4NvuK3e/i6HuAa7z+lkY95Dl+9ieavv9PVd4hRLUYogPEmbFYiSGiqLJ3o5/vk0c2OIKxn4UAvbtyVQk/SjlLUcU67+Gd/AEIIoLKTkQad3QuCiZzYp9d5x7qMVYM+MX+w2QQXDqbiebwp6yxflBaAci71FNNX63t9xMwgL8kTTZgaHyoYMCvx19IL9icmywcjDz0llq0HHvqOfyjyIZagErcgjEBaWgSFcE+sQKL3A4q8KLcTOeNb7x0ypG8jlehWLL62tEeAccvcCKyErnmN49oCjFwhi3L5sw7uXDo3Mo6c7iTWG1KuJRQV3nkCgYEA+SDqKo3jeCVHQ2QzRnr3ZfpTTBgPkm0iupkWDJdLv7Fn1YVtP7tk/brv6nJg4CiwfdTfoGzLUTooSfVD0caz7ujhE4MoMWOA+UFioh+cfyjDNCyGT3F8+PrOwqxVYtYTHtAjYdQ0BnyxJ95njKeE5eIoPiyYiMed7WQSkrgw/OcCgYEA7AYxseTdGrym5hPv9UAvTPoAPMmDr243TIWSatcwdyh5K7bVuQDM6viniYEpbMXbnb9BG/dXdp7oXa8ZO2QbsZIGyzQZrvl7FPgTwtK/5TOcTrHBxWJpuYph37RTc68d1gJVo9bj3ykPdIszJEF2kVMITwNTPptErgN0OHn3/9UCgYA8goAd4eS0E+nhNn81yTw56rk8rENr/1IGHJS8bisZ3k8oD4ZfinaXIkaPnURmbbugdIn0fzhK/GM4w3e7hhXCG5I/mQW0KUT0RatdUWxDfnUbQQ1GUnxWRSTfJ9h9bx2pyEgvxMj2ImctFdn00eN3qpy3rUFHR6TWOg5A0LglVQKBgQDR2H/+hlj/GJPbJAbIqpRjgDMN2Ky4IOoRowCW9VQl3Vo+P4Stw8RtdT6fxrKp/xBPpGejEbo1wPsfsDpiz5K/wfFAYcYkB7Qi5J3NLctnYQer/+ckM2eEi0CRwKYhyKRiThkOXlSjaMJRACIsLffZJVXRykcM9seNX4zJWcfhMQKBgDvCB5Ra0F5u85x8Tx0fFGWpt2UEzmsmLS8AvufVzvBLFU3TGmWjkjn4DxIf6zVkhrnr2C/CfE68rZ/x1DalPWQsdD2hiD6ZHfaEXdaSIiaHcIyHPuQlQUurJUfcAxR64SEDQGbv0hRHp0i+5UImsy7HH++mfOd4AdLXTMytnxfL";
    NSString *rsaPrivateKey = @"MIIEowIBAAKCAQEA5bBfASMZjqjOUZ038t1g0xuz6c9pKKogr3xUJvo7dMKnxQiTAOGFYdaIfQ/1YDL7mhIMLeVNG/04hckW12wN76vRauOUc45pkjzURzn+ct+sktBUib1MwG1musUSHSjZMKdO0fVMUF0s5zQq5qc86ciXAQPnLUvQVgnek9rWd0ujQsi4j76GXmJJ30FClDOLDzf9+UJZyssvXCok6YS0IXQzUxTN8Ka2jt6vmPltojHP06SJtJ3J/Txqdmh/A/PvIaylzg1knb10u3Bz3JT8NY3+pyS7Pbrug0WVQhR1vXvRSot63c//G+A2rYfSN8nHIweCVlmFyJTtZ3bhPo2FMwIDAQABAoIBAHslOXqBmBU9egiV00ZZ3KyywJ4NvuK3e/i6HuAa7z+lkY95Dl+9ieavv9PVd4hRLUYogPEmbFYiSGiqLJ3o5/vk0c2OIKxn4UAvbtyVQk/SjlLUcU67+Gd/AEIIoLKTkQad3QuCiZzYp9d5x7qMVYM+MX+w2QQXDqbiebwp6yxflBaAci71FNNX63t9xMwgL8kTTZgaHyoYMCvx19IL9icmywcjDz0llq0HHvqOfyjyIZagErcgjEBaWgSFcE+sQKL3A4q8KLcTOeNb7x0ypG8jlehWLL62tEeAccvcCKyErnmN49oCjFwhi3L5sw7uXDo3Mo6c7iTWG1KuJRQV3nkCgYEA+SDqKo3jeCVHQ2QzRnr3ZfpTTBgPkm0iupkWDJdLv7Fn1YVtP7tk/brv6nJg4CiwfdTfoGzLUTooSfVD0caz7ujhE4MoMWOA+UFioh+cfyjDNCyGT3F8+PrOwqxVYtYTHtAjYdQ0BnyxJ95njKeE5eIoPiyYiMed7WQSkrgw/OcCgYEA7AYxseTdGrym5hPv9UAvTPoAPMmDr243TIWSatcwdyh5K7bVuQDM6viniYEpbMXbnb9BG/dXdp7oXa8ZO2QbsZIGyzQZrvl7FPgTwtK/5TOcTrHBxWJpuYph37RTc68d1gJVo9bj3ykPdIszJEF2kVMITwNTPptErgN0OHn3/9UCgYA8goAd4eS0E+nhNn81yTw56rk8rENr/1IGHJS8bisZ3k8oD4ZfinaXIkaPnURmbbugdIn0fzhK/GM4w3e7hhXCG5I/mQW0KUT0RatdUWxDfnUbQQ1GUnxWRSTfJ9h9bx2pyEgvxMj2ImctFdn00eN3qpy3rUFHR6TWOg5A0LglVQKBgQDR2H/+hlj/GJPbJAbIqpRjgDMN2Ky4IOoRowCW9VQl3Vo+P4Stw8RtdT6fxrKp/xBPpGejEbo1wPsfsDpiz5K/wfFAYcYkB7Qi5J3NLctnYQer/+ckM2eEi0CRwKYhyKRiThkOXlSjaMJRACIsLffZJVXRykcM9seNX4zJWcfhMQKBgDvCB5Ra0F5u85x8Tx0fFGWpt2UEzmsmLS8AvufVzvBLFU3TGmWjkjn4DxIf6zVkhrnr2C/CfE68rZ/x1DalPWQsdD2hiD6ZHfaEXdaSIiaHcIyHPuQlQUurJUfcAxR64SEDQGbv0hRHp0i+5UImsy7HH++mfOd4AdLXTMytnxfL";
    APAuthV2Info*authInfo = [APAuthV2Info new];
    
    authInfo.pid= pid;
    
    authInfo.appID= appID;
    
    //auth type
    
    NSString*authType = [[NSUserDefaults standardUserDefaults]objectForKey:@"authType"];
    
    if(authType) {
        
        authInfo.authType= authType;
        
    }
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    
    NSString*appScheme =@"lxz";
    
    //将授权信息拼接成字符串
    
    NSString*authInfoStr = [authInfo description];
    
    NSLog(@"authInfoStr = %@",authInfoStr);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    
    NSString*signedString =nil;
    
    RSADataSigner* signer = [[RSADataSigner alloc]initWithPrivateKey:((rsa2PrivateKey.length>1)?rsa2PrivateKey:rsaPrivateKey)];
    //  signedString = @"47qjhkdafajklfjkaskjfkas";
    if((rsa2PrivateKey.length>1)) {
        
        signedString = [signer signString:authInfoStr withRSA2:YES];
        
    }else{
        
        signedString = [signer signString:authInfoStr withRSA2:NO];
        
    }
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    
    if(signedString.length>0) {
        
        authInfoStr = [NSString stringWithFormat:@"%@&sign=%@&sign_type=%@", authInfoStr, signedString, ((rsa2PrivateKey.length>1)?@"RSA2":@"RSA")];
        
        [[AlipaySDK defaultService]auth_V2WithInfo:authInfoStr
         
                                        fromScheme:appScheme
         
                                          callback:^(NSDictionary*resultDic) {
                                              NSLog(@"....resultDic==%@",resultDic);
                                              NSString*result = resultDic[@"result"];
                                              
                                              NSString*authCode =nil;
                                              if(result.length>0) {
                                                  
                                                  NSArray*resultArr = [result componentsSeparatedByString:@"&"];
                                                  
                                                  for(NSString*subResult in resultArr) {
                                                      
                                                      if(subResult.length>10&& [subResult hasPrefix:@"auth_code="]) {
                                                          
                                                          authCode = [subResult substringFromIndex:10];
                                                          
                                                          break;
                                                          
                                                      }
                                                      
                                                  }
                                                  
                                              }
                                              
                                              NSLog(@"授权结果authCode = %@", authCode?:@"");
                                              NSDictionary *param = @{@"user_id":[XTool GetDefaultInfo:USER_INFO][USER_ID],@"auth_code":authCode};
                                              [self postWithURLString:@"/zhima/auth_code" parameters:param success:^(id response) {
                                                  if(response){
//                                                      [WToast showWithText:@"认证完成"];
//                                                      CreditViewController *vc = [cret];
                                                  }
                                              } failure:^(NSError *error) {
                                                  
                                              }];
                                              
                                          }];
    }

}
- (IBAction)nextAction:(id)sender {
    [self.view endEditing:1];
    if([self.shipcode_Tf.text isEqualToString:@""]||[self.shipName_Tf.text isEqualToString:@""]){
        [WToast showWithText:@"请填写完整的身份信息"];
        return;
    }
    NSDictionary *param = @{@"user_id":[XTool GetDefaultInfo:USER_INFO][USER_ID],@"true_name":self.shipName_Tf.text,@"idcard":self.shipcode_Tf.text};
    [self postWithURLString:@"/zhima/initialize" parameters:param success:^(id response) {
        NSLog(@"res==%@",response);
        if(response){
          //  [self timeRequest];
            NSURL *url =[NSURL URLWithString:response[@"result"]];
            [[UIApplication sharedApplication]openURL:url];
        }
    } failure:^(NSError *error) {
        
    }];
//    if(self.needBack==1){
//         NSDictionary *param = @{@"user_id":[XTool GetDefaultInfo:USER_INFO][USER_ID],@"true_name":self.shipName_Tf.text,@"idcard":self.shipcode_Tf.text};
//        self.shipDic(param);
//          [self.navigationController popViewControllerAnimated:0];
//    }else{
//    
//        NSDictionary *param = @{@"user_id":[XTool GetDefaultInfo:USER_INFO][USER_ID],@"goods_id":self.goodDic[@"goods_id"],@"shipping_name":self.shipName_Tf.text,@"shipping_code":self.shipcode_Tf.text};
//
//      [self postWithURLString:@"/goods/myold_deliver" parameters:param success:^(id response) {
//        if(response){
//            [WToast showWithText:@"提交成功"];
//            [self.navigationController popViewControllerAnimated:0];
//        }
//    } failure:^(NSError *error) {
//        
//    }];
//    }
}
@end
