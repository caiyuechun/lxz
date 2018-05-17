//
//  OrderInfoCell.h
//  chuangyi
//
//  Created by caiyc on 17/8/10.
//  Copyright © 2017年 changce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZOrderInfoCell : UITableViewCell
- (IBAction)pickself:(UIButton *)sender;
- (IBAction)send:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *pickselfLb;
@property (weak, nonatomic) IBOutlet UITextField *scroTf;
@property (weak, nonatomic) IBOutlet UILabel *sendLb;
@property (weak, nonatomic) IBOutlet UITextField *noteTf;
@property (weak, nonatomic) IBOutlet UILabel *usermoneyLb;
@property (weak, nonatomic) IBOutlet UILabel *disUserMoney;
@property (weak, nonatomic) IBOutlet UIButton *selectUsermoeny;
- (IBAction)selectUserMoney:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *shipFee;
@property (weak, nonatomic) IBOutlet UIButton *pickSelctBtn;
- (IBAction)selectPick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *shipName;
@property(nonatomic,copy)void (^slectShip)();
@property(nonatomic,copy)void (^slectyouhui)();
@property(nonatomic,copy)void (^slectPick)();
@property(nonatomic,copy)void (^checkboxSelct)();
- (IBAction)SelctShip:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *interprice;
@property (weak, nonatomic) IBOutlet UIButton *youhuiquanNum;
@property (weak, nonatomic) IBOutlet UILabel *youhuiquanLb;
- (IBAction)selctYouhui:(UIButton *)sender;
- (IBAction)slectShip:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *youhuiPrice;
@property (weak, nonatomic) IBOutlet UIButton *shipSelectBtn;
@property(nonatomic,copy)void (^sleectUserMoney)();

@end
