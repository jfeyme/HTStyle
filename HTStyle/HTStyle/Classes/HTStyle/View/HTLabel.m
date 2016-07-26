//
//  HTLabel.m
//  JfeyHTStyle
//
//  Created by jfey on 16/6/15.
//  Copyright © 2016年 jfey. All rights reserved.
//

#import "HTLabel.h"
#import "UIView+Using.h"
#import "UIView+HTStyleView.h"

@interface HTLabel ()

/** 当前是否自动调整了一次 */
@property(nonatomic, assign) BOOL isLayoutSubviewsSizeToFit;

@end

@implementation HTLabel

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        self.text = @""; //need
        
        self.style = [[HTStyleClass alloc] initWithView:self];
        self.myStyle = self.style;
    }
    return self;
}


-(void)setNumberOfLines:(NSInteger)numberOfLines
{
    [super setNumberOfLines:numberOfLines];
    if (numberOfLines != 1) {
        //多行时, 不自动计算
        _isSizeToFit = NO;
    }
}

-(void)setText:(NSString *)text
{
    [super setText:text];
    _isLayoutSubviewsSizeToFit = NO;
}

-(void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    _isLayoutSubviewsSizeToFit = NO;
}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.frame.size.width == 0 || self.frame.size.height == 0) {
        
        _isLayoutSubviewsSizeToFit = YES;
        
        [self sizeToFit];
        [self.style _stylePositionWhitView:self];
    }else{
        
        if (_isSizeToFit) {
            if (_isLayoutSubviewsSizeToFit == NO) {
                
                _isLayoutSubviewsSizeToFit = YES;
                [self sizeToFit];
                [self.style _stylePositionWhitView:self];
            }
        }
    }
}


@end
