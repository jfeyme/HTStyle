//
//  HTView.m
//  JfeyHTStyle
//
//  Created by jfey on 16/6/15.
//  Copyright © 2016年 jfey. All rights reserved.
//
//  [==][==][==][==][==][==][==][==][==][==][==][==][==][==][==][==][==][==][==]
//  [==]如果使用中遇到问题或BUG,请联系或将代码发送致 jfey@163.com     QQ:1379276994
//  [==][==][==][==][==][==][==][==][==][==][==][==][==][==][==][==][==][==][==]


#import "HTView.h"
#import "UIView+Using.h"

@implementation HTView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.style = [[HTStyleClass alloc] initWithView:self];
        self.myStyle = self.style;
    }
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
}

/** 添加一个单击事件 */
-(void)addClickWithTarget:(id)target action:(SEL)sel
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:sel];
    [self addGestureRecognizer:tap];
}

@end
