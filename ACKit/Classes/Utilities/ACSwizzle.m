//
//  ACSwizzle.m
//  ACKit
//
//  Created by Austin Chen on 2018-01-21.
//

#import "ACSwizzle.h"
#import <objc/runtime.h>

@implementation ACSwizzle

+(void)swizzleSelector:(SEL)oldSelector withNewSelector:(SEL)newSelector onObject:(NSObject *)object {
    Class class = [object class];
    
    SEL originalSelector = oldSelector;
    SEL swizzledSelector = newSelector;
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    // When swizzling a class method, use the following:
    // Class class = object_getClass((id)self);
    // ...
    // Method originalMethod = class_getClassMethod(class, originalSelector);
    // Method swizzledMethod = class_getClassMethod(class, swizzledSelector);
    
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end
