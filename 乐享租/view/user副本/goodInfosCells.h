//
//  goodInfosCells.h
//  乐享租
//
//  Created by caiyc on 18/4/26.
//  Copyright © 2018年 changce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHLUILabel.h"
@interface goodInfosCells : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *checkLb;
@property (weak, nonatomic) IBOutlet SHLUILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *commentNum;
@property (weak, nonatomic) IBOutlet UILabel *oldPrice;
@property (weak, nonatomic) IBOutlet UILabel *active_Lab;
@property (weak, nonatomic) IBOutlet SHLUILabel *remark;
@property (weak, nonatomic) IBOutlet UILabel *price;
- (IBAction)checkAllComment:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *sales;
-(void)bindData:(NSDictionary *)diction;
@property(nonatomic,copy)void (^checkAllcomm)();
@end
