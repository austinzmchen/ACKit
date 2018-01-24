//
//  UIImageView+Aldo.h
//  AldoMCEv1
//
//  Created by Michael Lan on 2014-11-18.
//  Copyright (c) 2014 Kineticcafe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Aldo)

- (CGSize)imageScaledFactor;
- (CGSize)imageScaledFactorByContentMode:(UIViewContentMode)contentMode;
- (CGSize)scaledImageSize;
- (CGSize)scaledImageSizeByContentMode:(UIViewContentMode)contentMode;

@end
