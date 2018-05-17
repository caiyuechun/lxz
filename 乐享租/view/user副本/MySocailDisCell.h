//
//  MySocailDisCell.h
//  乐享租
//
//  Created by caiyc on 18/5/3.
//  Copyright © 2018年 changce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MySocailDisCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *coment_Lab;
@property (weak, nonatomic) IBOutlet UILabel *title_Lab;
@property (weak, nonatomic) IBOutlet UILabel *time_Lab;
@property (weak, nonatomic) IBOutlet UILabel *check_Lab;
- (IBAction)select:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UILabel *cat_Name;
@property (weak, nonatomic) IBOutlet UIImageView *thumb;
-(void)bindData:(NSDictionary *)dic;
@property(nonatomic,copy)void (^check)();
@end
