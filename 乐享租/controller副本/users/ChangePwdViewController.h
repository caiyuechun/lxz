//
//  ChangePwdViewController.h
//  chuangyi
//
//  Created by yncc on 17/8/15.
//  Copyright © 2017年 changce. All rights reserved.
//

#import "BaseViewController.h"

@interface ChangePwdViewController : BaseViewController
- (IBAction)getValid:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *mobileTf;
@property (weak, nonatomic) IBOutlet UILabel *lbPhone;
@property (weak, nonatomic) IBOutlet UITextField *tfCode;
@property (weak, nonatomic) IBOutlet UITextField *tfPwd;
@property (weak, nonatomic) IBOutlet UITextField *tfAgainPwd;
@property (weak, nonatomic) IBOutlet UIButton *getValidBtn;
@property (weak, nonatomic) IBOutlet UIButton *chang_Btn;

@end
