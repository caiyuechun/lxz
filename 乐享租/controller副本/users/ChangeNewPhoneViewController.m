//
//  ChangeNewPhoneViewController.m
//  chuangyi
//
//  Created by yncc on 17/8/15.
//  Copyright © 2017年 changce. All rights reserved.
//

#import "ChangeNewPhoneViewController.h"

@interface ChangeNewPhoneViewController ()
@property(nonatomic,strong)NSString *random_Str;
@end

@implementation ChangeNewPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNaviView:[UIColor whiteColor] hasLeft:1 leftColor:nil title:@"绑定新手机" titleColor:[UIColor blackColor] right:@"" rightColor:nil rightAction:nil];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(missKb)];
    [self.view addGestureRecognizer:tap];
    self.bind_Btn.layer.masksToBounds = 1;
    self.bind_Btn.layer.cornerRadius = 25;
    
    
    
}
-(void)missKb
{
    [self.view endEditing:1];
}
- (IBAction)bindAction:(id)sender {
    [self.view endEditing:1];
    if([self.tfPhone.text isEqualToString:@""]||[self.tfCode.text isEqualToString:@""])
    {
        [WToast showWithText:@"请输入完整信息"];
    }else{
    
    NSDictionary *param = @{@"user_id":[XTool GetDefaultInfo:USER_INFO][USER_ID],@"mobile":self.tfPhone.text,@"step":@"NEW_VALIDATE",@"captcha":self.tfCode.text};
    [self postWithURLString:@"/user/mobile_modify" parameters:param success:^(id response) {
        if(response)
        {
            [WToast showWithText:response[@"msg"]];
            [self.navigationController popToRootViewControllerAnimated:NO];
//            ChangeNewPhoneViewController *vc = [ChangeNewPhoneViewController new ];
//            [self pushView:vc];
            
        }
    } failure:^(NSError *error) {
        
    }];
    }


}
- (IBAction)loadCodeAction:(id)sender {
    [self.view endEditing:1];
    if([self.tfPhone.text isEqualToString:@""]){
        [WToast showWithText:@"请填写手机号"];
        return;
    }
    NSString *secct = [NSString stringWithFormat:@"mobile=%@&secret=8GwuOGonmSbY4xHp",self.tfPhone.text];
    NSString *keys = [XTool md5:secct];
    NSDictionary *dic = @{@"key":keys,@"mobile":self.tfPhone.text,@"action":@"1"};
    [self postWithURLString:@"/User/send_sms_reg_code" parameters:dic success:^(id response) {
        if(response){
            NSLog(@"验证码返回信息：%@",response);
            __block int timeout=60; //倒计时时间
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
            dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
            dispatch_source_set_event_handler(_timer, ^{
                
                if(timeout<=0){ //倒计时结束，关闭
                    dispatch_source_cancel(_timer);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //设置界面的按钮显示 根据自己需求设置
                        [self.getValidBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
                        self.getValidBtn.userInteractionEnabled = YES;
                    });
                }else{
                    int seconds = timeout % 60;
                    NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //设置界面的按钮显示 根据自己需求设置
                        //NSLog(@"____%@",strTime);
                        //[UIView beginAnimations:nil context:nil];
                        //[UIView setAnimationDuration:1];
                        [self.getValidBtn setTitle:[NSString stringWithFormat:@"%@s",strTime] forState:UIControlStateNormal];
                        // [UIView commitAnimations];
                        self.getValidBtn.userInteractionEnabled = NO;
                    });
                    timeout--;
                }
            });
            dispatch_resume(_timer);
            
            
        }
    } failure:^(NSError *error) {
        NSLog(@"error:%@",error);
        
    }];


}
-(void)getcode{
    
    [self.view endEditing:1];
    if([self.tfPhone.text isEqualToString:@""]){
        [WToast showWithText:@"请填写手机号"];
        return;
    }
    NSString *secct = [NSString stringWithFormat:@"mobile=%@&secret=8GwuOGonmSbY4xHp",self.tfPhone.text];
    NSString *keys = [XTool md5:secct];
    NSDictionary *dic = @{@"key":keys,@"mobile":self.tfPhone.text,@"action":@"1"};
    [self postWithURLString:@"/User/send_sms_reg_code" parameters:dic success:^(id response) {
        if(response){
            NSLog(@"验证码返回信息：%@",response);
            __block int timeout=60; //倒计时时间
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
            dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
            dispatch_source_set_event_handler(_timer, ^{
                
                if(timeout<=0){ //倒计时结束，关闭
                    dispatch_source_cancel(_timer);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //设置界面的按钮显示 根据自己需求设置
                        [self.getValidBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
                        self.getValidBtn.userInteractionEnabled = YES;
                    });
                }else{
                    int seconds = timeout % 60;
                    NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //设置界面的按钮显示 根据自己需求设置
                        //NSLog(@"____%@",strTime);
                        //[UIView beginAnimations:nil context:nil];
                        //[UIView setAnimationDuration:1];
                        [self.getValidBtn setTitle:[NSString stringWithFormat:@"%@s",strTime] forState:UIControlStateNormal];
                        // [UIView commitAnimations];
                        self.getValidBtn.userInteractionEnabled = NO;
                    });
                    timeout--;
                }
            });
            dispatch_resume(_timer);
            
            
        }
    } failure:^(NSError *error) {
        NSLog(@"error:%@",error);
        
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

- (IBAction)getvalid:(UIButton *)sender {
}
@end
