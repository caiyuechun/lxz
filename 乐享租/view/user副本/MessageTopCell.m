//
//  MessageTopCell.m
//  乐享租
//
//  Created by caiyc on 18/3/24.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "MessageTopCell.h"

@implementation MessageTopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Initialization code
}
-(void)bindData:(NSDictionary*)dic{

}
-(void)bindDatas:(NSInteger)types{
    if(types==0){
        [self.icon_Lab LabelWithIconStr:@"\U0000e6a0" inIcon:iconfont andSize:CGSizeMake(50, 50) andColor:RGB(154, 208, 238) andiconSize:40];
        self.type_Name.text = @"系统消息";
        self.decrition_Lab.text = @"查看还款信息";
    }else{
        [self.icon_Lab LabelWithIconStr:@"\U0000e6a0" inIcon:iconfont andSize:CGSizeMake(50, 50) andColor:RGB(172, 217, 150) andiconSize:40];
        self.type_Name.text = @"活动通知";
        self.decrition_Lab.text = @"查看商家最新活动通知";
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
