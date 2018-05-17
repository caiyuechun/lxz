//
//  MessageTopCell.h
//  乐享租
//
//  Created by caiyc on 18/3/24.
//  Copyright © 2018年 changce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageTopCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *icon_Lab;
@property (weak, nonatomic) IBOutlet UILabel *type_Name;
@property (weak, nonatomic) IBOutlet UILabel *decrition_Lab;
-(void)bindDatas:(NSInteger)types;
@end
