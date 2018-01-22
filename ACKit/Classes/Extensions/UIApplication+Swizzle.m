//
//  UIApplication+Swizzle.m
//  SnackableTV
//
//  Created by Austin Chen on 2017-04-20.
//  Copyright © 2017 Austin Chen. All rights reserved.
//

#import "UIApplication+Swizzle.h"
#import "ACSwizzle.h"

@implementation UIApplication (Swizzle)

-(void)swizzleStatusBar {
    [ACSwizzle swizzleSelector:@selector(setStatusBarHidden:) withNewSelector:@selector(newSetStatusBarHidden:) onObject: self];
}

#pragma mark - example method

-(void) newSetStatusBarHidden:(BOOL)hidden {
    NSLog(@"reach ac"); // so anyone who try to hide status bar would not work
}

@end
