//
//  HTTextField.h
//
//  Created by jfey on 16/6/10.
//  Copyright © 2016年 jfey. All rights reserved.
//  带占位文字的文本框
//  注意:如果设置了图片,通过指针修改图片内容大小, 必须更新两个 [textF setNeedsLayout]; AND [textF setNeedsDisplay];

#import <UIKit/UIKit.h>
#import "HTStyleClass.h"

@interface HTTextField : UITextField

@property(nonatomic,strong) HTStyleClass *style;

@end
