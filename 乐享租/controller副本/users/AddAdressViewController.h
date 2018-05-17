//
//  AddAdressViewController.h
//  SHOP
//
//  Created by caiyc on 16/11/30.
//  Copyright © 2016年 changce. All rights reserved.
//

#import "BaseViewController.h"

@interface AddAdressViewController : BaseViewController
@property(nonatomic,strong)NSDictionary *addressDic;
@property(assign)NSInteger editIndex;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UITextField *nameTf;
@property (weak, nonatomic) IBOutlet UITextField *numTf;
- (IBAction)DoConfirm:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *addressLb;
@property (weak, nonatomic) IBOutlet UIButton *ConfirmBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *scroView;
- (IBAction)showPicker:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextView *DetailText;
@property (weak, nonatomic) IBOutlet UILabel *placeLb;
@property(nonatomic,copy)void (^addSucess)(NSDictionary *);
@property(nonatomic,copy)void (^editSucess)(NSDictionary *);

@end
