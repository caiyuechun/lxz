//
//  IntergerCell.h
//  SHOP
//
//  Created by caiyc on 17/4/12.
//  Copyright © 2017年 changce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntergerCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *descLb;
@property (weak, nonatomic) IBOutlet UILabel *scro;
@property (weak, nonatomic) IBOutlet UILabel *timeLb;
-(void)bindData:(NSDictionary *)diction;
@end
