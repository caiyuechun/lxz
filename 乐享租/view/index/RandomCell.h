//
//  RandomCell.h
//  SHOP
//
//  Created by caiyc on 16/12/9.
//  Copyright © 2016年 changce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RandomCell : UITableViewCell
@property(nonatomic,copy)void (^collectBlock)(UIButton *);
@property(nonatomic,copy)void (^clickItemBlock)(UIButton *);
- (IBAction)collect:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *percent2;
@property (weak, nonatomic) IBOutlet UIButton *tapBtn1;
@property (weak, nonatomic) IBOutlet UIButton *collectBtn2;
@property (weak, nonatomic) IBOutlet UILabel *hotLb2;
@property (weak, nonatomic) IBOutlet UILabel *descLb2;
@property (weak, nonatomic) IBOutlet UILabel *hotLb1;
@property (weak, nonatomic) IBOutlet UIButton *tapBtn;
@property (weak, nonatomic) IBOutlet UILabel *percent1;
- (IBAction)clickItem:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *descLb1;
@property (weak, nonatomic) IBOutlet UIView *botomView1;
@property (weak, nonatomic) IBOutlet UIView *botomView2;
@property (weak, nonatomic) IBOutlet UILabel *price1;
@property (weak, nonatomic) IBOutlet UILabel *price2;
@property (weak, nonatomic) IBOutlet UIButton *collectBtn1;
@property (weak, nonatomic) IBOutlet UILabel *name1;
@property (weak, nonatomic) IBOutlet UILabel *name2;
@property (weak, nonatomic) IBOutlet UIImageView *img2;
@property (weak, nonatomic) IBOutlet UIImageView *img1;
-(void)bindData:(NSArray *)arr andIndex:(NSInteger)index;
@end
