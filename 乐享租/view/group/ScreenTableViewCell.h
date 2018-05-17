//
//  ScreenTableViewCell.h
//  chuangyi
//
//  Created by yncc on 17/8/8.
//  Copyright © 2017年 changce. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ScreenTableViewCellDetegate <NSObject>

-(void)selectdButton:(NSInteger)indexpath itemIndex:(NSInteger)itemIndex ;
-(void)reloadData:(BOOL)select index:(NSIndexPath *)indexpath;

@end

@interface ScreenTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UIView *contView;
@property (nonatomic,weak) id<ScreenTableViewCellDetegate>delegate;
@property (weak, nonatomic) IBOutlet UIImageView *rightIcon;



-(void)bindData:(NSDictionary *)dicInfo indexpath:(NSIndexPath *)indexpath;
@end
