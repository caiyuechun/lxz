//
//  UserInfoViewController.h
//  乐享租
//
//  Created by caiyc on 18/3/19.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "BaseViewController.h"

@interface UserInfoViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIScrollView *botom_ScroView;
@property (weak, nonatomic) IBOutlet UILabel *birthday;
- (IBAction)selectBirth:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *nick_Tf;
@property (weak, nonatomic) IBOutlet UIDatePicker *date_Pickeer;
@property (weak, nonatomic) IBOutlet UITextField *address_Tf;
@property (weak, nonatomic) IBOutlet UILabel *userId_Lab;
@property (weak, nonatomic) IBOutlet UILabel *mobile_Lab;
@property (weak, nonatomic) IBOutlet UIImageView *icon_Img;
@property (weak, nonatomic) IBOutlet UILabel *manCheck_Lab;
- (IBAction)selectSex:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *woCheck_Lab;

@end
