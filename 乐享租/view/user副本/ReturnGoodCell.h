//
//  CommentCell.h
//  chuangyi
//
//  Created by caiyc on 17/8/22.
//  Copyright © 2017年 changce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentGoodModel.h"
@interface ReturnGoodCell : UITableViewCell<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *date_Lab;
@property (weak, nonatomic) IBOutlet UITextField *ship_NameTf;
@property (weak, nonatomic) IBOutlet UITextField *ship_CodeTf;
- (IBAction)addPhotos:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *spec;
@property (weak, nonatomic) IBOutlet UIButton *ship_Btn;
- (IBAction)writeShip:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *placeLb;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
- (IBAction)commit:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextView *commentTv;
@property (weak, nonatomic) IBOutlet UIScrollView *imageScro;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *name;
-(void)bindModel:(CommentGoodModel *)model;
@property(nonatomic,copy)void (^addphoto)();
@property(nonatomic,copy)void (^checkImage)(NSInteger);
@property(nonatomic,copy)void (^commit)(CommentGoodModel *);
@property(nonatomic,strong)CommentGoodModel*model;
@property(nonatomic,copy)void (^writeships)();
@end
