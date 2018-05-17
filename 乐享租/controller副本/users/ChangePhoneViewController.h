//
//  ChangePhoneViewController.h
//  chuangyi
//
//  Created by yncc on 17/8/15.
//  Copyright © 2017年 changce. All rights reserved.
//

#import "BaseViewController.h"

@interface ChangePhoneViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UILabel *lbPhone;
@property (weak, nonatomic) IBOutlet UITextField *tfCode;
@property (weak, nonatomic) IBOutlet UIButton *getValidBtn;
@property (weak, nonatomic) IBOutlet UIButton *next_Btn;

@end
