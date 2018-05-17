//
//  ChangePhoneViewController.m
//  chuangyi
//
//  Created by yncc on 17/8/15.
//  Copyright © 2017年 changce. All rights reserved.
//

#import "ChangePhoneViewController.h"
#import "ChangeNewPhoneViewController.h"

@interface ChangePhoneViewController ()
{
    NSString *mobile;
}
@property(nonatomic,strong)NSString *random_Str;
@end

@implementation ChangePhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   self.title = @"验证身份";
    [self.getValidBtn setTitleColor:BASE_COLOR forState:UIControlStateNormal];
    [self initNaviView:[UIColor whiteColor] hasLeft:1 leftColor:nil title:self.title titleColor:[UIColor blackColor] right:@"" rightColor:nil rightAction:nil];
     NSDictionary *userDic = [XTool GetDefaultInfo:USER_INFO];
    mobile = [userDic objectForKey:@"mobile"];
    NSString *phoneNumber = [mobile stringByReplacingCharactersInRange:NSMakeRange(3, 5)  withString:@"*****"];
    
    [_lbPhone setText:phoneNumber];
    self.next_Btn.layer.masksToBounds = 1;
    self.next_Btn.layer.cornerRadius = 25;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(missKb)   ];
    [self.view addGestureRecognizer:tap];

    
    
}
-(void)missKb
{
    [self.view endEditing:1];
}
- (IBAction)codeAction:(id)sender {
    [self.view endEditing:1];
//    if([self.mobileTf.text isEqualToString:@""])
//    {
//        [WToast showWithText:@"请输入电话号码"];
//    }else
//    {
        NSDictionary *params = @{@"mobile":mobile};
        [self postWithURLString:@"/user/code_lgxn" parameters:params success:^(id response) {
            NSLog(@"验证码第一步%@",response);
            if([response[@"status"]integerValue]==1){
                self.random_Str = [NSString stringWithFormat:@"%@", response[@"result"]];
                [self getcode];
            }
        } failure:^(NSError *error) {
            
        }];

//    [self postWithURLString:@"/user/send_sms_reg_code" parameters:@{@"mobile":mobile} success:^(id response) {
//        NSLog(@"%@",response);
//        if(response)
//        {
//            [WToast showWithText:response[@"msg"]];
//            __block int timeout=30; //倒计时时间
//            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//            dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
//            dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
//            dispatch_source_set_event_handler(_timer, ^{
//                if(timeout<=0){ //倒计时结束，关闭
//                    dispatch_source_cancel(_timer);
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        //设置界面的按钮显示 根据自己需求设置
//                        [self.getValidBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
//                        self.getValidBtn.userInteractionEnabled = YES;
//                    });
//                }else{
//                    int seconds = timeout % 60;
//                    NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        //设置界面的按钮显示 根据自己需求设置
//                    [self.getValidBtn setTitle:[NSString stringWithFormat:@"%@s",strTime] forState:UIControlStateNormal];
//                        // [UIView commitAnimations];
//                        self.getValidBtn.userInteractionEnabled = NO;
//                    });
//                    timeout--;
//                }
//            });
//            dispatch_resume(_timer);
//        }
//
//    } failure:^(NSError *error) {
//        
//    }];
    
    
}
-(void)getcode{
    
    NSDictionary *param = @{@"mobile":mobile,@"mocode":self.random_Str};
    [self postWithURLString:@"/user/send_lgxn" parameters:param success:^(id response) {
        NSLog(@"...%@",response);
        if(response)
        {
            [WToast showWithText:response[@"msg"]];
            __block int timeout=30; //倒计时时间
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
            dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
            dispatch_source_set_event_handler(_timer, ^{
                if(timeout<=0){ //倒计时结束，关闭
                    dispatch_source_cancel(_timer);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //设置界面的按钮显示 根据自己需求设置
                        [self.getValidBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
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
        
    }];
    
}

- (IBAction)nextAction:(id)sender {
    [self.view endEditing:1];
    if ([_tfCode.text isEqualToString:@""]) {
        [WToast showWithText:@"请输入验证码"];
//        return;
    }else
    {
        NSDictionary *param = @{@"user_id":[XTool GetDefaultInfo:USER_INFO][USER_ID],@"mobile":mobile,@"step":@"CURRENT_VALIDATE",@"captcha":self.tfCode.text};
        [self postWithURLString:@"/user/mobile_modify" parameters:param success:^(id response) {
            if(response)
            {
                ChangeNewPhoneViewController *vc = [ChangeNewPhoneViewController new ];
                [self pushView:vc];

            }
        } failure:^(NSError *error) {
            
        }];
      }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
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
