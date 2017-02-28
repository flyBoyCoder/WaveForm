//
//  BDWaveForm.m
//  BDWaveForm
//
//  Created by T on 17/2/28.
//  Copyright © 2017年 benbun. All rights reserved.
//

#import "WaveForm.h"

@interface WaveForm ()
@property (nonatomic, strong) CADisplayLink *timer;
@property (nonatomic, strong) CAShapeLayer *realShapeLayer;
@property (nonatomic, strong) CAShapeLayer *maskShapeLayer;
@property(nonatomic,strong) UIImageView *iconImageView;
@property (nonatomic, assign) CGFloat offset;

@end

@implementation WaveForm

- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        
        self.realWaveColor = [UIColor whiteColor];
        self.maskWaveColor = RGBACOLOR(255, 255, 255, 0.5);
        self.waveformHeight = 5.f;
        self.waveSpeed = 0.5;
        self.waveCurvature = 1.5;
        
        self.realShapeLayer = [CAShapeLayer layer];
        self.realShapeLayer.fillColor = self.realWaveColor.CGColor;
        [self.layer addSublayer:self.realShapeLayer];
        
        self.maskShapeLayer = [CAShapeLayer layer];
        self.maskShapeLayer.fillColor = self.maskWaveColor.CGColor;
        [self.layer addSublayer:self.maskShapeLayer];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat height = CGRectGetHeight(self.frame);
    CGFloat width = CGRectGetWidth(self.frame);
    self.realShapeLayer.frame = CGRectMake(0, height - self.waveformHeight, width, self.waveformHeight);
    self.maskShapeLayer.frame = CGRectMake(0, height - self.waveformHeight, width, self.waveformHeight);
    
}

- (void)startAnimation{
    self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(animation)];
    [self.timer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)endAnimation{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)dealloc{
    
    [self endAnimation];
    
    if (self.realShapeLayer) {
        [self.realShapeLayer removeFromSuperlayer];
    }
    
    if (self.maskShapeLayer) {
        [self.maskShapeLayer removeFromSuperlayer];
    }
}

- (void)animation{
    self.offset += self.waveSpeed;
    
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = self.waveformHeight;
    

    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, height);
    CGFloat y = 0.f;

    CGMutablePathRef maskpath = CGPathCreateMutable();
    CGPathMoveToPoint(maskpath, NULL, 0, height);
    CGFloat maskY = 0.f;
    for (CGFloat x = 0.f; x <= width ; x++) {
        y = height * sinf(0.01 * self.waveCurvature * x + self.offset * 0.045);
        CGPathAddLineToPoint(path, NULL, x, y);
        maskY = -y;
        CGPathAddLineToPoint(maskpath, NULL, x, maskY);
    }
    
    CGPathAddLineToPoint(path, NULL, width, height);
    CGPathAddLineToPoint(path, NULL, 0, height);
    CGPathCloseSubpath(path);
    self.realShapeLayer.path = path;
    self.realShapeLayer.fillColor = self.realWaveColor.CGColor;
    CGPathRelease(path);
    
    CGPathAddLineToPoint(maskpath, NULL, width, height);
    CGPathAddLineToPoint(maskpath, NULL, 0, height);
    CGPathCloseSubpath(maskpath);
    self.maskShapeLayer.path = maskpath;
    self.maskShapeLayer.fillColor = self.maskWaveColor.CGColor;
    CGPathRelease(maskpath);
}
@end
