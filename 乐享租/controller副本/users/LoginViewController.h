//
//  LoginViewController.h
//  滴滴看房-经纪人
//
//  Created by caiyc on 18/3/6.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "BaseViewController.h"

@interface LoginViewController : BaseViewController
- (IBAction)handelThird:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *handel_View;
@property (weak, nonatomic) IBOutlet UIView *corver_view;
- (IBAction)WxLogin:(UIButton *)sender;
- (IBAction)loginByThird:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *acount_Tf;
@property (weak, nonatomic) IBOutlet UILabel *acount_Lab;
@property (weak, nonatomic) IBOutlet UILabel *pass_Lab;
@property (weak, nonatomic) IBOutlet UITextField *pass_Tf;
- (IBAction)regist_Action:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *qqLogin_Lab;
@property (weak, nonatomic) IBOutlet UILabel *weiboLogin_Lab;
@property (weak, nonatomic) IBOutlet UILabel *weixinLogin_Lab;
- (IBAction)mobileNouser_Action:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *login_btn;
- (IBAction)login_Action:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *getValid_btn;
- (IBAction)getvaldAction:(id)sender;

@end
