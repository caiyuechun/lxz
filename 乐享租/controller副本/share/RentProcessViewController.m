//
//  RentProcessViewController.m
//  乐享租
//
//  Created by caiyc on 18/5/2.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "RentProcessViewController.h"
#import "DistubeGViewController.h"
@interface RentProcessViewController ()
@property(assign)BOOL isread;
@end

@implementation RentProcessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNaviView:nil hasLeft:1 leftColor:nil title:@"出租流程" titleColor:nil right:@"" rightColor:nil rightAction:nil];
    [self.check_Lab LabelWithIconStr:@"\U0000e606" inIcon:iconfont andSize:CGSizeMake(20, 20) andColor:BASE_GRAY_COLOR andiconSize:20];
    self.next_Btn.layer.cornerRadius = 25;
    self.next_Btn.layer.masksToBounds = 1;
    NSDictionary *param = @{@"user_id":[XTool GetDefaultInfo:USER_INFO][USER_ID]};
    [self postWithURLString:@"/user/rent_process" parameters:param success:^(id response) {
        if(response){
           [ self.webVIew loadHTMLString:response[@"result"][@"content"] baseURL:nil];
        }
    } failure:^(NSError *error) {
        
    }];
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

- (IBAction)nextAction:(UIButton *)sender {
    if(!self.isread){
        [WToast showWithText:@"请勾选租赁协议"];
        return;
    }
    DistubeGViewController *vc = [[DistubeGViewController alloc]init];
    [self pushView:vc];
    
}
- (IBAction)checkAction:(UIButton *)sender {
    self.isread = !self.isread;
    [self.check_Lab LabelWithIconStr:@"\U0000e606" inIcon:iconfont andSize:CGSizeMake(20, 20) andColor:self.isread?BUTTON_COLOR:BASE_GRAY_COLOR andiconSize:20];
    

}
@end
