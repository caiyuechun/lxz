//
//  AddressDef.h
//  chuangyi
//
//  Created by caiyc on 17/8/9.
//  Copyright © 2017年 changce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressDef : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *defLb;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UILabel *noAdd;
-(void)bindData:(NSDictionary *)dic;
@property(nonatomic,copy)void (^clicks)(void);
@end
