//
//  WriteShipViewController.h
//  乐享租
//
//  Created by caiyc on 18/3/23.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "BaseViewController.h"

@interface WriteShipViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITextField *goodNum_Tf;
- (IBAction)nextAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *shipName_Tf;
@property (weak, nonatomic) IBOutlet UIButton *next_Btn;
@property (weak, nonatomic) IBOutlet UITextField *shipcode_Tf;
@property(nonatomic,strong)NSDictionary *goodDic;
@property(assign)BOOL needBack;
@property(nonatomic,copy)void (^shipDic)(NSDictionary *);
@end
