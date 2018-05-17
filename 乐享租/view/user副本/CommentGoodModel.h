//
//  CommentGoodModel.h
//  chuangyi
//
//  Created by caiyc on 17/8/22.
//  Copyright © 2017年 changce. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentGoodModel : NSObject
@property(nonatomic,strong)NSString *image;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *spec;
@property(nonatomic,strong)NSString *comment;
@property(nonatomic,strong)NSMutableArray *imageArr;
@property(nonatomic,strong)NSString *goodId;
@property(nonatomic,strong)NSString *spec_key;
@property(nonatomic,strong)NSString *order_sn;
@property(nonatomic,strong)NSString *reStatus;
@end
