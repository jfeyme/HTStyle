//
//  HTTextField.m
//
//  Created by jfey on 16/6/10.
//  Copyright © 2016年 jfey. All rights reserved.
//

#import "HTTextField.h"
#import "UIView+Using.h"
#import "UIView+HTStyleView.h"

//n
@interface UITextFieldLeftView : UIView

@end

@implementation UITextFieldLeftView

@end


@interface HTTextField ()

@end

@implementation HTTextField

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.style = [[HTStyleClass alloc] initWithView:self];
        self.myStyle = self.style;
        
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
    
    //判断是否有左边距,如果有,就添加一个View宽度
    if (self.style.borderWidth > 0 || self.style.padding > 0 || self.style.paddingLeft > 0) {
        
        if (self.leftView == nil) {
            CGFloat viewWidth = MAX(self.style.padding, self.style.paddingLeft) + self.style.borderWidth;
            viewWidth += self.style.interval;
            
            UITextFieldLeftView *newView = [UITextFieldLeftView new];
            newView.width = viewWidth;
            newView.height = self.height;
            self.leftView = newView;
            self.leftViewMode = UITextFieldViewModeAlways;
        }
    }
    
    //定位
    if (self.leftView != nil) {
        //有效值尺寸
        CGFloat x = MAX(self.style.padding, self.style.paddingLeft) + self.style.borderWidth;
        CGFloat y = MAX(self.style.padding, self.style.paddingTop) + self.style.borderWidth;
        CGFloat width = self.width - x - MAX(self.style.padding, self.style.paddingRight);
        CGFloat height = self.height - y - MAX(self.style.padding, self.style.paddingBottom);
        width -= self.style.borderWidth;
        height -= self.style.borderWidth;
        
        //判断类型
        if (![self.leftView isKindOfClass:[UITextFieldLeftView class]]) {
            
            //修改过了
            UIView *getView = self.leftView;
            
            UITextFieldLeftView *newView = [UITextFieldLeftView new];
            self.leftView = newView;
            self.leftViewMode = UITextFieldViewModeAlways;
            
            [newView addSubview:getView];
        }
        
        self.leftView.x = 0;
        self.leftView.y = 0;
        self.leftView.height = self.height;
        
        CGFloat leftWidth = x;
        if (self.leftView.subviews.count > 0) {
            
            UIView *subView = self.leftView.subviews[0];
            leftWidth += subView.width;
            
            //定位子内容
            subView.x = x;
            subView.y = y + (height - subView.height) * 0.5;
        }
        
        self.leftView.width = leftWidth + self.style.interval + 2;
        
    }
}


-(void)setPlaceholder:(NSString *)placeholder
{
    [super setPlaceholder:placeholder];
    //注册监听 文字内容改变时
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange) name:UITextFieldTextDidChangeNotification object:self];
}

-(void)setText:(NSString *)text
{
    // 代码方式设置文本时
    [super setText:text];
    [self setNeedsDisplay];
}

-(void)setLeftView:(UIView *)leftView
{
    [super setLeftView:leftView];
    [self setNeedsDisplay];
}

#pragma mark - 文本框内容改变时的通知

-(void)textFieldDidChange
{
    [self setNeedsDisplay];
}

@end

