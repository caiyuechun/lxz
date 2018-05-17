//
//  oldListCell.h
//  乐享租
//
//  Created by caiyc on 18/4/26.
//  Copyright © 2018年 changce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHLUILabel.h"
@interface oldListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *moveLine;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet SHLUILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *nickLb;
@property (weak, nonatomic) IBOutlet UIScrollView *imgScroView;
-(void)bindData:(NSDictionary *)dic;
@property(nonatomic,copy)void (^delevier)();
@end
