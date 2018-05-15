//
//  UINavigationController+Cloudox.m
//  LittleBlackBear
//
//  Created by MichaelChan on 12/5/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

#import "UINavigationController+Cloudox.h"

@implementation UINavigationController (Cloudox)
- (void)setNeedsNavigationBackground:(CGFloat)alpha {
    // 导航栏背景透明度设置
    UIView *barBackgroundView = [[self.navigationBar subviews] objectAtIndex:0];// _UIBarBackground
    UIImageView *backgroundImageView = [[barBackgroundView subviews] objectAtIndex:0];// UIImageView
    if (self.navigationBar.isTranslucent) {
        if (backgroundImageView != nil && backgroundImageView.image != nil) {
            barBackgroundView.alpha = alpha;
            
        } else {
            UIView *backgroundEffectView = [[barBackgroundView subviews] objectAtIndex:1];// UIVisualEffectView
            if (backgroundEffectView != nil) {
                backgroundEffectView.alpha = alpha;
            }
        }
    } else {
        barBackgroundView.alpha = alpha;
    }
    self.navigationBar.clipsToBounds = alpha == 0.0;
}
@end
