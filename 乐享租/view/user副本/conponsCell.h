//
//  conponsCell.h
//  chuangyi
//
//  Created by caiyc on 17/9/7.
//  Copyright © 2017年 changce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface conponsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timess;
@property (weak, nonatomic) IBOutlet UIImageView *statusImg;
@property (weak, nonatomic) IBOutlet UIView *rightView;
//@property (weak, nonatomic) IBOutlet UIButton *userBtn;
@property (weak, nonatomic) IBOutlet UILabel *userBtn;
- (IBAction)use:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *condition;
@property (weak, nonatomic) IBOutlet UIImageView *botomImg;
@property (weak, nonatomic) IBOutlet UILabel *value;
@property (weak, nonatomic) IBOutlet UILabel *statime;
@property (weak, nonatomic) IBOutlet UILabel *endtime;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *mutaLb;
-(void)bindData:(NSDictionary *)dic andType:(NSString *)types;
@property (weak, nonatomic) IBOutlet UILabel *sendtime;
@property(nonatomic,copy)void (^use)();
-(void)bindData:(NSDictionary *)dic AndType:(NSString *)types;
@end
