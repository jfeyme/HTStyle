//
//  UIView+Using.m
//
//  Created by jfey on 16/6/15.
//  Copyright © 2016年 jfey. All rights reserved.
//
//  [==][==][==][==][==][==][==][==][==][==][==][==][==][==][==][==][==][==][==]
//  [==]如果使用中遇到问题或BUG,请联系或将代码发送致 jfey@163.com     QQ:1379276994
//  [==][==][==][==][==][==][==][==][==][==][==][==][==][==][==][==][==][==][==]


#import "UIView+Using.h"
#import <objc/runtime.h>
#import "HTStyleClass.h"
#import "RZDataBinding.h"
#import "UIView+HTStyleView.h"

@interface UIView ()
@property(nonatomic,strong) UIBezierPath *borderPath;

@end


@implementation UIView (Using)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *selStringsArray = @[@"layoutSubviews", @"drawRect:"];
        
        [selStringsArray enumerateObjectsUsingBlock:^(NSString *selString, NSUInteger idx, BOOL *stop) {
            NSString *mySelString = [@"jf_" stringByAppendingString:selString];
            
            Method originalMethod = class_getInstanceMethod(self, NSSelectorFromString(selString));
            Method myMethod = class_getInstanceMethod(self, NSSelectorFromString(mySelString));
            method_exchangeImplementations(originalMethod, myMethod);
        }];
    });
}

-(void)jf_drawRect:(CGRect)rect
{
    [self jf_drawRect:rect];
    
    if (self.myStyle) {
        typeof(self) __weak weakSelf = self;
        
        HTStyleClass *s = self.myStyle;
            
        if (self.borderPath != nil) {
            [s.borderColor set];
            self.borderPath.lineWidth = s.borderWidth * 2;
            [self.borderPath stroke];
        }
        [s _setDrawRectFinishBlock:weakSelf drawRect:rect];
    }
}

- (void)jf_reload
{
    [self setNeedsLayout];
    [self setNeedsDisplay];
}

- (void)jf_layoutSubviews
{
    [self jf_layoutSubviews];
    
    [self jf_layoutSubviewsHandle];
}

- (void)jf_layoutSubviewsHandle
{
    if (self.myStyle) {
        typeof(self) __weak weakSelf = self;
        
        if (self.isOnlyonceTrue) {
            //AddFrame
            [weakSelf.superview rz_addTarget:weakSelf action:@selector(jf_reload) forKeyPathChange:@"frame"];
            
//            [weakSelf.superview observeProperty:@"frame" withBlock:^(id self, id oldValue, id newValue) {
//                [weakSelf jf_reload];
//            }];
            
        }
        
        HTStyleClass *s = self.myStyle;
        
        //position
        [s _stylePositionWhitView:weakSelf];
        
        //draw
        self.borderPath = [s _styleRepeatEdgeWithView:weakSelf];
        
        //user block
        [s _setLayoutSubviewFinishBlock:weakSelf];
    }
}


#pragma mark - 属性SET -

-(void)setMyStyle:(HTStyleClass *)myStyle
{
    objc_setAssociatedObject(self, @selector(myStyle), myStyle, OBJC_ASSOCIATION_ASSIGN);
}

-(HTStyleClass *)myStyle
{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setBorderPath:(UIBezierPath *)borderPath
{
    objc_setAssociatedObject(self, @selector(borderPath), borderPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIBezierPath *)borderPath
{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setPortraitWidth:(CGFloat)portraitWidth
{
    objc_setAssociatedObject(self, @selector(portraitWidth), @(portraitWidth), OBJC_ASSOCIATION_RETAIN);
}

-(CGFloat)portraitWidth
{
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

-(void)setPortraitHeight:(CGFloat)portraitHeight
{
    objc_setAssociatedObject(self, @selector(portraitHeight), @(portraitHeight), OBJC_ASSOCIATION_RETAIN);
}

-(CGFloat)portraitHeight
{
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

-(void)setIsLandscapeState:(BOOL)isLandscapeState
{
    objc_setAssociatedObject(self, @selector(isLandscapeState), @(isLandscapeState), OBJC_ASSOCIATION_RETAIN);
}

-(BOOL)isLandscapeState
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

-(void)setSize_orig:(CGSize)size_orig
{
    objc_setAssociatedObject(self, @selector(size_orig), [NSValue valueWithCGSize:size_orig], OBJC_ASSOCIATION_RETAIN);
}

-(CGSize)size_orig
{
    return [objc_getAssociatedObject(self, _cmd) CGSizeValue];
}

@end



@implementation UIButton (Using)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *selStringsArray = @[@"layoutSubviews"];
        
        [selStringsArray enumerateObjectsUsingBlock:^(NSString *selString, NSUInteger idx, BOOL *stop) {
            NSString *mySelString = [@"jf_button_" stringByAppendingString:selString];
            
            Method originalMethod = class_getInstanceMethod(self, NSSelectorFromString(selString));
            Method myMethod = class_getInstanceMethod(self, NSSelectorFromString(mySelString));
            method_exchangeImplementations(originalMethod, myMethod);
            
        }];
    });
}

- (void)jf_button_layoutSubviews
{
    [self jf_button_layoutSubviews];
    
    [self jf_layoutSubviewsHandle];
}

@end

