//
//  MybolletViewController.m
//  乐享租
//
//  Created by caiyc on 18/3/23.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "MybolletViewController.h"
#import "ApplyWithDrawViewController.h"
#import "BalanceDetailViewController.h"
@interface MybolletViewController ()

@end

@implementation MybolletViewController
-(void)viewWillAppear:(BOOL)animated{
    [self loadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
         [self initNaviView:nil hasLeft:1 leftColor:nil title:@"我的钱包" titleColor:nil right:@"" rightColor:nil rightAction:nil];

    self.credit_View.backgroundColor = RGBA(247, 125, 125, .7);
    [self.credit_Lab LabelWithIconStr:@"\U0000e690" inIcon:iconfont andSize:CGSizeMake(20, 20) andColor:[UIColor whiteColor] andiconSize:20];
    self.credit_View.layer.cornerRadius = 15;
    self.credit_View.layer.masksToBounds = 1;
    self.withDraw_Btn.layer.cornerRadius = 17;
    self.withDraw_Btn.backgroundColor = RGBA(200, 200, 200, .7);
    self.withDraw_Btn.layer.masksToBounds = 1;
    [self.balance_Btn LabelWithIconStr:@"\U0000e691" inIcon:iconfont andSize:CGSizeMake(35, 35) andColor:BUTTON_COLOR andiconSize:30];
    NSDictionary *user_Dic = [XTool GetDefaultInfo:USER_INFO];
    self.icon_Img.layer.masksToBounds = 1;
    self.icon_Img.layer.cornerRadius = 35;
    [self.icon_Img sd_setImageWithURL:[NSURL URLWithString:user_Dic[@"head_pic"]] placeholderImage:nil];
    self.nick_Lab.text = user_Dic[@"nickname"];
    self.creit_Lab.text = [NSString stringWithFormat:@"信誉额度：%@",user_Dic[@"credit"]];
    // Do any additional setup after loading the view from its nib.
}
-(void)loadData{
    NSDictionary *parm = @{@"user_id":[XTool GetDefaultInfo:USER_INFO][USER_ID]};
    [self postWithURLString:@"/user/wallet" parameters:parm success:^(id response) {
        if(response){
            self.success_Lab.text = [NSString stringWithFormat:@"%@",response[@"result"][@"success_money"]];
            self.keti_Lab.text = [NSString stringWithFormat:@"%@",response[@"result"][@"user_money"]];
             self.creit_Lab.text = [NSString stringWithFormat:@"信誉额度：%@",response[@"result"][@"credit"]];
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
//申请提现
- (IBAction)applyAction:(UIButton *)sender {
    ApplyWithDrawViewController *vc = [[ApplyWithDrawViewController alloc]init];
    [self pushView:vc];
}
//查看明细
- (IBAction)checkDetail:(UIButton *)sender {
    BalanceDetailViewController *vc = [[BalanceDetailViewController alloc]init];
    [self pushView:vc];
    
}
@end
