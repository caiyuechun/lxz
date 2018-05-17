//
//  ApplyWithDrawViewController.h
//  乐享租
//
//  Created by caiyc on 18/3/23.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "BaseViewController.h"

@interface ApplyWithDrawViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UILabel *weixinType_Lab;
@property (weak, nonatomic) IBOutlet UILabel *aliType_Lab;
@property (weak, nonatomic) IBOutlet UITextField *name_Tf;
@property (weak, nonatomic) IBOutlet UITextField *idNum_Tf;
@property (weak, nonatomic) IBOutlet UILabel *calader_Lab;
@property (weak, nonatomic) IBOutlet UITextField *cashNum_Tf;
@property (weak, nonatomic) IBOutlet UIScrollView *botom_ScroView;
@property (weak, nonatomic) IBOutlet UIButton *sumit_Btn;
- (IBAction)submitAction:(id)sender;

@end
