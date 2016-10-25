//
//  ViewController.m
//  RGBDemo2
//
//  Created by zhoucan on 2016/10/25.
//  Copyright © 2016年 verfing. All rights reserved.
//

#import "ViewController.h"
#import "HMRGBSelectView.h"
#import "MWCircleSlider.h"
#import "UIView+Color.h"
#import "HMRGBColorView.h"
@interface ViewController ()<HMRGBSelectViewDelegate>
{
    __weak IBOutlet UIView *selectView;
    HMRGBColorView * slider;
    HMRGBSelectView * zhuanP;
    XXColor * selecColor;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    HMRGBSelectView * sv = [[HMRGBSelectView alloc]init];
//    [self.view addSubview:sv];
    
    
//    let select = Bundle.main.loadNibNamed("HMRGBColorSelectView", owner: self, options: nil)?.first as! HMRGBColorSelectView
//    
//    select.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
//    select.center = view.center
//    view.addSubview(select)
    
    HMRGBColorView * colorV = [[NSBundle mainBundle]loadNibNamed:@"HMRGBColorView" owner:self options:nil].lastObject;
    colorV.frame =  CGRectMake(0, 0, 280, 280);
    colorV.center = self.view.center;
//    slider.backgroundColor = [UIColor clearColor];
    [self.view addSubview:colorV];
//    
//    MWCircleSlider * slider = [[MWCircleSlider alloc]initWithFrame:CGRectMake(0, 0, 280, 280)];
//    slider.center = self.view.center;
//    slider.backgroundColor = [UIColor clearColor];
//    [self.view addSubview:slider];
    
    HMRGBSelectView * sv = [[NSBundle mainBundle]loadNibNamed:@"HMRGBSelectView" owner:self options:nil].lastObject;
    sv.delegate = self;
    sv.frame = CGRectMake(0, 0, 110, 111);
    sv.center = self.view.center;
    [self.view addSubview:sv];
    
    slider = colorV;
    zhuanP = sv;
    
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [button setTitle:@"ON" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    button.center = self.view.center;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    
}

- (void)buttonClick:(UIButton*)btn{
    btn.selected = !btn.selected;
    NSLog(@"hello");
    
    NSLog(@"%@",NSStringFromCGPoint(zhuanP.selectPoint));
    
    
    if (btn.selected) {
        [btn setTitle:@"OFF" forState:UIControlStateNormal];
    }else{
     [btn setTitle:@"ON" forState:UIControlStateNormal];
    }
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark HMRGBSelectViewDelegate

 - (void)getRGBPoint:(CGPoint)thePoint
{
    
  CGPoint lastPoint = CGPointMake(thePoint.x + zhuanP.frame.origin.x  ,zhuanP.frame.origin.y+ thePoint.y);
    selecColor =  [self.view hexColorForPoint:lastPoint];
    NSLog(@"%@",selecColor);
    selectView.backgroundColor = selecColor.color;
    
    
    NSLog(@"progress:%f",slider.SliderView.progress);
    

}

@end
