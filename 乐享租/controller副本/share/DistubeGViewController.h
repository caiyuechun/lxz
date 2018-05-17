//
//  DistubeViewController.h
//  乐享租
//
//  Created by caiyc on 18/3/15.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "BaseViewController.h"

@interface DistubeGViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UILabel *cheek_Lab;
- (IBAction)selectCheck:(UIButton *)sender;
- (IBAction)select_Cat:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *check_Btn;
@property (weak, nonatomic) IBOutlet UIScrollView *bottom_ScroView;
@property (weak, nonatomic) IBOutlet UIButton *addImg_Btn;
@property (weak, nonatomic) IBOutlet UIView *date_View;
- (IBAction)addImgAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *image_ScroView;
@property (weak, nonatomic) IBOutlet UIButton *submit_Btn;
- (IBAction)submitAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *num_Lab;
@property (weak, nonatomic) IBOutlet UITextField *title_Tf;
@property (weak, nonatomic) IBOutlet UILabel *right_Lab;
@property (weak, nonatomic) IBOutlet UILabel *cat_Name;
@property (weak, nonatomic) IBOutlet UITextField *price_Tf;
@property (weak, nonatomic) IBOutlet UITextView *content_Tv;
@property (weak, nonatomic) IBOutlet UILabel *yes_Lab;
- (IBAction)selectYes_Action:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *no_Lab;
@property(nonatomic,strong)NSDictionary *goodDic;
@property(nonatomic,strong)NSString *goodId;

@end
