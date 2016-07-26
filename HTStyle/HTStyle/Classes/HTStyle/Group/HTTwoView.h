//
//  HTTwoView.h
//
//  Created by jfey on 16/6/11.
//  Copyright © 2016年 jfey. All rights reserved.
//  双层View (默认:上下排 || 左右排)
//  (上下空View)

#import <UIKit/UIKit.h>
#import "HTView.h"

typedef enum : NSUInteger {
    /** 上下排 (默认) */
    HTTwoViewContentLayoutTypeTopBottom,
    /** 左右排 */
    HTTwoViewContentLayoutTypeLeftRight
    
} HTTwoViewContentLayoutType; //布局方式


@interface HTTwoView : HTView

/** 上层 */
@property(nonatomic,weak) UIView *topView;
/** 下层 */
@property(nonatomic,weak) UIView *bottomView;

/** 对半分长度 (默认:0 对半分, 或超出宽,将对半分, 计算从左到右,上到下) */
@property(nonatomic,assign) int inLength;

/** 布局排列方式 */
@property(nonatomic,assign) HTTwoViewContentLayoutType contentLayout;

@end
