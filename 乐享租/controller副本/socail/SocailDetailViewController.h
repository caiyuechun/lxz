//
//  SocailDetailViewController.h
//  乐享租
//
//  Created by caiyc on 18/3/14.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "BaseViewController.h"

@interface SocailDetailViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UILabel *num_Lab;
@property (weak, nonatomic) IBOutlet UITextView *coment_Tv;
@property (weak, nonatomic) IBOutlet UIView *coment_View;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *corver_View;
@property (weak, nonatomic) IBOutlet UIButton *dianzan_Btn;
@property(nonatomic,strong)NSString *article_id;
@property (weak, nonatomic) IBOutlet UITextField *coment_Tf;

@end
