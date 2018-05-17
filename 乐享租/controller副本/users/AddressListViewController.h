//
//  AddressListViewController.h
//  SHOP
//
//  Created by caiyc on 16/12/6.
//  Copyright © 2016年 changce. All rights reserved.
//

#import "BaseViewController.h"

@interface AddressListViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *addressList;
@property(assign)BOOL iselect;
@property(nonatomic,copy)void (^select)(NSDictionary *);
@property(assign)BOOL needback;
@end
