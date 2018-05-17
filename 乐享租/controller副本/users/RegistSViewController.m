//
//  RegistViewController.m
//  滴滴看房-经纪人
//
//  Created by caiyc on 18/3/6.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "RegistSViewController.h"
#import "CreditViewController.h"
#import "ZmCreditViewController.h"
@interface RegistSViewController ()
@property(assign)BOOL agreen;

@end

@implementation RegistSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     [self initNaviView:nil hasLeft:1 leftColor:nil title:@"注册" titleColor:nil right:@"" rightColor:nil rightAction:nil];
     [self.check_Lab LabelWithIconStr:@"\U0000e606" inIcon:iconfont andSize:CGSizeMake(20, 20) andColor:BASE_GRAY_COLOR andiconSize:20];
    self.regist_btn.layer.masksToBounds = 1;
    
    self.regist_btn.layer.cornerRadius = 25;
    
    self.getValid_btn.layer.borderColor = BUTTON_COLOR.CGColor;
    self.getValid_btn.layer.borderWidth = 0.8;
    

    // Do any additional setup after loading the view from its nib.
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

- (IBAction)regist_Action:(id)sender {
    [self.view endEditing:1];
       if([self.mobile_Tf.text isEqualToString:@""]||[self.valid_Tf.text isEqualToString:@""]){
        [WToast showWithText:@"请填写完整注册信息"];
        return;
    }
    if(!self.agreen){
        [WToast showWithText:@"请勾选协议"];
        return;
    }
    self.regist_btn.userInteractionEnabled = 0;
    self.regist_btn.backgroundColor = BASE_GRAY_COLOR;

//    @{@"username":self.acount_Tf.text,@"password":self.pass_Tf.text,@"isync":@"1",@"openid":self.thirdDic[@"openid"],@"oauth":self.thirdDic[@"oauth"],@"nickname":self.thirdDic[@"nickname"],@"head_pic":self.thirdDic[@"head_pic"]};
    NSDictionary *param = nil;
    if(self.thirdDic){
        param = @{@"username":self.moblie,@"password":self.mobile_Tf.text,@"surepasswod":self.valid_Tf.text,@"mobcode":self.valid,@"isync":@"1",@"openid":self.thirdDic[@"openid"],@"oauth":self.thirdDic[@"oauth"],@"nickname":self.thirdDic[@"nickname"],@"head_pic":self.thirdDic[@"head_pic"]};

    }else{
    param = @{@"username":self.moblie,@"password":self.mobile_Tf.text,@"surepasswod":self.valid_Tf.text,@"mobcode":self.valid};
    }
    [self postWithURLString:@"/user/reg" parameters:param success:^(id response){
        self.regist_btn.userInteractionEnabled = 1;
        self.regist_btn.backgroundColor = BUTTON_COLOR;
       
        if(response){
            
         //   [self.navigationController popToRootViewControllerAnimated:NO];
            NSDictionary *dic = [NSDictionary changeType:response[@"result"]];
            [XTool SaveDefaultInfo:dic Key:USER_INFO];
             [WToast showWithText:@"注册成功,请去做信用认证"];
            ZmCreditViewController *vc = [[ZmCreditViewController alloc]init];
            [self pushView:vc];
         //   self.navigationController pushViewController: animated:<#(BOOL)#>
        }
    } failure:^(NSError *error) {
        self.regist_btn.userInteractionEnabled = 1;
        self.regist_btn.backgroundColor = BUTTON_COLOR;
    }];
//    [self WeqpostWithparameters:param success:^(id response) {
//        if(response){
//            [WToast showWithText:response[@"msg"]];
//            [self.navigationController popViewControllerAnimated:0];
//        }
//    } failure:^(NSError *error) {
//        
//    }];
}
//获取验证码
- (IBAction)getValid_Action:(id)sender {
    if([self.mobile_Tf.text isEqualToString:@""]){
        [WToast showWithText:@"请填写手机号"];
        return;
    }
    NSDictionary *parma = @{@"do":@"Sms",@"mobile":self.mobile_Tf.text};
//    [self WeqpostWithparameters:parma success:^(id response) {
//        if(response){
//        
//            [WToast showWithText:response[@"msg"]];
//        }
//    } failure:^(NSError *error) {
//        
//    }];
}
//点击条例
- (IBAction)checkRuleAction:(UIButton *)sender {
    self.agreen = !self.agreen;
    if(self.agreen){
    [self.check_Lab LabelWithIconStr:@"\U0000e606" inIcon:iconfont andSize:CGSizeMake(20, 20) andColor:BUTTON_COLOR andiconSize:20];
    }else{
     [self.check_Lab LabelWithIconStr:@"\U0000e606" inIcon:iconfont andSize:CGSizeMake(20, 20) andColor:BASE_GRAY_COLOR andiconSize:20];
    }

}
@end
