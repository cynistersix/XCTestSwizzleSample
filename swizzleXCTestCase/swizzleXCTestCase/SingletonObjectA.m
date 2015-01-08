//
//  SingletonObjectA.m
//  swizzleXCTestCase
//
//  Created by Daniel Biran on 1/7/15.
//  Copyright (c) 2015 stackoverflow. All rights reserved.
//

#import "SingletonObjectA.h"
#import <Reachability/Reachability.h>

@interface SingletonObjectA ()

@property (nonatomic, strong) Reachability *reachability;

@end

@implementation SingletonObjectA

+ (id) sharedSingletonObjectA {
    
    static SingletonObjectA* sharedSingletonObjectA = nil;
    static dispatch_once_t onceToken;
    dispatch_once( &onceToken, ^{
        sharedSingletonObjectA = [[SingletonObjectA alloc] init];
    });
    
    return sharedSingletonObjectA;
}

- (void)checkAmOnline {
    
    Reachability* reachability = [Reachability reachabilityWithHostname:@"www.google.com"];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    
    NSLog(@"networkStatus is: %ld", networkStatus);
}

@end
