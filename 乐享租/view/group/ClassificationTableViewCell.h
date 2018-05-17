//
//  ClassificationTableViewCell.h
//  chuangyi
//
//  Created by yncc on 17/8/10.
//  Copyright © 2017年 changce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassificationTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
-(void)bindData:(NSDictionary *)dicInfo;
@end
