//
//  GroupViewController.h
//  SHOP
//
//  Created by caiyc on 16/11/29.
//  Copyright © 2016年 changce. All rights reserved.
//

#import "BaseViewController.h"

@interface GroupViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UICollectionView *CollectView;
@property (weak, nonatomic) IBOutlet UITableView *GroupList;
@property (weak, nonatomic) IBOutlet UIView *seachView;
@property (weak, nonatomic) IBOutlet UIButton *searchbtn;
@property (weak, nonatomic) IBOutlet UIButton *scanBtn;
@property (weak, nonatomic) IBOutlet UITextField *search_Tf;
- (IBAction)DoScan:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *search_View;
@property (weak, nonatomic) IBOutlet UIButton *messageBtn;
- (IBAction)CheckMessage:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *search_Lab;
@property (weak, nonatomic) IBOutlet UILabel *notifacationNum;
@end
