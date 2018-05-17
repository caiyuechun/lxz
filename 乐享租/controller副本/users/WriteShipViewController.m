//
//  WriteShipViewController.m
//  乐享租
//
//  Created by caiyc on 18/3/23.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "WriteShipViewController.h"

@interface WriteShipViewController ()

@end

@implementation WriteShipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
            [self initNaviView:nil hasLeft:1 leftColor:nil title:@"填写快递单号" titleColor:nil right:@"" rightColor:nil rightAction:nil];
    self.next_Btn.layer.masksToBounds = 1;
    self.next_Btn.layer.cornerRadius = 25;
    self.goodNum_Tf.text = [NSString stringWithFormat:@"%@",self.goodDic[@"goods_id"]];
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

- (IBAction)nextAction:(id)sender {
    [self.view endEditing:1];
    if([self.shipcode_Tf.text isEqualToString:@""]||[self.shipName_Tf.text isEqualToString:@""]){
        [WToast showWithText:@"请填写完整的快递信息"];
        return;
    }
   
    if(self.needBack==1){
         NSDictionary *param = @{@"user_id":[XTool GetDefaultInfo:USER_INFO][USER_ID],@"shipping_name":self.shipName_Tf.text,@"shipping_code":self.shipcode_Tf.text};
        self.shipDic(param);
          [self.navigationController popViewControllerAnimated:0];
    }else{
    
        NSDictionary *param = @{@"user_id":[XTool GetDefaultInfo:USER_INFO][USER_ID],@"goods_id":self.goodDic[@"goods_id"],@"shipping_name":self.shipName_Tf.text,@"shipping_code":self.shipcode_Tf.text};

      [self postWithURLString:@"/goods/myold_deliver" parameters:param success:^(id response) {
        if(response){
            [WToast showWithText:@"提交成功"];
            [self.navigationController popViewControllerAnimated:0];
        }
    } failure:^(NSError *error) {
        
    }];
    }
}
@end
