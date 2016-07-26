//
//  HTLabel.h
//  JfeyHTStyle
//
//  Created by jfey on 16/6/15.
//  Copyright © 2016年 jfey. All rights reserved.
//  如果初始化对象时, 没有设置宽和高, 那么第一次设置文字时,全计算一次大小,然后就按当前的大小固定
//  如果只设置了宽, 全自动把高算出并设置上, 下次不会再算了,因为有宽高了


#import <UIKit/UIKit.h>
#import "HTStyleClass.h"

@interface HTLabel : UILabel

@property(nonatomic,strong) HTStyleClass *style;

/** 
 * 是否自动处理: (默认:NO) 每次设置文字时自动计算[sizeToFit]
 * [注意]不能设置为多行内容,这样会限制了大小
 */
@property(nonatomic,assign) BOOL isSizeToFit;

@end
