//
//  SearchViewController.h
//  乐享租
//
//  Created by caiyc on 18/4/18.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "BaseViewController.h"

@interface SearchViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIView *search_View;
- (IBAction)delete:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *recomend_View;
@property (weak, nonatomic) IBOutlet UIButton *cancel_Btn;
@property (weak, nonatomic) IBOutlet UILabel *search_Lab;
@property (weak, nonatomic) IBOutlet UITextField *search_Tf;
@property (weak, nonatomic) IBOutlet UIView *histiory_View;
- (IBAction)cancelAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *corver_View;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
