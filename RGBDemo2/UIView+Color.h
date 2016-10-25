//
//  UIView+Color.h
//  iHiho
//
//  Created by Shawn on 16/5/5.
//  Copyright © 2016年 Ruiju. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XXColor;

@interface UIView (Color)

- (XXColor *)hexColorForPoint:(CGPoint)point;

@end

@interface XXColor : NSObject

@property (nonatomic, strong) NSString * hexString;

@property (nonatomic, strong) UIColor * color;

@end