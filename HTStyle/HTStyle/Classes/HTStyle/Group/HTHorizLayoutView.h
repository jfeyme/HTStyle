//
//  HTHorizLayoutView.h
//
//  Created by jfey on 16/6/10.
//  Copyright © 2016年 jfey. All rights reserved.
//
//  水平布局View (默认:水平布局 || 垂直布局)
//  用于:添加多个一样大小的子对象, 自动平均分宽度
//  如果添加入Button需要禁止交互, 才可以使用当前单击事件

#import <UIKit/UIKit.h>
#import "HTView.h"
@class HTHorizLayoutView;

//cell数量
typedef NSInteger (^horizCellCountHorizBlock)(void);
//cellView主内容
typedef UIView* (^horizCellViewHorizBlock)(NSInteger index);
//cell单击事件
typedef void (^horizCellHorizClickBlock)(NSInteger index, UIView* subView, HTHorizLayoutView* selfView);

typedef enum : NSUInteger {
    /** 左到右排列 (水平 默认) */
    HTHorizLayoutTypeLeftToRight,
    /** 上到下排列 (垂直) */
    HTHorizLayoutTypeTopToBottom
    
} HTHorizLayoutType;


@interface HTHorizLayoutView : HTView

/** 排列方式 (默认:水平 || 垂直) */
@property(nonatomic,assign) HTHorizLayoutType contentLayout;

/** 对象之间:分隔线线粗大小 */
@property(nonatomic,assign) CGFloat separationHeight;
/** 对象之间:分隔线宽度比例 (默认1 是全宽) */
@property(nonatomic,assign) CGFloat separationWScale;
/** 对象之间:分隔线条头样式 */
@property(nonatomic,assign) CGLineCap separationLineCap;
/** 对象之间:分隔线颜色 */
@property(nonatomic,strong) UIColor *separationColor;
/** 对象之间:分隔线是否要计算保留边距 (默认:NO, style.padding无效) */
@property(nonatomic,assign) BOOL isSeparationStylePadding;


/** 刷新数据: 重新三问 */
-(void)reloadData;

/** 第一问: 返回数量 */
-(void)setHorizCellCount:(horizCellCountHorizBlock)block;
/** 第二问: 返回子对象内容View */
-(void)setHorizCellView:(horizCellViewHorizBlock)block;
/** 第三答: 单击事件 */
-(void)setHorizCellonClick:(horizCellHorizClickBlock)block;

@end
