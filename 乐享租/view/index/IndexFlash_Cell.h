//
//  IndexFlash_Cell.h
//  乐享租
//
//  Created by caiyc on 18/3/15.
//  Copyright © 2018年 changce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCCycleScrollView.h"
@interface IndexFlash_Cell : UITableViewCell<DCCycleScrollViewDelegate>
@property(copy,nonatomic)void (^clickCatogry)(NSInteger index,NSInteger types);

-(void)bindData:(NSDictionary *)dic;
@end
