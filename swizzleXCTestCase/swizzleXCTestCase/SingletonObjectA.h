//
//  SingletonObjectA.h
//  swizzleXCTestCase
//
//  Created by Daniel Biran on 1/7/15.
//  Copyright (c) 2015 stackoverflow. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingletonObjectA : NSObject

+ (id) sharedSingletonObjectA;

- (void)checkAmOnline;

@end
