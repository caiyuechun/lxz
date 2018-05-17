//
//  ConpoussCell.h
//  乐享租
//
//  Created by caiyc on 18/5/15.
//  Copyright © 2018年 changce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConpoussCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *use_Btn;
@property (weak, nonatomic) IBOutlet UILabel *logoY_Lab;
@property (weak, nonatomic) IBOutlet UIView *content_View;
@property (weak, nonatomic) IBOutlet UILabel *price_Lab;
@property (weak, nonatomic) IBOutlet UILabel *condition_Lab;
@property (weak, nonatomic) IBOutlet UILabel *timeout_Lab;
-(void)bindData:(NSDictionary *)dic;
@property(nonatomic,copy)void (^use)();
@end
