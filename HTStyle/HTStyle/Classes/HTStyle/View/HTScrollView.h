//
//  HTScrollView.h
//  HTStyle
//
//  Created by jfey on 16/6/18.
//  Copyright © 2016年 jfey. All rights reserved.
//  滚动View , 内容大小自动设置,每次布局都会设置,所以外部设置无效
//  默认: 不显示滚动条

#import <UIKit/UIKit.h>
#import "HTStyleClass.h"

typedef enum : NSUInteger {
    /** 默认:垂直方向滚动 , 子内容自动设置为最宽 */
    HTScrollViewToTypeVertical,
    /** 水平方向滚动 , 子内容自动设置为最高 */
    HTScrollViewToTypeHorizontal
    
} HTScrollViewToType;

@interface HTScrollView : UIScrollView

@property(nonatomic,strong) HTStyleClass *style;

/** 滚动方向,只能设置一次 (默认垂直:子内容需要高度) (水平:子内容需要宽度) */
@property(nonatomic,assign) HTScrollViewToType scrollType;

/** 特殊弹性滚动: 是否强制内容不足也能弹性拉动(默认为:NO) 如果为YES,内容大小会为父控件 + 0.25 */
@property(nonatomic,getter=isForceBouncesScroll) BOOL forceBouncesScroll;



///** 如果有导航条: 这里要加64 (默认为0) */
//@property(nonatomic,assign) CGFloat addNavigationHeight;
//
///** 如果有TabBar条: 这里要加49 (默认为0) */
//@property(nonatomic,assign) CGFloat addTabBarHeight;


@end
