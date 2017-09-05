//
//  UIImageView+Aldo.m
//  AldoMCEv1
//
//  Created by Michael Lan on 2014-11-18.
//  Copyright (c) 2014 Kineticcafe. All rights reserved.
//

#import "UIImageView+Aldo.h"

#define kAnimationDuration 1.5

@implementation UIImageView (Aldo)

+ (UIImage *)imageNamed:(NSString *)name withColor:(UIColor *)color{
    // load the image
    UIImage *img = [UIImage imageNamed:name];
    
    // begin a new image context, to draw our colored image onto
    UIGraphicsBeginImageContextWithOptions(img.size, NO, [[UIScreen mainScreen] scale]);
    
    // get a reference to that context we created
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // set the fill color
    [color setFill];
    
    // translate/flip the graphics context (for transforming from CG* coords to UI* coords
    CGContextTranslateCTM(context, 0, img.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    // set the blend mode to overlay, and the original image
    CGContextSetBlendMode(context, kCGBlendModeOverlay);
    CGRect rect = CGRectMake(0, 0, img.size.width, img.size.height);
    
    // set a mask that matches the shape of the image, then draw (overlay) a colored rectangle
    CGContextClipToMask(context, rect, img.CGImage);
    CGContextAddRect(context, rect);
    CGContextDrawPath(context,kCGPathFill);
    
    // generate a new UIImage from the graphics context we drew onto
    UIImage *coloredImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //return the color-burned image
    return coloredImg;
}

- (CGSize)imageScaledFactor {
    return [self imageScaledFactorByContentMode:self.contentMode];
}

- (CGSize)imageScaledFactorByContentMode:(UIViewContentMode)contentMode {
    // avoid NaN value as result of divison by zero
    CGFloat sx = (self.image.size.width < FLT_EPSILON) ? 0.0 : (self.frame.size.width / self.image.size.width);
    CGFloat sy = (self.image.size.height < FLT_EPSILON) ? 0.0 : (self.frame.size.height / self.image.size.height);
    CGFloat s = 1.0;
    switch (contentMode) {
        case UIViewContentModeScaleAspectFit:
            s = fminf(sx, sy);
            return CGSizeMake(s, s);
            break;
            
        case UIViewContentModeScaleAspectFill:
            s = fmaxf(sx, sy);
            return CGSizeMake(s, s);
            break;
            
        case UIViewContentModeScaleToFill:
            return CGSizeMake(sx, sy);
            
        default:
            return CGSizeMake(s, s);
    }
}

- (CGSize)scaledImageSize {
    return [self scaledImageSizeByContentMode:self.contentMode];
}

- (CGSize)scaledImageSizeByContentMode:(UIViewContentMode)contentMode {
    CGFloat width = self.image.size.width;
    CGFloat height = self.image.size.height;
    CGSize scaledFactor = [self imageScaledFactorByContentMode:contentMode];
    return CGSizeMake(width * scaledFactor.width, height * scaledFactor.height);
}

@end
