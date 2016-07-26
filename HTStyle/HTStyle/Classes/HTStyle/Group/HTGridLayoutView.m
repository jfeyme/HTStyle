//
//  HTGridLayoutView.m
//  HTStyle
//
//  Created by jfey on 16/6/23.
//  Copyright © 2016年 jfey. All rights reserved.
//

#import "HTGridLayoutView.h"
#import "UIView+HTStyleView.h"

@interface HTGridLayoutView ()
@property(nonatomic,strong) UITapGestureRecognizer *tap; //w
@property(nonatomic,assign) NSInteger cellCount;
@property(nonatomic,copy) gridCellCountHorizBlock countBlock;
@property(nonatomic,copy) gridCellViewHorizBlock viewBlock;
@property(nonatomic,copy) gridCellHorizClickBlock clickBlock;
@end

@implementation HTGridLayoutView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //布局
    [self setupContentLayout];
}

-(void)setupContentLayout
{
    
    //有效值尺寸
    CGFloat x = MAX(self.style.padding, self.style.paddingLeft) + self.style.borderWidth;
    CGFloat y = MAX(self.style.padding, self.style.paddingTop) + self.style.borderWidth;
    CGFloat width = self.width - x - MAX(self.style.padding, self.style.paddingRight);
    CGFloat height = self.height - y - MAX(self.style.padding, self.style.paddingBottom);
    width -= self.style.borderWidth;
    height -= self.style.borderWidth;
    
    
    //网格布局
    //计算得出要多少行才能
    NSInteger count = self.subviews.count;
    
    NSInteger row = ceilf( (CGFloat)count / self.gridColumn);
    _gridRow = row;
    
    NSInteger rowIndex = 0;
    NSInteger columnIndex = 0;
    
    NSInteger columnMargin = self.gridColumn - 1;
    if (self.isGridLeftRight) {
        columnMargin = self.gridColumn + 1;
        x = x + self.gridLeftRSpacing;
    }
    
    NSInteger rowMargin = row - 1;
    if (self.isGridTopBottom) {
        rowMargin = row + 1;
        y = y + self.gridTopBSpacing;
    }
    
    CGFloat subW = (width - self.gridLeftRSpacing * columnMargin ) / self.gridColumn;
    CGFloat subH = (height - self.gridTopBSpacing * rowMargin ) / row;
    
    for (int i=0; i<count; i++) {
        UIView *sub = self.subviews[i];
        sub.x = x + rowIndex * subW + self.gridLeftRSpacing * rowIndex;
        sub.y = y + columnIndex * subH + self.gridTopBSpacing * columnIndex;
        
        sub.width = subW;
        sub.height = subH;
        
        rowIndex ++;
        if (rowIndex >= self.gridColumn) {
            rowIndex = 0;
            columnIndex ++;
        }
    }
    
}


#pragma mark - ** 数据源方法 ** -

///// 刷新数据: 重新三问
-(void)reloadData
{
    //清除所有子对象
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //重新创建问题
    [self setGridCellCount:_countBlock];
    [self setGridCellView: _viewBlock];
}
////第一问:
-(void)setGridCellCount:(gridCellCountHorizBlock)block
{
    _countBlock = block;
    NSInteger count = block();
    _cellCount = count;
}
////第二问:
-(void)setGridCellView:(gridCellViewHorizBlock)block
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
-(void)setGridCellonClick:(gridCellHorizClickBlock)block
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
