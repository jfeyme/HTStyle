//
//  HTLineLayoutView.m
//
//  Created by jfey on 16/6/10.
//  Copyright © 2016年 jfey. All rights reserved.
//

#import "HTLineLayoutView.h"
#import "UIView+HTStyleView.h"

@implementation HTLineLayoutView


-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    //drawLine
    [self setupDrawLine];
}


-(void)layoutSubviews
{
    [super layoutSubviews];

    //ContetnLayout
    [self setContentLayout];
}

////drawLine
-(void)setupDrawLine
{
    if (self.separationHeight > 0) {
        //需要分隔线
        //这里是按子内容与子内容两两之间画
        NSMutableArray *arrayPX = [NSMutableArray array];
        for (int i=0; i<(self.subviews.count-1); i++) {
            UIView *one = self.subviews[i];
            UIView *two = self.subviews[i+1];
            CGFloat x = (two.x - CGRectGetMaxX(one.frame))*0.5;
            x = CGRectGetMaxX(one.frame) + x;
            [arrayPX addObject:@(x)];
        }
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        path.lineCapStyle = self.separationLineCap;
        path.lineWidth = self.separationHeight;
        [self.separationColor set];
        //有效高
        CGFloat x, y, width, height;
        if (self.isSeparationStylePadding) {
            x = (self.style.paddingLeft>0)?self.style.paddingLeft : self.style.padding;
            y = (self.style.paddingTop>0)?self.style.paddingTop : self.style.padding;
            width = self.width - x - ((self.style.paddingRight>0)?self.style.paddingRight : self.style.padding);
            height = self.height - y - ((self.style.paddingBottom>0)?self.style.paddingBottom : self.style.padding);
        }else{
            x = 0;
            y = 0;
            width = self.width;
            height = self.height;
        }
        CGFloat startY = y + (height - height * self.separationWScale) * 0.5;
        CGFloat endY = startY + height * self.separationWScale;
        
        //开始按点位置画线
        for (int i=0; i<arrayPX.count; i++) {
            CGFloat x = [arrayPX[i] floatValue];
            [path moveToPoint:CGPointMake(x , startY)];
            [path addLineToPoint:CGPointMake(x, endY)];
            [path stroke];
        }
    }
}

////ContetnLayout
-(void)setContentLayout
{
    //有效值尺寸
    CGFloat x = MAX(self.style.padding, self.style.paddingLeft) + self.style.borderWidth;
    CGFloat y = MAX(self.style.padding, self.style.paddingTop) + self.style.borderWidth;
    CGFloat width = self.width - x - MAX(self.style.padding, self.style.paddingRight);
    CGFloat height = self.height - y - MAX(self.style.padding, self.style.paddingBottom);
    width -= self.style.borderWidth;
    height -= self.style.borderWidth;
    
    //计算所有子对象总宽
    int count = (int)self.subviews.count;
    CGFloat subTotalWidth = 0;
    for (int i=0; i<count; i++) {
        UIView *sub = (UIView*)self.subviews[i];
        subTotalWidth += sub.width;
    }
    //居中对齐
    if (self.contentAlign == HTLineLayoutContentAlignTypeCenter) {
        //平均左右两边大小
        CGFloat left = x + (width - subTotalWidth - self.style.interval * (count-1)) * 0.5;
        CGFloat curr_x = left;
        for (int i=0; i<count; i++) {
            UIView *sub = (UIView*)self.subviews[i];
            sub.x = curr_x;
            if (sub.height == 0) {
                sub.height = height;
            }
            sub.y = y + (height - sub.height)*0.5;
            curr_x += sub.width + self.style.interval;
        }
        //左对齐
    }else if (self.contentAlign == HTLineLayoutContentAlignTypeLeft){
        CGFloat curr_x = x;
        for (int i=0; i<count; i++) {
            UIView *sub = (UIView*)self.subviews[i];
            sub.x = curr_x;
            if (sub.height == 0) {
                sub.height = height;
            }
            sub.y = y + (height - sub.height)*0.5;
            curr_x += sub.width + self.style.interval;
        }
        //右对齐
    }else if (self.contentAlign == HTLineLayoutContentAlignTypeRight){
        CGFloat curr_x = x + width;
        for (int i=count-1; i>=0; i--) {
            UIView *sub = (UIView*)self.subviews[i];
            sub.x = curr_x - sub.width;
            if (sub.height == 0) {
                sub.height = height;
            }
            sub.y = y + (height - sub.height)*0.5;
            curr_x -= sub.width + self.style.interval;
        }
        //分散对齐,平均对齐
    }else if (self.contentAlign == HTLineLayoutContentAlignTypeScatter){
        //平均所有间隔
        CGFloat qux = (width - subTotalWidth) / (count+1);
        CGFloat curr_x = x + qux;
        for (int i=0; i<count; i++) {
            UIView *sub = (UIView*)self.subviews[i];
            sub.x = curr_x;
            if (sub.height == 0) {
                sub.height = height;
            }
            sub.y = y + (height - sub.height)*0.5;
            curr_x += sub.width + qux;
        }
    }
}

@end
