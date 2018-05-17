//
//  SelectCatViewController.h
//  乐享租
//
//  Created by caiyc on 18/4/24.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "BaseViewController.h"

@interface SelectCatViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *left_Tableview;
@property (weak, nonatomic) IBOutlet UITableView *right_TableView;
@property(nonatomic,copy)void (^selectCat)(NSDictionary *cat_id);
@end
