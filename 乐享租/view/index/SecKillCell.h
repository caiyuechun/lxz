//
//  RandomCell.h
//  SHOP
//
//  Created by caiyc on 16/12/9.
//  Copyright © 2016年 changce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecKillCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *secondLabel1;
@property (weak, nonatomic) IBOutlet UILabel *minuteLabel1;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel1;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *minuteLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;
@property (weak, nonatomic) IBOutlet UILabel *hourLabel1;
@property (weak, nonatomic) IBOutlet UILabel *oldPrice1;
@property(nonatomic,copy)void (^collectBlock)(UIButton *);
@property (weak, nonatomic) IBOutlet UILabel *hourLabel;
@property (weak, nonatomic) IBOutlet UILabel *oldPrice2;
@property (weak, nonatomic) IBOutlet UILabel *price1;
@property(nonatomic,copy)void (^clickItemBlock)(UIButton *);
- (IBAction)collect:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *tapBtn1;
@property (weak, nonatomic) IBOutlet UIButton *collectBtn2;
@property (weak, nonatomic) IBOutlet UIButton *tapBtn;
- (IBAction)clickItem:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *botomView1;
@property (weak, nonatomic) IBOutlet UIView *botomView2;
//@property (weak, nonatomic) IBOutlet UILabel *price1;
@property (weak, nonatomic) IBOutlet UILabel *price2;
@property (weak, nonatomic) IBOutlet UIButton *collectBtn1;
@property (weak, nonatomic) IBOutlet UILabel *name1;
@property (weak, nonatomic) IBOutlet UILabel *name2;
@property (weak, nonatomic) IBOutlet UIImageView *img2;
@property (weak, nonatomic) IBOutlet UIImageView *img1;
@property (weak, nonatomic) IBOutlet UILabel *decLb1;
@property (weak, nonatomic) IBOutlet UILabel *descLb2;
-(void)bindData:(NSArray *)arr andIndex:(NSInteger)index;
@end
