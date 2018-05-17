//
//  CommetGoodViewController.h
//  chuangyi
//
//  Created by caiyc on 17/8/22.
//  Copyright © 2017年 changce. All rights reserved.
//

#import "BaseViewController.h"

@interface ReturnGoodViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIScrollView *botom_ScroView;
@property (weak, nonatomic) IBOutlet UITextView *reason_Tv;
@property (weak, nonatomic) IBOutlet UILabel *place_Lab;
@property (weak, nonatomic) IBOutlet UITextField *ship_CodeTf;
@property(nonatomic,strong)NSMutableArray *dataSouce;
@property (weak, nonatomic) IBOutlet UITextField *ship_NameTf;
@property(nonatomic,strong)NSDictionary *dataDic;
@property(nonatomic,strong)NSString *order_id;
@property (weak, nonatomic) IBOutlet UIScrollView *image_ScroView;
@property (weak, nonatomic) IBOutlet UIButton *addImg_Btn;
@property (weak, nonatomic) IBOutlet UILabel *good_Price;
@property(nonatomic,strong)NSString *type;//1 为评价 0 为退货
@property (weak, nonatomic) IBOutlet UITextView *note_Tv;
@property (weak, nonatomic) IBOutlet UILabel *good_Date;
@property (weak, nonatomic) IBOutlet UIImageView *good_Img;
@property (weak, nonatomic) IBOutlet UILabel *good_Name;
@property(nonatomic,strong)NSString *order_Sn;
@end
