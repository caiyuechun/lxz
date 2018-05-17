//
//  CollectHeaderView.m
//  SHOP
//
//  Created by caiyc on 16/12/1.
//  Copyright © 2016年 changce. All rights reserved.
//

#import "CollectHeaderView.h"

@implementation CollectHeaderView
-(void)bindData:(NSDictionary *)dic{
    [_titleLb setText:[dic objectForKey:@"name"]];
    [_flashImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_SERVICE,[dic objectForKey:@"image"]]] placeholderImage:[UIImage imageNamed:@"tu_03"]];
}
@end
