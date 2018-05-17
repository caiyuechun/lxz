//
//  LoginViewController.m
//  滴滴看房-经纪人
//
//  Created by caiyc on 18/3/6.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "LoginViewController.h"
#import "RegistViewController.h"
#import "ChangePwdViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "DataSigner.h"
#import <ZMCreditSDK/ALCreditService.h>
#import "ZmWebViewController.h"
#import "APAuthV2Info.h"
#import "RSADataSigner.h"
#import <ShareSDK/ShareSDK.h>
#import "BindViewController.h"
@interface LoginViewController ()
@property(assign)BOOL thirdLogin;
@property(nonatomic,strong)NSDictionary *thirdDic;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.corver_view.hidden = 1;
    self.corver_view.backgroundColor = RGBA(0, 0, 0, .5);
    self.handel_View.layer.masksToBounds  = 1;
    self.handel_View.layer.cornerRadius = 5;
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"test" object:nil];
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setFrame:CGRectMake(leftSpece,(naviHei-btnSize)/2+10 , btnSize, btnSize)];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(leftSpece,(naviHei-btnSize)/2+10 , btnSize, btnSize)];
    [label LabelWithIconStr:@"\U0000e642" inIcon:iconfont andSize:CGSizeMake(30, 30) andColor:[UIColor blackColor] andiconSize:20];
    [self.view addSubview:label];

  //  [leftBtn ButtonWithIconStr:@"\U0000e642" inIcon:iconfont andSize:CGSizeMake(btnSize, btnSize) andColor:[UIColor blackColor] andiconSize:PAPULARFONTSIZE];
    [leftBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftBtn];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView)];
    [self.view addGestureRecognizer:tap];
    
    [self.acount_Lab LabelWithIconStr:@"\U0000e624" inIcon:iconfont andSize:CGSizeMake(40, 40) andColor:BASE_GRAY_COLOR andiconSize:30];
    [self.pass_Lab LabelWithIconStr:@"\U0000e602" inIcon:iconfont andSize:CGSizeMake(40, 40) andColor:BASE_GRAY_COLOR andiconSize:30];
    self.login_btn.layer.masksToBounds = 1;
    
    self.login_btn.layer.cornerRadius = 25;
    
    self.getValid_btn.layer.borderColor = BUTTON_COLOR.CGColor;
    self.getValid_btn.layer.borderWidth = 0.8;
    
    [self.qqLogin_Lab LabelWithIconStr:@"\U0000e665" inIcon:iconfont andSize:CGSizeMake(30, 30) andColor:RGB(235, 67, 60) andiconSize:30];
    [self.weiboLogin_Lab LabelWithIconStr:@"\U0000e667" inIcon:iconfont andSize:CGSizeMake(30, 30) andColor:RGB(235, 67, 60) andiconSize:30];
     [self.weixinLogin_Lab LabelWithIconStr:@"\U0000e635" inIcon:iconfont andSize:CGSizeMake(40, 40) andColor:RGB(235, 67, 60) andiconSize:30];
    UITapGestureRecognizer *tapss = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideCorver)];
    [self.corver_view addGestureRecognizer:tapss];
    // Do any additional setup after loading the view from its nib.
}
-(void)hideCorver{
    self.corver_view.hidden = 1;
}
-(void)tapView{
    [self.view endEditing:1];
}
-(void)back{
    [self.navigationController popViewControllerAnimated:0];
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

- (IBAction)regist_Action:(UIButton *)sender {
    RegistViewController *vc = [[RegistViewController alloc]init];
    [self pushView:vc];
}
//忘记密码
- (IBAction)mobileNouser_Action:(UIButton *)sender {
    ChangePwdViewController *vc = [[ChangePwdViewController alloc]init];
    [self pushView:vc];
}

//登录
- (IBAction)login_Action:(id)sender {
    [self.view endEditing:1];
    if([self.acount_Tf.text isEqualToString:@""]){
        [WToast showWithText:@"请填写完整登录信息"];
        return;
    }
    NSDictionary *param = nil;
    if(self.thirdLogin){
      //  NSDictionary *parameters = @{@"openid":openId,@"oauth":@"wx",@"nickname":user.nickname,@"head_pic":[user icon]};

    param = @{@"username":self.acount_Tf.text,@"password":self.pass_Tf.text,@"isync":@"1",@"openid":self.thirdDic[@"openid"],@"oauth":self.thirdDic[@"oauth"],@"nickname":self.thirdDic[@"nickname"],@"head_pic":self.thirdDic[@"head_pic"]};
    }
  else
      param = @{@"username":self.acount_Tf.text,@"password":self.pass_Tf.text};
    [self postWithURLString:@"/user/login" parameters:param success:^(id response) {
       
        if(response){
             [WToast showWithText:response[@"msg"]];
            NSDictionary *dic = [NSDictionary changeType:response[@"result"]];
            [XTool SaveDefaultInfo:dic Key:USER_INFO];
            [self.navigationController popViewControllerAnimated:1];
        }
    } failure:^(NSError *error) {
        
    }];
//    NSDictionary *param = @{@"do":@"Login",@"mobile":self.acount_Tf.text,@"code":self.pass_Tf.text,@"type":@"1",@"jpushID":[XTool GetDefaultInfo:@"registrationID"]};
//    [self WeqpostWithparameters:param success:^(id response) {
//        if(response){
//            [WToast showWithText:@"登录成功"];
//            [XTool SaveDefaultInfo:response[@"data"] Key:USER_INFO];
//            [self.navigationController popViewControllerAnimated:0];
//        }
//    } failure:^(NSError *error) {
//        
//    }];

    
}
- (NSString* )URLEncodedStringWithUrl:(NSString* )url {
    NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,(CFStringRef)url,NULL,(CFStringRef) @"!'();:@&=+$,%#[]|",kCFStringEncodingUTF8));
    return encodedString;
}
//获取验证码
- (IBAction)getvaldAction:(id)sender {
//    if([self.acount_Tf.text isEqualToString:@""]){
//        [WToast showWithText:@"请填写手机号"];
//        return;
//    }
   // NSDictionary *parma = @{@"do":@"Sms",@"mobile":self.acount_Tf.text};
//    [self WeqpostWithparameters:parma success:^(id response) {
//        if(response){
//            
//            [WToast showWithText:response[@"msg"]];
//        }
//    } failure:^(NSError *error) {
//        
//    }];

}
- (void)result:(NSMutableDictionary*)dic{

}
- (IBAction)WxLogin:(UIButton *)sender {
    [ShareSDK getUserInfo:SSDKPlatformTypeWechat onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
        if (state == SSDKResponseStateSuccess)
        {
            
            NSLog(@"uid=%@",user.uid);
            NSLog(@"%@",[user.credential.rawData objectForKey:@"unionid"]);
            NSLog(@"token=%@",user.credential.token);
            NSLog(@"nickname=%@",user.nickname);
            NSString *openId = [user.credential.rawData objectForKey:@"unionid"];
            NSDictionary *parameters = @{@"openid":openId,@"oauth":@"wx",@"nickname":user.nickname,@"head_pic":[user icon]};
            self.thirdDic = parameters;
           // self.thirdLogin = 1;
            AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
            
            [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/html", nil]];
            NSString *urlString = [NSString stringWithFormat:@"%@/user/thirdLogin",BASE_URL];
            NSLog(@"...url...%@",urlString);
            [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                [WToast showWithText:responseObject[@"msg"]];
                NSLog(@".....response...%@",responseObject);
                if([responseObject[@"status"]integerValue]!=1)
                {
                    self.corver_view.hidden = 0;
                  //  [WToast showWithText:@"请绑定, 没账号请先进行注册"];
                   // LoginViewController *vc = [[LoginViewController alloc]init];
                    
//                    NSDictionary *userDic = @{@"openid":openId,@"oauth":@"wx",@"nickname":user.nickname,@"head_pic":[user icon]};

                    
                }else
                {
                    NSDictionary *newDic = [NSDictionary changeType:responseObject[@"result"]];
                    [self.navigationController popViewControllerAnimated:NO];
                    [XTool SaveDefaultInfo:newDic Key:USER_INFO];

                    
                }
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"网络请求失败:%@",error);
            }];
            
        }
        
    }];

}


- (BOOL)canOpenAlipay {
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"alipays://"]];
}
- (IBAction)handelThird:(UIButton *)sender {
    if(sender.tag==0){
        BindViewController *vc = [[BindViewController alloc]init];
        [self pushView:vc];
    }else{
        RegistViewController *vc = [[RegistViewController alloc]init];
        vc.thirdDic = self.thirdDic;
        [self pushView:vc];
    }
}
@end
