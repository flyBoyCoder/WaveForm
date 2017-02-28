//
//  BDWaveForm.h
//  BDWaveForm
//
//  Created by T on 17/2/28.
//  Copyright © 2017年 benbun. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RGBACOLOR(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

@interface WaveForm : UIView
@property (nonatomic, assign) CGFloat waveformHeight;
@property (nonatomic, assign) CGFloat waveSpeed;
@property (nonatomic, assign) CGFloat waveCurvature;
@property(nonatomic,strong) UIColor *realWaveColor;
@property(nonatomic,strong) UIColor *maskWaveColor;


- (void)startAnimation;
- (void)endAnimation;
@end
