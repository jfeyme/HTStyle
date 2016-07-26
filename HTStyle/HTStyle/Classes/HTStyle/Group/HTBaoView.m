//
//  HTBaoView.m
//
//  Created by jfey on 16/6/10.
//  Copyright © 2016年 jfey. All rights reserved.
//

#import "HTBaoView.h"

@implementation HTBaoView

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //只取第一个子对象
    if (self.subviews.count > 0) {
        UIView *sub = self.subviews[0];
        
        sub.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    }
}

@end
