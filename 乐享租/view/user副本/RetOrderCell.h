//
//  OrderCell.h
//  chuangyi
//
//  Created by caiyc on 17/8/10.
//  Copyright © 2017年 changce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RetOrderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UILabel *num;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIView *move_View;
@property (weak, nonatomic) IBOutlet UIButton *handelright;
@property (weak, nonatomic) IBOutlet UIButton *handleleft;
//- (IBAction)rightAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *image;
//- (IBAction)leftAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *orderSn;
@property (weak, nonatomic) IBOutlet UILabel *orderStatus;
-(void)bindDatas:(NSDictionary *)diction;
@property(nonatomic,copy)void (^handel)(UIButton *);

@end
