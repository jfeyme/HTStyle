//
//  HTScrollView.m
//  HTStyle
//
//  Created by jfey on 16/6/18.
//  Copyright © 2016年 jfey. All rights reserved.
//
//  [==][==][==][==][==][==][==][==][==][==][==][==][==][==][==][==][==][==][==]
//  [==]如果使用中遇到问题或BUG,请联系或将代码发送致 jfey@163.com     QQ:1379276994
//  [==][==][==][==][==][==][==][==][==][==][==][==][==][==][==][==][==][==][==]


#import "HTScrollView.h"
#import "UIView+Using.h"
#import "UIView+HTStyleView.h"

@interface HTScrollView ()
@property(nonatomic,strong) NSMutableArray *views;

@end

@implementation HTScrollView

-(NSMutableArray *)views
{
    if (!_views) {
        _views= [NSMutableArray array];
    }
    return _views;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.style = [[HTStyleClass alloc] initWithView:self];
        self.myStyle = self.style;
        
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        
        self.bounces = YES;
    }
    return self;
}


-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    int count = (int)self.views.count;
    if (count == 0) {
        return;
    }
    
    UIView *lastView = self.views[count-1];
    
    //垂直方向
    if (self.scrollType == HTScrollViewToTypeVertical) {
        
        for (int i=0; i<count; i++) {
            
            UIView *sub = self.views[i];
            sub.width = self.width;
            
            //尝试取上一阶梯层
            if ((i-1)>=0) {
                UIView *up = self.views[i-1];
                sub.y = CGRectGetMaxY(up.frame) + self.style.interval;
            }
        }
        
        CGFloat maxHeight = CGRectGetMaxY(lastView.frame);
        
        CGFloat superCenter = self.superview.frame.size.height - self.contentInset.top - self.contentInset.bottom;
        
        if (_forceBouncesScroll && maxHeight <= superCenter) {
            maxHeight = superCenter + 0.25;
        }
        
        self.contentSize = CGSizeMake(self.width, maxHeight);
    
    //水平方向
    }else{
        
        for (int i=0; i<count; i++) {
            
            UIView *sub = self.views[i];
            sub.height = self.height;
            
            //尝试取上一阶梯层
            if ((i-1)>=0) {
                UIView *up = self.views[i-1];
                sub.x = CGRectGetMaxX(up.frame) + self.style.interval;
            }
        }
        
        CGFloat maxWidth = CGRectGetMaxX(lastView.frame);
        
        if (_forceBouncesScroll && maxWidth <= self.superview.frame.size.width) {
            maxWidth = self.superview.frame.size.width + 0.25;
        }
        
        self.contentSize = CGSizeMake(maxWidth, self.height);
        
    }
    
}

-(void)addSubview:(nonnull UIView *)view
{
    [super addSubview:view];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (view.frame.size.width == 3 && view.frame.size.height == 3 && [view isKindOfClass:[UIImageView class]]) {
            return;
        }
    }else{
        if (view.frame.size.width == 2.5 && view.frame.size.height == 2.5 && [view isKindOfClass:[UIImageView class]]) {
            return;
        }
    }
    
    [self.views addObject:view];
}

@end
