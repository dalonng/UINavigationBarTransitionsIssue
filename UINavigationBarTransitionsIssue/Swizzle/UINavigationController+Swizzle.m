//
//  UINavigationController+Swizzle.m
//  UINavigationBarTransitionsIssue
//
//  Created by 大龙 on 2023/9/8.
//

@import UIKit;
#import "UINavigationController+Swizzle.h"
#import "JRSwizzle.h"

@implementation UINavigationController (DEBUG_HOOK)

+ (void)load {
    [self jr_swizzleMethod:NSSelectorFromString(@"_computeTopBarCenter:hidden:edge:center:offset:") withMethod:@selector(_ks_computeTopBarCenter:hidden:edge:center:offset:) error:nil];
    
    [self jr_swizzleMethod:NSSelectorFromString(@"_useStandardStatusBarHeight") withMethod:@selector(_ks_useStandardStatusBarHeight) error:nil];
    [self jr_swizzleMethod:NSSelectorFromString(@"_viewControllerUnderlapsStatusBar") withMethod:@selector(_ks_viewControllerUnderlapsStatusBar) error:nil];
    [self jr_swizzleMethod:NSSelectorFromString(@"_statusBarHeightAdjustmentForCurrentOrientation") withMethod:@selector(_ks_statusBarHeightAdjustmentForCurrentOrientation) error:nil];
    
    [self jr_swizzleMethod:NSSelectorFromString(@"_setContentOverlayInsets:") withMethod:@selector(_ks_setContentOverlayInsets:) error:nil];
    
    [self jr_swizzleMethod:NSSelectorFromString(@"_positionNavigationBar:hidden:edge:center:offset:") withMethod:@selector(_ks_positionNavigationBar:hidden:edge:center:offset:) error:nil];
    
    [self jr_swizzleMethod:NSSelectorFromString(@"_positionNavigationBarHidden:edge:initialOffset:") withMethod:@selector(_ks_positionNavigationBarHidden:edge:initialOffset:) error:nil];
}

- (CGPoint)_ks_computeTopBarCenter:(id)arg1 hidden:(bool)arg2 edge:(unsigned long long)arg3 center:(CGPoint)arg4 offset:(double)arg5 {
    NSLog(@"NavigationUpdate _ks_computeTopBarCenter Params %@, %@, %@, %@, %@", arg1, @(arg2), @(arg3), NSStringFromCGPoint(arg4), @(arg5));
    NSLog(@"NavigationUpdate _ks_computeTopBarCenter Result %@", NSStringFromCGPoint([self _ks_computeTopBarCenter:arg1 hidden:arg2 edge:arg3 center:arg4 offset:arg5]));
    return [self _ks_computeTopBarCenter:arg1 hidden:arg2 edge:arg3 center:arg4 offset:arg5];
}

- (BOOL)_ks_useStandardStatusBarHeight {
    NSLog(@"NavigationUpdate _ks_useStandardStatusBarHeight %@", @([self _ks_useStandardStatusBarHeight]));
    return [self _ks_useStandardStatusBarHeight];
}

- (BOOL)_ks_viewControllerUnderlapsStatusBar {
    NSLog(@"NavigationUpdate _ks_viewControllerUnderlapsStatusBar %@", @([self _ks_viewControllerUnderlapsStatusBar]));
    return [self _ks_viewControllerUnderlapsStatusBar];
}

-(double)_ks_statusBarHeightAdjustmentForCurrentOrientation {
    NSLog(@"NavigationUpdate _ks_statusBarHeightAdjustmentForCurrentOrientation %@", @([self _ks_statusBarHeightAdjustmentForCurrentOrientation]));
    return [self _ks_statusBarHeightAdjustmentForCurrentOrientation];
}

-(void)_ks_positionNavigationBar:(id)arg1 hidden:(BOOL)arg2 edge:(unsigned long long)arg3 center:(CGPoint)arg4 offset:(double)arg5 {
    NSLog(@"NavigationUpdate _ks_positionNavigationBar Params bar: %@, hidden: %@, edge: %@, center: %@, offset: %@", arg1, @(arg2), @(arg3), NSStringFromCGPoint(arg4), @(arg5));
    [self _ks_positionNavigationBar:arg1 hidden:arg2 edge:arg3 center:arg4 offset:arg5];
}

-(void)_ks_positionNavigationBarHidden:(BOOL)arg1 edge:(unsigned long long)arg2 initialOffset:(double)arg3  {
    NSLog(@"NavigationUpdate _ks_positionNavigationBarHidden Params hidden: %@, edge: %@, initialOffset: %@", @(arg1), @(arg2), @(arg3));
    [self _ks_positionNavigationBarHidden:arg1 edge:arg2 initialOffset:arg3];
}

- (void)_ks_setContentOverlayInsets:(UIEdgeInsets)insets {
    NSLog(@"NavigationUpdate ks_setContentOverlayInsets Params %@", NSStringFromUIEdgeInsets(insets));
    [self _ks_setContentOverlayInsets:insets];
}

@end
