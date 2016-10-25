//
//  HMRGBSelectView.h
//  RGBDemo2
//
//  Created by zhoucan on 2016/10/25.
//  Copyright © 2016年 verfing. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol HMRGBSelectViewDelegate <NSObject>

@optional
-(void)getRGBPoint:(CGPoint)thePoint;

@end
@interface HMRGBSelectView : UIView

@property(nonatomic,assign)CGPoint selectPoint;
@property(nonatomic,weak)id<HMRGBSelectViewDelegate> delegate;
//@property(nonatomic,strong)UILabel * pointView;


@end
