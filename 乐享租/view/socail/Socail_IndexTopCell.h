//
//  Socail_IndexTopCell.h
//  乐享租
//
//  Created by caiyc on 18/3/14.
//  Copyright © 2018年 changce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Socail_IndexTopCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *notice_Lab;
@property (weak, nonatomic) IBOutlet UILabel *notice_title;
@property(copy,nonatomic)void (^clickCatogry)(NSInteger index);
-(void)bindData:(NSDictionary *)dic;
@end
