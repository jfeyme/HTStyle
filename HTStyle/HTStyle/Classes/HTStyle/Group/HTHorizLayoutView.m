//
//  HTHorizLayoutView.m
//
//  Created by jfey on 16/6/10.
//  Copyright © 2016年 jfey. All rights reserved.
//

#import "HTHorizLayoutView.h"
#import "UIView+HTStyleView.h"

@interface HTHorizLayoutView ()
@property(nonatomic,strong) UITapGestureRecognizer *tap; //w
@property(nonatomic,assign) NSInteger cellCount;
@property(nonatomic,copy) horizCellCountHorizBlock countBlock;
@property(nonatomic,copy) horizCellViewHorizBlock viewBlock;
@property(nonatomic,copy) horizCellHorizClickBlock clickBlock;
@end


@implementation HTHorizLayoutView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.separationWScale = 1;
    }
    return self;
}


-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    if (self.separationHeight > 0) {
        //需要分隔线
        if (self.contentLayout == HTHorizLayoutTypeLeftToRight) {
            [self horizontal];
        }else{
            [self vertical];
        }
    }
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //ContentLayout
    [self setupContentLayout];
}

////计算内容
-(void)setupContentLayout
{
    //有效值尺寸
    CGFloat x = MAX(self.style.padding, self.style.paddingLeft) + self.style.borderWidth;
    CGFloat y = MAX(self.style.padding, self.style.paddingTop) + self.style.borderWidth;
    CGFloat width = self.width - x - MAX(self.style.padding, self.style.paddingRight);
    CGFloat height = self.height - y - MAX(self.style.padding, self.style.paddingBottom);
    width -= self.style.borderWidth;
    height -= self.style.borderWidth;
    
    //计算子内容,单个大小
    int count = (int)self.subviews.count;
    
    //水平排列
    if (self.contentLayout == HTHorizLayoutTypeLeftToRight) {
        
        CGFloat subW = (width-self.style.interval*(count-1)) / count;
        for (int i=0; i<count; i++) {
            UIView *view = self.subviews[i];
            view.width = subW;
            view.height = height;
            view.y = y;
            view.x = x + subW * i + i * self.style.interval;
        }
        
        //垂直布局
    }else{
        CGFloat subH = (height - self.style.interval*(count-1)) / count;
        
        for (int i=0; i<count; i++) {
            UIView *view = self.subviews[i];
            view.width = width;
            view.height = subH;
            view.x = x;
            view.y = y + subH * i + i * self.style.interval;
        }
    }
}

////水平画线
-(void)horizontal{
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

////垂直画线
-(void)vertical{
    //这里是按子内容与子内容两两之间画
    NSMutableArray *arrayPX = [NSMutableArray array];
    for (int i=0; i<(self.subviews.count-1); i++) {
        UIView *one = self.subviews[i];
        UIView *two = self.subviews[i+1];
        CGFloat y = (two.y - CGRectGetMaxY(one.frame))*0.5;
        y = CGRectGetMaxY(one.frame) + y;
        [arrayPX addObject:@(y)];
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
    
    //开始按点位置画线
    for (int i=0; i<arrayPX.count; i++) {
        CGFloat y = [arrayPX[i] floatValue];
        [path moveToPoint:CGPointMake(x , y)];
        [path addLineToPoint:CGPointMake(x + width, y)];
        [path stroke];
    }
}


#pragma mark - ** 数据源方法 ** -

///// 刷新数据: 重新三问
-(void)reloadData
{
    //清除所有子对象
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //重新创建问题
    [self setHorizCellCount:_countBlock];
    [self setHorizCellView: _viewBlock];
}
////第一问:
-(void)setHorizCellCount:(horizCellCountHorizBlock)block
{
    _countBlock = block;
    NSInteger count = block();
    _cellCount = count;
}
////第二问:
-(void)setHorizCellView:(horizCellViewHorizBlock)block
{
    _viewBlock = block;
    if (_cellCount==0) {
        return;//没有内容数量
    }
    
    for (NSInteger i=0; i<_cellCount; i++) {
        UIView *sub = block(i);
        //
        [self addSubview:sub];
    }
}
////第三答:
-(void)setHorizCellonClick:(horizCellHorizClickBlock)block
{
    //只存方法Block
    _clickBlock = block;
    
    [self removeGestureRecognizer:_tap];
    //有事件时,才添加单击手势
    _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    [self addGestureRecognizer:_tap];
}

-(void)tapClick:(UITapGestureRecognizer*)tap
{
    CGPoint po = [tap locationInView:self];
    //找到目标位的子对象
    
    for (int i=0; i<self.subviews.count; i++) {
        UIView *sub = self.subviews[i];
        if (CGRectContainsPoint(sub.frame, po)) {
            //找到了
            if (_clickBlock) {
                typeof(self) __weak weakSelf = self;
                _clickBlock(i , sub, weakSelf);
            }
        }
    }
}

@end
