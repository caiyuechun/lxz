//
//  specView.h
//  testAutoLabel
//
//  Created by caiyc on 17/6/6.
//  Copyright © 2017年 changce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AutoButton.h"
@interface specViews : UIView
-(id)initWithDataSource:(NSDictionary *)gooddetail;
@property(nonatomic,copy)void (^selctSpec)(NSString *);
@property(nonatomic,copy)void (^sure)(NSString * num,NSString *specStr,BOOL buynow);
@property(nonatomic,copy)void (^closeViews)(void);
@property(nonatomic,copy)void (^selectDate)(NSString *date_value);

@end
