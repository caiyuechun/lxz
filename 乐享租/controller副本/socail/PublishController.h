//
//  DistubeViewController.h
//  乐享租
//
//  Created by caiyc on 18/3/15.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "BaseViewController.h"


@interface PublishController : BaseViewController
@property (weak, nonatomic) IBOutlet UILabel *cat_name;
- (IBAction)select_Cat:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *content_Tv;
@property (weak, nonatomic) IBOutlet UILabel *right_Lab;
@property (weak, nonatomic) IBOutlet UIScrollView *bottom_ScroView;
@property (weak, nonatomic) IBOutlet UIButton *addImg_Btn;
- (IBAction)addImgAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *image_ScroView;
@property (weak, nonatomic) IBOutlet UIButton *submit_Btn;
- (IBAction)submitAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *title_Tf;

@end
