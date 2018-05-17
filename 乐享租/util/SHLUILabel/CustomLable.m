//
//  CustomLable.m
//  乐享租
//
//  Created by caiyc on 18/3/24.
//  Copyright © 2018年 changce. All rights reserved.
//

#import "CustomLable.h"

@implementation CustomLable
- (id)initWithFrame:(CGRect)frame
{
    //初始化字间距、行间距
    if(self =[super initWithFrame:frame])
        
    {
        self.font = [UIFont fontWithName:ICONNAME size:19];
//        self.characterSpacing = 1.5f;
//        self.linesSpacing = 4.0f;
//        self.paragraphSpacing = 10.0f;
    }
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
