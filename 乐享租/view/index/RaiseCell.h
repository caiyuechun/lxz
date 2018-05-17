//
//  RaiseCell.h
//  SHOP
//
//  Created by caiyc on 17/3/13.
//  Copyright © 2017年 changce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RaiseCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIScrollView *scroView;
@property (weak, nonatomic) IBOutlet UIImageView *hideImg;
-(void)bindData:(NSArray*)array;
@property (weak, nonatomic) IBOutlet UIImageView *moveImg;
@property(nonatomic,copy)void (^clickItems)(NSInteger );
@end
