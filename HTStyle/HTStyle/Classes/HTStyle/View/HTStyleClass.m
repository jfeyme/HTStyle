//
//  HTStyleClass.m
//  HTStyle
//
//  Created by jfey on 16/6/17.
//  Copyright © 2016年 jfey. All rights reserved.
//
//  [==][==][==][==][==][==][==][==][==][==][==][==][==][==][==][==][==][==][==]
//  [==]如果使用中遇到问题或BUG,请联系或将代码发送致 jfey@163.com     QQ:1379276994
//  [==][==][==][==][==][==][==][==][==][==][==][==][==][==][==][==][==][==][==]


#import "HTStyleClass.h"
#import "UIView+HTStyleView.h"

@interface HTStyleClass ()
{
    BOOL _isTop;
    BOOL _isLeft;
    BOOL _isRight;
    BOOL _isBottom;
    
    BOOL _isTopPCT;
    BOOL _isLeftPCT;
    BOOL _isRightPCT;
    BOOL _isBottomPCT;
    
    BOOL _isWidthPCT;
    BOOL _isHeightPCT;
    
    BOOL _isCenterX;
    BOOL _isCenterY;
    
}
@property (nonatomic,copy) setLayoutSubviewBlock finishBlock;
@property (nonatomic,copy) setDrawRectBlock      finishDrawRectBlock;

/** 指向当前View的对象 */
@property(nonatomic,weak) UIView *selfView;
@end

@implementation HTStyleClass

/** 初始化 */
-(instancetype)initWithView:(UIView *)view
{
    if (self = [[HTStyleClass alloc] init]) {
        _selfView = view;
    }
    return self;
}

-(void)setTop:(CGFloat)top {
    _top = top;
    _isTop = YES;
    //防对象没有宽高
    if (_isBottom) {
        _selfView.height = 0.5;
    }
}

-(void)setLeft:(CGFloat)left {
    _left = left;
    _isLeft = YES;
    //防对象没有宽高
    if (_isRight) {
        _selfView.width = 0.5;
    }
}

-(void)setRight:(CGFloat)right {
    _right = right;
    _isRight = YES;
    //防对象没有宽高
    if (_isLeft) {
        _selfView.width = 0.5;
    }
}

-(void)setBottom:(CGFloat)bottom {
    _bottom = bottom;
    _isBottom = YES;
    //防对象没有宽高
    if (_isTop) {
        _selfView.height = 0.5;
    }
}

-(void)setTopPCT:(CGFloat)topPCT {
    _topPCT = (topPCT>1) ? 1 : topPCT;
    _isTopPCT = YES;
    //防对象没有宽高
    if (_isBottomPCT) {
        _selfView.height = 0.5;
    }
}

-(void)setLeftPCT:(CGFloat)leftPCT {
    _leftPCT = (leftPCT>1) ? 1 : leftPCT;
    _isLeftPCT = YES;
    //防对象没有宽高
    if (_isRightPCT) {
        _selfView.width = 0.5;
    }
}

-(void)setRightPCT:(CGFloat)rightPCT {
    _rightPCT = (rightPCT>1) ? 1 : rightPCT;
    _isRightPCT = YES;
    //防对象没有宽高
    if (_isLeftPCT) {
        _selfView.width = 0.5;
    }
}

-(void)setBottomPCT:(CGFloat)bottomPCT {
    _bottomPCT = (bottomPCT>1) ? 1 : bottomPCT;
    _isBottomPCT = YES;
    //防对象没有宽高
    if (_isTopPCT) {
        _selfView.height = 0.5;
    }
}

-(void)setWidthPCT:(CGFloat)widthPCT {
    _widthPCT = (widthPCT>1) ? 1 : widthPCT;
    _isWidthPCT = YES;
    //防对象没有宽高
    _selfView.width = 0.5;
}

-(void)setHeightPCT:(CGFloat)heightPCT {
    _heightPCT = (heightPCT>1) ? 1 : heightPCT;
    _isHeightPCT = YES;
    //防对象没有宽高
    _selfView.height = 0.5;
}

-(void)setCenterX:(CGFloat)centerX {
    _centerX = centerX;
    _isCenterX = YES;
}

-(void)setCenterY:(CGFloat)centerY {
    _centerY = centerY;
    _isCenterY = YES;
}



#pragma mark - 外部方法 -

/** 只清除 style 坐标和大小 */
-(void)restyle
{
    _isTop    = NO;
    _isBottom = NO;
    _isLeft   = NO;
    _isRight  = NO;

    _isTopPCT    = NO;
    _isBottomPCT = NO;
    _isLeftPCT   = NO;
    _isRightPCT  = NO;

    _isWidthPCT  = NO;
    _isHeightPCT = NO;

    _isCenterX   = NO;
    _isCenterY   = NO;
}

/** 处理Style结束后,计算完尺寸后,处理其它 (可再修改尺寸) */
-(void)setLayoutSubviewDidFinish:(setLayoutSubviewBlock)block
{
    _finishBlock = block;
}

/** 画图层: 处理后,Block (可以自定义画任何东西) */
-(void)setDrawRectDidFinish:(setDrawRectBlock)block
{
    _finishDrawRectBlock = block;
}


#pragma mark - 内部方法 (不公开的) -

/** 处理完Style后 (开始处理 + 一般由Style自动调用) */
-(void)_setLayoutSubviewFinishBlock:(UIView *)view
{
    if (_finishBlock) {
        _finishBlock(view);
    }
}

/** 处理DrawRect画图层 (开始处理 + 一般由Style自动调用) */
-(void)_setDrawRectFinishBlock:(UIView *)view drawRect:(CGRect)rect
{
    if (_finishDrawRectBlock) {
        _finishDrawRectBlock(view, rect);
    }
}


/** 设置坐标定位 */
-(void)_stylePositionWhitView:(UIView *)view
{
    UIView *superView = view.superview;
    
    //计算的
    CGFloat w,h, x,y, centerX,centerY;
    //对象源始的
    CGFloat wOrig, hOrig, xOrig, yOrig, centerXOrig, centerYOrig;
    //父对象
    CGFloat supW, supH;
    
    CGRect frame = view.frame;
    w = wOrig = frame.size.width;
    h = hOrig = frame.size.height;
    x = xOrig = frame.origin.x;
    y = yOrig = frame.origin.y;
    centerX = centerXOrig = view.center.x;
    centerY = centerYOrig = view.center.y;
    
    CGRect supFrame = superView.frame;
    supW = supFrame.size.width;
    supH = supFrame.size.height;
    
    
    
    if (supW == 0 || supH == 0) {
        return;
    }
    
    //大小
    if (_isWidthPCT) {
        w = supW * self.widthPCT;
    }
    if (_isHeightPCT) {
        h = supH * self.heightPCT;
    }
    
    //数值坐标
    if (_isTop && _isBottom) {
        h = supH - self.top - self.bottom;
    }
    if (_isLeft && _isRight) {
        w = supW - self.left - self.right;
    }
    if (_isTop) {
        y = self.top;
    }
    if (_isBottom) {
        y = supH - h - self.bottom;
    }
    if (_isLeft) {
        x = self.left;
    }
    if (_isRight) {
        x = supW - w - self.right;
    }
    
    //百分比坐标
    if (_isTopPCT && _isBottomPCT) {
        //HEIGHT
        y = supH * self.topPCT;
        h = supH - supH * (self.topPCT + self.bottomPCT);
    }else{
        if (_isTopPCT) {
            y = supH * self.topPCT;
        }
        
        if (_isBottomPCT) {
            y = supH - supH * self.bottomPCT - h;
        }
    }
    
    if (_isLeftPCT && _isRightPCT){
        //WIDTH
        x = supW * self.leftPCT;
        w = supW - supW * (self.leftPCT + self.rightPCT);
    }else{
        if (_isLeftPCT) {
            x = supW * self.leftPCT;
        }
        
        if (_isRightPCT) {
            x = supW - supW * self.rightPCT - w;
        }
    }
    
    if (_isCenterX) {
        centerX = supW * 0.5 + self.centerX;
    }
    if (_isCenterY) {
        centerY = supH * 0.5 + self.centerY;
    }
    
    //赋值
    if (x != xOrig || y != yOrig || w != wOrig || h != hOrig) {
        view.frame = CGRectMake( x, y, w, h);
    }
    if (centerX != centerXOrig) {
        view.centerX = centerX;
    }
    if (centerY != centerYOrig) {
        view.centerY = centerY;
    }
}

/** 创建圆角样式返回 */
-(UIBezierPath *)_styleRepeatEdgeWithView:(UIView *)view
{
    UIBezierPath *path = nil;
    UIRectCorner corners;
    
    UIEdgeInsets e = self.roundEdge;
    
    if (e.top==0 && e.left>0 && e.bottom==0 && e.right==0) {
        
        corners = UIRectCornerBottomLeft;
    }
    else if(e.top==0 && e.left==0 && e.bottom>0 && e.right==0){
        
        corners = UIRectCornerBottomRight;
    }
    else if(e.top>0 && e.left==0 && e.bottom==0 && e.right==0){
        
        corners = UIRectCornerTopLeft;
    }
    else if(e.top==0 && e.left==0 && e.bottom==0 && e.right>0){
        
        corners = UIRectCornerTopRight;
    }
    else if(e.top>0 && e.left==0 && e.bottom>0 && e.right==0){
        
        corners = UIRectCornerTopLeft | UIRectCornerBottomRight;
    }
    else if(e.top==0 && e.left>0 && e.bottom>0 && e.right==0){
        
        corners = UIRectCornerBottomLeft | UIRectCornerBottomRight;
    }
    else if(e.top==0 && e.left>0 && e.bottom==0 && e.right>0){
        
        corners = UIRectCornerBottomLeft | UIRectCornerTopRight;
    }
    else if(e.top>0 && e.left==0 && e.bottom==0 && e.right>0){
        
        corners = UIRectCornerTopLeft | UIRectCornerTopRight;
    }
    else if(e.top>0 && e.left>0 && e.bottom==0 && e.right==0){
        
        corners = UIRectCornerBottomLeft | UIRectCornerTopLeft;
    }
    else if(e.top==0 && e.left==0 && e.bottom>0 && e.right>0){
        
        corners = UIRectCornerBottomRight | UIRectCornerTopRight;
    }
    else if(e.top>0 && e.left==0 && e.bottom>0 && e.right>0){
        
        corners = UIRectCornerBottomRight | UIRectCornerTopRight | UIRectCornerTopLeft;
    }
    else if(e.top==0 && e.left>0 && e.bottom>0 && e.right>0){
        
        corners = UIRectCornerBottomRight | UIRectCornerTopRight | UIRectCornerBottomLeft;
    }
    else if(e.top>0 && e.left>0 && e.bottom>0 && e.right==0){
        
        corners = UIRectCornerBottomRight | UIRectCornerTopLeft | UIRectCornerBottomLeft;
    }
    else if(e.top>0 && e.left>0 && e.bottom==0 && e.right>0){
        
        corners = UIRectCornerTopRight | UIRectCornerTopLeft | UIRectCornerBottomLeft;
    }
    else {
        corners = UIRectCornerAllCorners;
    }
    
    if (e.top>0 || e.left>0 || e.bottom>0 || e.right>0) {
        
        if(self.roundAngle > 0){
            
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds
                                                           byRoundingCorners:corners
                                                                 cornerRadii:CGSizeMake(self.roundAngle,self.roundAngle)];
            CAShapeLayer *maskLayer = [CAShapeLayer layer];
            maskLayer.frame         = view.bounds;
            maskLayer.path          = maskPath.CGPath;
            view.layer.mask          = maskLayer;
            view.layer.masksToBounds = YES;
            path = maskPath;
            
        }
    }else if(self.roundAngle > 0){
        //圆角
        view.layer.cornerRadius = self.roundAngle;
        view.layer.masksToBounds = YES;
    }else if(self.roundAngle <= 0){
        
        view.layer.cornerRadius = 0;
        view.layer.masksToBounds = NO;
    }
    
    //设置边样式
    if (self.borderWidth > 0 && path==nil) {
        view.layer.borderWidth = self.borderWidth;
        view.layer.borderColor = self.borderColor.CGColor;
    }
    return path;
}


@end
