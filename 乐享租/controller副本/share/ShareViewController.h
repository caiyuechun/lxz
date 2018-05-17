//
//  ShareViewController.h
//  乐享租
//
//  Created by caiyc on 18/3/14.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "BaseViewController.h"

@interface ShareViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIView *cover_View;
- (IBAction)distubeAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *clise_Lab;
- (IBAction)rentAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *search_Tf;
@property (weak, nonatomic) IBOutlet UILabel *distube_Lab;
@property (weak, nonatomic) IBOutlet UILabel *search_Lab;
@property (weak, nonatomic) IBOutlet UIView *serach_View;
@property (weak, nonatomic) IBOutlet UITableView *tableVIew;

@end
