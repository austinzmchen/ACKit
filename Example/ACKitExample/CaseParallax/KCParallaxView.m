//
//  KCParallaxView.m
//  AldoMCEv1
//
//  Created by Austin Chen on 2015-03-11.
//  Copyright (c) 2015 Kineticcafe. All rights reserved.
//

#import "KCParallaxView.h"
#import "UIImageView+Aldo.h"

const CGFloat KCParallaxViewScrollFactorAutomatic = CGFLOAT_MAX;

@implementation KCParallaxView

- (void)didMoveToSuperview {
    [super didMoveToSuperview];

    self.clipsToBounds = YES;
    
    // add image view as a background
//        self.backgroundImageView = [[KCAutoFetchImageView alloc] initWithImageObject:nil defaultImage:[UIImage defaultProductImage]];
    self.backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFill; // the background image has to overflow the container
    self.backgroundImageView.userInteractionEnabled = NO;
    [self addSubview:self.backgroundImageView];
    
    // default centering image view
    _imageViewOffset = CGPointMake((self.bounds.size.width - self.backgroundImageView.bounds.size.width) / 2.0f,
                                   (self.bounds.size.height - self.backgroundImageView.bounds.size.height) / 2.0f);
//    CGRect f = self.backgroundImageView.frame;
//    f.origin.y = _imageViewOffset.y;
//    self.backgroundImageView.frame = f;
//    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect f = CGRectZero;
    
    // set either the width or height to start scaled image sizing
    f = self.backgroundImageView.frame;
    f.size.width = self.bounds.size.width;
    f.size.height = self.bounds.size.height;
    self.backgroundImageView.frame = f;

    f = self.backgroundImageView.frame;
    f.size = [self.backgroundImageView scaledImageSize];
    self.backgroundImageView.frame = f;
}

- (void)adjustParallaxByRect:(CGRect)rect onVisibleBounds:(CGRect)visibleBounds {
    CGRect rectIntersection = CGRectIntersection(rect, visibleBounds);
    if (CGRectIsEmpty(rectIntersection)) {
        // skip if self view is not shown in visibleBounds
        return;
    } else {
        if (self.parallaxScrollOrientation == KCParallaxViewScrollOrientationVertical) {
            if (self.parallaxStartingPosition == KCParallaxViewScrollStartingPositionCenter) {
                CGFloat bottomOffset = visibleBounds.size.height - rect.origin.y;
                /* a presumption is that the image is centered with respect to the visibleBounds, otherwise the image would have to be same height as the visible bound to look correct
                 * based on calculation, 1/2 * (visibleBounds_height - image_eight) + image_offset_y + bottom_offset = visibleBounds_height
                 */
                 CGFloat offetY = bottomOffset - ([self.backgroundImageView scaledImageSize].height / 2.0f + visibleBounds.size.height / 2.0f);
                _imageViewOffset.y = offetY * self.parallaxScrollFactor;
            } else if (self.parallaxStartingPosition == KCParallaxViewScrollStartingPositionBottom) {
                if (self.parallaxScrollFactor == KCParallaxViewScrollFactorAutomatic) {
                    CGRect imageScrollRealm = CGRectIsEmpty(self.parallaxScrollFactorByBounds) ? visibleBounds : self.parallaxScrollFactorByBounds;
                    CGFloat bottomOffset = visibleBounds.size.height - rect.origin.y;
                    /* For rect to move from side to side vertically on the visible bound, the background image has to move across visible bound height - image view height
                     */
                    CGFloat imageViewDisplacement = bottomOffset * ([self.backgroundImageView scaledImageSize].height - CGRectGetHeight(imageScrollRealm)) / CGRectGetHeight(imageScrollRealm);
                    _imageViewOffset.y = bottomOffset + imageViewDisplacement - [self.backgroundImageView scaledImageSize].height;
                }
            }
         
            //change background image view position
            if (_imageViewOffset.y != 0.0f) {
                CGRect f = self.backgroundImageView.frame;
                f.origin.y = _imageViewOffset.y;
                self.backgroundImageView.frame = f;
            }
        }
        [self setNeedsLayout];
    }
}

@end
