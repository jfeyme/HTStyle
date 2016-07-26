//
//  HTGridLayoutView.h
//  HTStyle
//
//  Created by jfey on 16/6/23.
//  Copyright © 2016年 jfey. All rights reserved.
//
//  网格View (用来处理固定多行多列)
//  这里间距不使用style.interval; 使用这里定义的,因为有两个间距,所以不分开
//  计算时保留style.padding内边距量
//  如果出现分隔线,可以设置间距,然后用背景色来当线色...


#import <UIKit/UIKit.h>
#import "HTView.h"
@class HTGridLayoutView;

//cell数量
typedef NSInteger (^gridCellCountHorizBlock)(void);
//cellView主内容
typedef UIView* (^gridCellViewHorizBlock)(NSInteger index);
//cell单击事件
typedef void (^gridCellHorizClickBlock)(NSInteger index, UIView* subView, HTGridLayoutView* selfView);

@interface HTGridLayoutView : HTView

/** 网格: 行数 (默认: 1) */
@property(nonatomic,assign) NSInteger gridRow;

/** 网格: 列数 (必须) */
@property(nonatomic,assign) NSInteger gridColumn;


/** 一行: 子控件左右间距 */
@property(nonatomic,assign) CGFloat gridLeftRSpacing;

/** 一列: 子控件上下间距 */
@property(nonatomic,assign) CGFloat gridTopBSpacing;


/** 顶部 & 底部 是否计算入上下间距 (默认:NO) (YES:所有间距平均化) */
@property(nonatomic,assign) BOOL isGridTopBottom;

/** 左边 & 右边 是否计算入左右间距 (默认:NO) (YES:所有间距平均化) */
@property(nonatomic,assign) BOOL isGridLeftRight;


/** 刷新数据: 重新三问 */
-(void)reloadData;

/** 第一问: 返回数量 */
-(void)setGridCellCount:(gridCellCountHorizBlock)block;
/** 第二问: 返回子对象内容View */
-(void)setGridCellView:(gridCellViewHorizBlock)block;
/** 第三答: 单击事件 */
-(void)setGridCellonClick:(gridCellHorizClickBlock)block;

@end
