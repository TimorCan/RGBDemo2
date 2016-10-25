//
//  UIView+Color.m
//  iHiho
//
//  Created by Shawn on 16/5/5.
//  Copyright © 2016年 Ruiju. All rights reserved.
//

#import "UIView+Color.h"

@implementation UIView (Color)

- (XXColor *)hexColorForPoint:(CGPoint)point
{
    unsigned char pixel[4] = {0};
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(pixel, 1, 1, 8, 4, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedLast);
    
    CGContextTranslateCTM(context, -point.x, -point.y);
    
    [self.layer renderInContext:context];
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    NSString * r = [[self class]_textForValue:pixel[0]];
    NSString * g = [[self class]_textForValue:pixel[1]];
    NSString * b = [[self class]_textForValue:pixel[2]];
//    NSString * a = [[self class]_textForValue:pixel[3]];
    XXColor * color = [[XXColor alloc]init];
    color.hexString = [NSString stringWithFormat:@"%@%@%@",r,g,b];
    color.color = [UIColor colorWithRed:(float)pixel[0]/255. green:(float)pixel[1]/255. blue:(float)pixel[2]/255. alpha:1.0];
    return color;
}

+ (NSString *)_textForValue:(int)value
{
    int v1 = value / 16;
    int v2 = value % 16;
  
    NSString * s1 = [[self class]charForNumber:v1];
    NSString * s2 = [[self class]charForNumber:v2];
    return [s1 stringByAppendingString:s2];
}

+ (NSString *)charForNumber:(int)num
{
    if (num < 10) {
        return [NSString stringWithFormat:@"%@",[NSNumber numberWithInt:num]];
    }else
    {
        switch (num) {
            case 10:
                return @"A";
                break;
            case 11:
                return @"B";
                break;
            case 12:
                return  @"C";
                break;
            case 13:
                return @"D";
                break;
            case 14:
                return  @"E";
                break;
            case 15:
                return @"F";
            default:
                return @"";
                break;
        }
    }
}
@end

@implementation XXColor
@end
