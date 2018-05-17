//
//  SocailCatogyViewController.h
//  乐享租
//
//  Created by caiyc on 18/4/23.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "BaseViewController.h"

@interface SocailCatogyViewController : BaseViewController
@property(nonatomic,copy)void (^selectCat)(NSString *ids,NSString *name);
@end
