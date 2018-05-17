//
//  CollectHeaderView.h
//  SHOP
//
//  Created by caiyc on 16/12/1.
//  Copyright © 2016年 changce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectHeaderView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UIImageView *flashImage;
-(void)bindData:(NSDictionary *)dic;
@end
