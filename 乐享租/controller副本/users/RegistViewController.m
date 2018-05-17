//
//  RegistViewController.m
//  滴滴看房-经纪人
//
//  Created by caiyc on 18/3/6.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "RegistViewController.h"
#import "RegistSViewController.h"
@interface RegistViewController ()
@property(assign)BOOL agreen;

@end

@implementation RegistViewController

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
    RegistSViewController *vc = [[RegistSViewController alloc]init];
    vc.moblie = self.mobile_Tf.text;
    vc.valid = self.valid_Tf.text;
    if(self.thirdDic){
        vc.thirdDic = self.thirdDic;
    }
    [self pushView:vc];

    

}
//获取验证码
- (IBAction)getValid_Action:(id)sender {
    [self.view endEditing:1];
    if([self.mobile_Tf.text isEqualToString:@""]){
        [WToast showWithText:@"请填写手机号"];
        return;
    }
    NSString *secct = [NSString stringWithFormat:@"mobile=%@&secret=8GwuOGonmSbY4xHp",self.mobile_Tf.text];
    NSString *keys = [XTool md5:secct];
    NSDictionary *dic = @{@"key":keys,@"mobile":self.mobile_Tf.text,@"action":@"1"};
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
                        [self.getValid_btn setTitle:@"发送验证码" forState:UIControlStateNormal];
                        self.getValid_btn.userInteractionEnabled = YES;
                    });
                }else{
                    int seconds = timeout % 60;
                    NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //设置界面的按钮显示 根据自己需求设置
                        //NSLog(@"____%@",strTime);
                        //[UIView beginAnimations:nil context:nil];
                        //[UIView setAnimationDuration:1];
                        [self.getValid_btn setTitle:[NSString stringWithFormat:@"%@s",strTime] forState:UIControlStateNormal];
                        // [UIView commitAnimations];
                        self.getValid_btn.userInteractionEnabled = NO;
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
//点击条例
- (IBAction)checkRuleAction:(UIButton *)sender {
    self.agreen = !self.agreen;
    if(self.agreen){
    [self.check_Lab LabelWithIconStr:@"\U0000e60f" inIcon:iconfont andSize:CGSizeMake(20, 20) andColor:BUTTON_COLOR andiconSize:20];
    }else{
     [self.check_Lab LabelWithIconStr:@"\U0000e60f" inIcon:iconfont andSize:CGSizeMake(20, 20) andColor:BASE_GRAY_COLOR andiconSize:20];
    }

}
@end
