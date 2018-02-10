//
//  NSObject+AssociatedObject.h
//  ACKit
//
//  Created by Austin Chen on 2018-01-21.
//

#import <Foundation/Foundation.h>

@interface NSObject (AssociatedObject)
@property (nonatomic, strong) id associatedObject;
    
// secondary 
@property (nonatomic, strong) id secondaryAssociatedObject;
@end
