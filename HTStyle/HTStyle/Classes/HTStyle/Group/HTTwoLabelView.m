//
//  HTTwoLabelView.m
//
//  Created by jfey on 16/6/10.
//  Copyright © 2016年 jfey. All rights reserved.
//

#import "HTTwoLabelView.h"
#import "UIView+HTStyleView.h"

@implementation HTTwoLabelView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.separationWScale = 1;
        
        UILabel *top = [UILabel new];
        [self addSubview:top];
        UILabel *bottom = [UILabel new];
        [self addSubview:bottom];
        
        self.topLabel = top;
        self.bottomLabel = bottom;
    }
    return self;
}


-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    [self setupDrawLine];
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //contentLayout
    [self setupContentLayout];
}

////drawLine
-(void)setupDrawLine
{
    //分隔线处理 (画线)
    if (self.separationHeight > 0) {
        UIBezierPath *path = [UIBezierPath bezierPath];
        path.lineCapStyle = self.separationLineCap;
        path.lineWidth = self.separationHeight;
        [self.separationColor set];
        
        //有效
        CGFloat x, width;
        if (self.isSeparationStylePadding) {
            x = (self.style.paddingLeft>0)?self.style.paddingLeft : self.style.padding;
            width = self.width - x - ((self.style.paddingRight>0)?self.style.paddingRight : self.style.padding);
        }else{
            x = 0;
            width = self.width;
        }
        CGFloat startX = x + (width - width * self.separationWScale) * 0.5;
        CGFloat endX = startX + width * self.separationWScale;
        
        CGFloat y = CGRectGetMaxY( self.topLabel.frame ) + self.style.interval * 0.5;
        
        [path moveToPoint:CGPointMake(startX, y)];
        [path addLineToPoint:CGPointMake(endX, y)];
        [path stroke];
    }
}

////ContentLayout
-(void)setupContentLayout
{
    CGFloat topFH = self.topLabel.font.lineHeight;
    CGFloat boFH = self.bottomLabel.font.lineHeight;
    
    //有效值尺寸
    CGFloat x = MAX(self.style.padding, self.style.paddingLeft) + self.style.borderWidth;
    CGFloat y = MAX(self.style.padding, self.style.paddingTop) + self.style.borderWidth;
    CGFloat width = self.width - x - MAX(self.style.padding, self.style.paddingRight);
    CGFloat height = self.height - y - MAX(self.style.padding, self.style.paddingBottom);
    width -= self.style.borderWidth;
    height -= self.style.borderWidth;
    
    self.topLabel.x = x;
    self.bottomLabel.x = x;
    self.topLabel.width = width;
    self.bottomLabel.width = width;
    self.topLabel.height = topFH;
    self.bottomLabel.height = boFH;
    
    CGFloat uda = (height - topFH - boFH - self.style.interval)*0.5;
    self.topLabel.y = y + uda;
    self.bottomLabel.y = self.topLabel.y + topFH + self.style.interval;
}


@end
