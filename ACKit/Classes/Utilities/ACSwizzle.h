//
//  ACSwizzle.h
//  ACKit
//
//  Created by Austin Chen on 2018-01-21.
//

#import <Foundation/Foundation.h>

@interface ACSwizzle : NSObject

+(void)swizzleSelector:(SEL)oldSelector withNewSelector:(SEL)newSelector onObject:(NSObject *)object;

@end
