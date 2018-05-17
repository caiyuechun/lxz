//
//  UserViewController.m
//  乐享租
//
//  Created by caiyc on 18/3/14.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "UserViewController.h"
#import "OrderListViewController.h"
#import "UserInfoViewController.h"
#import "LoginViewController.h"
#import "AssitViewController.h"
#import "SetViewController.h"
#import "MyDistubeViewController.h"
#import "MybolletViewController.h"
#import "MycollectViewController.h"
#import "ConpousListViewController.h"
#import "PrivaceViewController.h"
#import "MessageViewController.h"
#import "RefundViewController.h"
#import "PersonInfoFViewController.h"
#import "RetZViewController.h"
@interface UserViewController ()

@end

@implementation UserViewController
-(void)viewWillAppear:(BOOL)animated{
    if([XTool GetDefaultInfo:USER_INFO]){
        NSDictionary *user_Dic = [XTool GetDefaultInfo:USER_INFO];;
        [self.icon_Img sd_setImageWithURL:[NSURL URLWithString:user_Dic[@"head_pic"]] placeholderImage:nil];
        self.nick_Lab.text = user_Dic[@"nickname"];
        self.creit_Lab.text = [NSString stringWithFormat:@"信誉额度：%@",user_Dic[@"credit"]];
    }
    else{
        self.icon_Img.image = [UIImage imageNamed:@"logo.png"];
        self.nick_Lab.text = @"";
        self.creit_Lab.text = @"信誉额度：0";
    }

}
- (void)viewDidLoad {
    [super viewDidLoad];
      [self initNaviView:nil hasLeft:0 leftColor:nil title:@"个人中心" titleColor:nil right:@"" rightColor:nil rightAction:nil];
    [self creatView];
    // Do any additional setup after loading the view from its nib.
}
-(void)editinfo{
    if(![XTool GetDefaultInfo:USER_INFO]){
        LoginViewController *vc = [[LoginViewController alloc]init];
        [self pushSecondVC:vc];
    }else{
    UserInfoViewController *vc = [[UserInfoViewController alloc]init];
    [self pushSecondVC:vc];
    }
}
#pragma mark 创建视图
-(void)creatView{
    [self.money_Lab LabelWithIconStr:@"\U0000e640" inIcon:iconfont andSize:CGSizeMake(20, 20) andColor:RGB(124, 209, 225) andiconSize:20];
    [self.message_Lab LabelWithIconStr:@"\U0000e639" inIcon:iconfont andSize:CGSizeMake(20, 20) andColor:BUTTON_COLOR andiconSize:20];
    self.icon_Img.layer.masksToBounds = 1;
    self.icon_Img.layer.cornerRadius = 25;
    self.icon_Img.userInteractionEnabled = 1;
    UITapGestureRecognizer *icon_Tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(editinfo)];
    [self.icon_Img addGestureRecognizer:icon_Tap];
    NSArray *img_Array = @[@"\U0000e87d",@"\U0000e698",@"\U0000e660",@"\U0000e66d"];
    NSArray *title_Array = @[@"所有订单",@"待付款",@"待收货",@"待评价"];
    CGFloat widths = screen_width/4;
    for(int i =0;i<4;i++){
        UIView *item = [[UIView alloc]initWithFrame:CGRectMake(widths*i, 0, widths, 80)];
        
        UILabel *img_Lab = [[UILabel alloc]initWithFrame:CGRectMake((widths-50)/2, 0, 50, 50)];
        
        [img_Lab LabelWithIconStr:img_Array[i] inIcon:iconfont andSize:CGSizeMake(50, 50) andColor:[UIColor blackColor] andiconSize:30];
        img_Lab.textAlignment = NSTextAlignmentCenter;
        UILabel *title_Lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, widths, 30)];
        title_Lab.font = [UIFont systemFontOfSize:15];
        title_Lab.textAlignment = NSTextAlignmentCenter;
        title_Lab.text = title_Array[i];
        [item addSubview:img_Lab];
        [item addSubview:title_Lab];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, widths, 100);
        button.tag = i;
        [button addTarget:self action:@selector(orderAction:) forControlEvents:UIControlEventTouchUpInside];
        [item addSubview:button];

        [self.order_View addSubview:item];
    }
    
    NSArray *img_Array1 = @[@"user_icon1",@"user_icon2",@"user_icon3",@"user_icon4",@"user_icon5",@"user_icon6",@"user_icon7"];
    NSArray *title_Array1 = @[@"特权商城",@"我的发布",@"个人信息",@"优惠券",@"收藏",@"帮助",@"设置"];
    CGFloat widths1 = screen_width/4;
    for(int i =0;i<img_Array1.count;i++){
        UIView *item = [[UIView alloc]initWithFrame:CGRectMake(widths1*(i%4), 75*(i/4), widths1, 75)];
        
//        UILabel *img_Lab = [[UILabel alloc]initWithFrame:CGRectMake((widths-50)/2, 0, 50, 50)];
//        
//        [img_Lab LabelWithIconStr:img_Array[i] inIcon:iconfont andSize:CGSizeMake(50, 50) andColor:[UIColor blackColor] andiconSize:30];
//        img_Lab.textAlignment = NSTextAlignmentCenter;
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 15, widths1, 25)];
        img.contentMode = UIViewContentModeScaleAspectFit;
        NSString *img_Str = img_Array1[i];
        img.image = [UIImage imageNamed:img_Str];
        UILabel *title_Lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 45, widths1, 30)];
        title_Lab.font = [UIFont systemFontOfSize:14];
        title_Lab.textAlignment = NSTextAlignmentCenter;
        title_Lab.text = title_Array1[i];
        [item addSubview:img];
        [item addSubview:title_Lab];
        [self.funView addSubview:item];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, widths1, 75);
        button.tag = i;
        [button addTarget:self action:@selector(funcAction:) forControlEvents:UIControlEventTouchUpInside];
        [item addSubview:button];

    }
    
}
#pragma mark 订单点击事件
-(void)orderAction:(UIButton *)sender{
    NSLog(@"订单事件=%ld",sender.tag);
    if(![XTool GetDefaultInfo:USER_INFO])
    {
        LoginViewController *vc =[[LoginViewController alloc ]init];
        [self pushSecondVC:vc];
        return;
        }
//    self.sattus = @"WAITPAY";
//    break;
//case 2:
//    self.sattus = @"WAITSEND";
//    break;
//case 3:
//    self.sattus = @"WAITRECEIVE";
//    break;
//case 4:
//    self.sattus = @"WAITCCOMMENT";

     OrderListViewController *vc = [[OrderListViewController alloc]init];
    if(sender.tag==0){
       
        vc.sattus = @"";
       
    }else if (sender.tag==1){
        vc.sattus = @"WAITPAY";
    }
    else if (sender.tag==2){
    vc.sattus = @"WAITRECEIVE";
    }
    else{
    vc.sattus = @"WAITCCOMMENT";
    }
     [self pushViewAndAnimate:vc];
}
#pragma mark 功能点击事件
-(void)funcAction:(UIButton *)sender{
  NSLog(@"功能事件=%ld",sender.tag);
    NSInteger idx = sender.tag;
    if(![XTool GetDefaultInfo:USER_INFO]){
        LoginViewController *vc =[[LoginViewController alloc ]init];
        [self pushSecondVC:vc];
        return;
        
    }
    BaseViewController *vc = nil;
    switch (idx) {
        case 0:
        {
            vc = [[PrivaceViewController alloc]init];
        }
            break;
        case 1:{
            vc = [[MyDistubeViewController alloc]init];
        }
            break;
        case 2:{
            vc = [[PersonInfoFViewController alloc]init];
            // vc=[[UserInfoViewController alloc]init];
        }
            break;
        case 3:{
            vc = [[ConpousListViewController alloc]init];
        }
            break;
        case 4:{
            vc = [[MycollectViewController alloc]init];
        }
            break;
        case 5:{
            vc = [[AssitViewController alloc]init];
        }
            break;
        case 6:{
            vc = [[SetViewController alloc]init];
        }
            break;
        default:
            break;
    }
     [self pushViewAndAnimate:vc];
   // [self pushSecondVC:vc];
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
//退货审核
- (IBAction)refundAction:(UIButton *)sender {
    if(![XTool GetDefaultInfo:USER_INFO]){
        LoginViewController *vc = [[LoginViewController alloc]init];
        [self pushSecondVC:vc];
    }
    else{
        RetZViewController *vc = [[RetZViewController alloc]init];
        [self pushView:vc];
//    RefundViewController *vc = [[RefundViewController alloc]init];
//    [self pushSecondVC:vc];
}
}
//我的钱包
- (IBAction)mymoneyAction:(UIButton *)sender {
    if(![XTool GetDefaultInfo:USER_INFO]){
        LoginViewController *vc = [[LoginViewController alloc]init];
        [self pushSecondVC:vc];
    }
    else{

    MybolletViewController *vc = [[MybolletViewController alloc]init];
    [self pushSecondVC:vc];
    }
}
- (IBAction)checkMeaaAction:(id)sender {
    if(![XTool GetDefaultInfo:USER_INFO]){
        LoginViewController *vc = [[LoginViewController alloc]init];
        [self pushSecondVC:vc];
    }
    else{

    MessageViewController *vc = [[MessageViewController alloc]init];
    [self pushSecondVC:vc];
    }
}
@end
