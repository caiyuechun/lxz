//
//  IndexViewController.h
//  乐享租
//
//  Created by caiyc on 18/3/14.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "BaseViewController.h"

@interface IndexViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UILabel *order_NumLab;
- (IBAction)left_Action:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *noti_NumLab;
@property (weak, nonatomic) IBOutlet UILabel *shop_NumLab;
@property (weak, nonatomic) IBOutlet UILabel *icon_Lab2;
@property (weak, nonatomic) IBOutlet UILabel *icon_Lab1;
@property (weak, nonatomic) IBOutlet UIView *cover_View;
@property (weak, nonatomic) IBOutlet UILabel *icon_Lab3;
@property (weak, nonatomic) IBOutlet UILabel *icon_Lab4;
@property (weak, nonatomic) IBOutlet UILabel *icon_Lab6;
@property (weak, nonatomic) IBOutlet UILabel *icon_Lab5;
@property (weak, nonatomic) IBOutlet UILabel *cover_Nick;
@property (weak, nonatomic) IBOutlet UIView *cover_ContentView;
@property (weak, nonatomic) IBOutlet UIImageView *cover_Icon;
@property (weak, nonatomic) IBOutlet UILabel *nick_Lab;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *icon_Img;
@property (weak, nonatomic) IBOutlet UIButton *message_Btn;
@property (weak, nonatomic) IBOutlet UIButton *serach_Btn;
@property (weak, nonatomic) IBOutlet UILabel *notiNum_Lab;
- (IBAction)searchAction:(UIButton *)sender;

@end
