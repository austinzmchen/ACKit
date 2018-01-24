//
//  KCParallaxView.h
//  AldoMCEv1
//
//  Created by Austin Chen on 2015-03-11.
//  Copyright (c) 2015 Kineticcafe. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, KCParallaxViewScrollOrientation) {
    KCParallaxViewScrollOrientationVertical
};

typedef NS_ENUM(NSInteger, KCParallaxViewScrollStartingPosition) {
    KCParallaxViewScrollStartingPositionCenter,
    KCParallaxViewScrollStartingPositionBottom
};

@interface KCParallaxView : UIView {
    CGPoint _imageViewOffset;
}

extern CGFloat const KCParallaxViewScrollFactorAutomatic;

@property (nonatomic, retain) UIImageView *backgroundImageView;
@property (nonatomic, assign) KCParallaxViewScrollOrientation parallaxScrollOrientation;

/**
 * Indicates which edge of the screen the parallax image starts to appear, default is center
 */
@property (nonatomic, assign) KCParallaxViewScrollStartingPosition parallaxStartingPosition;

/**
 * Indicates the speed of parallax effect. 0 for turning off parallax; 1 for equal scroll distance as user scrolling. setting the value to KCParallaxViewScrollFactorAutomatic will allow automatically adjusting of such value so that the image scroll within the bounds
 */
@property (nonatomic, assign) CGFloat parallaxScrollFactor;

/**
 * Allowing automatically adjusting of parallaxScrollFactor so that the image scroll within the bounds
 */
@property (nonatomic, assign) CGRect parallaxScrollFactorByBounds;

/**
 Used in parent scroll view's scrollViewDidScroll delegate methods to present a parallax effect
 
 @param rect
 the rect of the current KCParallaxView, in the coordinate system of the parent's/container's view. To convert to parent's coordinate system, use -[convertRect: toView:]
 @param visibleBounds
 the bounds of the parent view, which is visible to the user
 */
- (void)adjustParallaxByRect:(CGRect)rect onVisibleBounds:(CGRect)visibleBounds;
@end
