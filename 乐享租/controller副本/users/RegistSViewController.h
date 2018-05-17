//
//  RegistViewController.h
//  滴滴看房-经纪人
//
//  Created by caiyc on 18/3/6.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "BaseViewController.h"

@interface RegistSViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UILabel *check_Lab;
@property (weak, nonatomic) IBOutlet UIButton *regist_btn;
- (IBAction)regist_Action:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *getValid_btn;
- (IBAction)getValid_Action:(id)sender;
- (IBAction)checkRuleAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *mobile_Tf;
@property (weak, nonatomic) IBOutlet UITextField *valid_Tf;
@property(nonatomic,strong)NSString *valid;
@property(nonatomic,strong)NSString *moblie;
@property(nonatomic,strong)NSDictionary *thirdDic;
@end
