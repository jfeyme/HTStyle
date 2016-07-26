//
//  HTStyleClass.h
//  HTStyle
//
//  Created by jfey on 16/6/17.
//  Copyright © 2016年 jfey. All rights reserved.
//  坐标与大小信息
//  不需要的属性不用设置, 设置为0后,就一直有效

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^setLayoutSubviewBlock)(UIView*selfView);
typedef void(^setDrawRectBlock)(UIView*selfView, CGRect rect);

@interface HTStyleClass : NSObject

/** 基本坐标 */
@property(nonatomic,assign) CGFloat top;
@property(nonatomic,assign) CGFloat bottom;
@property(nonatomic,assign) CGFloat left;
@property(nonatomic,assign) CGFloat right;

/** 与父对象百分比坐标(0.0 ~ 1.0百分比坐标) */
@property(nonatomic,assign) CGFloat topPCT;
@property(nonatomic,assign) CGFloat bottomPCT;
@property(nonatomic,assign) CGFloat leftPCT;
@property(nonatomic,assign) CGFloat rightPCT;

/** (优先) 是否居中X (中心偏移量-> 正数向右, 负数向左) */
@property(nonatomic,assign) CGFloat centerX;
/** (优先) 是否居中Y (中心偏移量-> 正数向下, 负数向上) */
@property(nonatomic,assign) CGFloat centerY;

/** (定位优先) 百分比宽高(0.0~1.0) */
@property(nonatomic,assign) CGFloat widthPCT;
@property(nonatomic,assign) CGFloat heightPCT;

/** 内容间距 (可用于: 按键,双层,水平布局,组合View...) */
@property(nonatomic,assign) int interval;

/** 圆角度数 */
@property(nonatomic,assign) CGFloat roundAngle;
/** 圆角样式 4个角样式 (0,0,0,1)壹为圆角 */
@property(nonatomic,assign) UIEdgeInsets roundEdge;

/** 边线: 大小 */
@property(nonatomic,assign) CGFloat borderWidth;
/** 边线: 颜色 */
@property(nonatomic,strong) UIColor *borderColor;

/** 内边距 */
@property(nonatomic,assign) CGFloat padding;
@property(nonatomic,assign) CGFloat paddingTop;
@property(nonatomic,assign) CGFloat paddingBottom;
@property(nonatomic,assign) CGFloat paddingLeft;
@property(nonatomic,assign) CGFloat paddingRight;


/** 只清除 style 坐标和大小 */
-(void)restyle;

/** 处理Style布局完后,处理其它 (可再修改尺寸) *注意取其它HTView对像的可能不准 */
-(void)setLayoutSubviewDidFinish:(setLayoutSubviewBlock)block;

/** 画图层: 处理后,Block (可以自定义画任何东西) *注意取其它HTView对像的可能不准 */
-(void)setDrawRectDidFinish:(setDrawRectBlock)block;


#pragma mark -* 内部方法用 *-

/** 初始化 */
-(instancetype)initWithView:(UIView *)view;

/** 处理完Style后 (开始处理 + 一般由Style自动调用) */
-(void)_setLayoutSubviewFinishBlock:(UIView *)view;

/** 处理DrawRect画图层 (开始处理 + 一般由Style自动调用) */
-(void)_setDrawRectFinishBlock:(UIView *)view drawRect:(CGRect)rect;

/** 设置坐标定位 */
-(void)_stylePositionWhitView:(UIView *)view;

/** 创建圆角样式返回 */
-(UIBezierPath *)_styleRepeatEdgeWithView:(UIView *)view;


@end
