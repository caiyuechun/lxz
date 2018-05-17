//
//  ChangeNewPhoneViewController.h
//  chuangyi
//
//  Created by yncc on 17/8/15.
//  Copyright © 2017年 changce. All rights reserved.
//

#import "BaseViewController.h"

@interface ChangeNewPhoneViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITextField *tfPhone;
@property (weak, nonatomic) IBOutlet UITextField *tfCode;
- (IBAction)getvalid:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *getValidBtn;
@property (weak, nonatomic) IBOutlet UIButton *bind_Btn;

@end
