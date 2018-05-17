//
//  ShopCarCell.h
//  乐享租
//
//  Created by caiyc on 18/3/14.
//  Copyright © 2018年 changce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopCarCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *check_Lab;
- (IBAction)add:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *num_Tf;
- (IBAction)jian:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *paytype;
@property (weak, nonatomic) IBOutlet UILabel *buytype;
@property (weak, nonatomic) IBOutlet UIImageView *thumb;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property(nonatomic,copy)void (^select)(void);
- (IBAction)selectAction:(UIButton *)sender;
-(void)bindData:(NSDictionary *)dic;
@property(nonatomic,copy)void (^numCut)(NSInteger);
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
- (IBAction)DoDelete:(UIButton *)sender;
@property(nonatomic,copy)void (^numAdd)(NSInteger);
@end
