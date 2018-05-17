//
//  AddressCell.h
//  SHOP
//
//  Created by caiyc on 16/12/6.
//  Copyright © 2016年 changce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *deleteImageLb;
@property (weak, nonatomic) IBOutlet UILabel *editImageLb;
@property (weak, nonatomic) IBOutlet UILabel *nameLb;
@property (weak, nonatomic) IBOutlet UILabel *defaultImageLb;
@property (weak, nonatomic) IBOutlet UIButton *defalutBtn;
@property (weak, nonatomic) IBOutlet UILabel *addressLb;
@property (weak, nonatomic) IBOutlet UILabel *telephoneLable;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UILabel *sepaLable;
- (IBAction)defaultBtn:(UIButton *)sender;
- (IBAction)editBtn:(UIButton *)sender;
- (IBAction)deleteBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *rowLineLable;
@property(nonatomic,copy)void (^defaultAction)(UIButton *);
@property(nonatomic,copy)void (^editAction)(UIButton *);
@property(nonatomic,copy)void (^deleteAction)(UIButton *);
-(void)bindData:(NSDictionary *)dic andIndex:(NSInteger)index;
@end
