//
//  HTTwoView.m
//  CCC
//
//  Created by jfey on 16/6/11.
//  Copyright © 2016年 jfey. All rights reserved.
//

#import "HTTwoView.h"
#import "UIView+HTStyleView.h"

@implementation HTTwoView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        UIView *view1 = [UIView new];
        view1.backgroundColor = [UIColor clearColor];
        [self addSubview:view1];
        UIView *view2 = [UIView new];
        view2.backgroundColor = [UIColor clearColor];
        [self addSubview:view2];
        
        self.topView = view1;
        self.bottomView = view2;
        self.inLength = 0;
    }
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //ContentLayout
    [self setupContentLayout];
}

////ContentLayout
-(void)setupContentLayout
{
    //有效值尺寸
    CGFloat x = MAX(self.style.padding, self.style.paddingLeft) + self.style.borderWidth;
    CGFloat y = MAX(self.style.padding, self.style.paddingTop) + self.style.borderWidth;
    CGFloat width = self.width - x - MAX(self.style.padding, self.style.paddingRight);
    CGFloat height = self.height - y - MAX(self.style.padding, self.style.paddingBottom);
    width -= self.style.borderWidth;
    height -= self.style.borderWidth;
    
    //上下排列布局
    if (self.contentLayout == HTTwoViewContentLayoutTypeTopBottom) {
        self.topView.x = x;
        self.topView.y = y;
        self.topView.width = width;
        self.bottomView.x = x;
        self.bottomView.width = width;
        
        if (self.inLength == 0 || (self.inLength+self.style.interval) > height) {
            //一半分
            self.topView.height = (height - self.style.interval) * 0.5;
            self.bottomView.y = CGRectGetMaxY(self.topView.frame) + self.style.interval;
            self.bottomView.height = (height - self.style.interval) * 0.5;
        }else{
            self.topView.height = self.inLength;
            self.bottomView.y = CGRectGetMaxY(self.topView.frame) + self.style.interval;
            self.bottomView.height = height - self.topView.height - self.style.interval;
        }
        //左右排列布局
    }else if (self.contentLayout == HTTwoViewContentLayoutTypeLeftRight) {
        self.topView.x = x;
        self.topView.y = y;
        self.topView.height = height;
        self.bottomView.y = y;
        self.bottomView.height = height;
        
        if (self.inLength==0 || (self.inLength+self.style.interval) > width) {
            //一半分
            self.topView.width = (width - self.style.interval) * 0.5;
            self.bottomView.x = CGRectGetMaxX(self.topView.frame) + self.style.interval;
            self.bottomView.width = width - self.topView.width - self.style.interval;
            
        }else{
            self.topView.width = self.inLength;
            self.bottomView.x = CGRectGetMaxX(self.topView.frame) + self.style.interval;
            self.bottomView.width = width - self.topView.width - self.style.interval;
        }
    }
}



@end
