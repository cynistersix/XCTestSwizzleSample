//
//  swizzleXCTestCaseTests.m
//  swizzleXCTestCaseTests
//
//  Created by Daniel Biran on 1/7/15.
//  Copyright (c) 2015 stackoverflow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <JRSwizzle/JRSwizzle.h>
#import <Reachability/Reachability.h>

#import "SingletonObjectA.h"

@interface SwizzleManager : NSObject 

+ (void)swizzleToDisconnected;
+ (void)swizzleOffDisconnected;

@end

@implementation SwizzleManager

+ (void)load {
    [SwizzleManager swizzleToDisconnected];
}

+ (void)swizzleFunctionA:(SEL)selectorA withB:(SEL)selectorB {
    NSError *error;
    BOOL result = [[Reachability class] jr_swizzleMethod:selectorA withMethod:selectorB error:&error];
    if (!result || error) {
        NSLog(@"Can't swizzle methods - %@", [error description]);
    }
}

+ (void)swizzleToDisconnected {
    [SwizzleManager swizzleFunctionA:@selector(currentReachabilityStatus) withB:@selector(test_currentReachabilityStatusDisconnected)];
}

+ (void)swizzleOffDisconnected {
    [SwizzleManager swizzleToDisconnected];
}

@end

@interface Reachability (SwizzleTest)

- (NetworkStatus)test_currentReachabilityStatusDisconnected;

@end

@implementation Reachability (SwizzleTest)

- (NetworkStatus)test_currentReachabilityStatusDisconnected {
    return NotReachable;
}

@end

@interface swizzleXCTestCaseTests : XCTestCase

@end

@implementation swizzleXCTestCaseTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testIsDisconnected {
    
    Reachability* reachability = [Reachability reachabilityWithHostname:@"www.google.com"];
    
    NSLog(@"%p", [Reachability class]);
    
    // This will call the swizzled function above: test_currentReachabilityStatusDisconnected
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    
    XCTAssertTrue(networkStatus == NotReachable, @"The status was not swizzled");
    
    SingletonObjectA *shared = [SingletonObjectA sharedSingletonObjectA];
    
    //
    // Step into the function here and see that the swizzled Reachability is not called correctly.
    // It is calling the original function pointer... 
    //
    [shared checkAmOnline];
    //
    //
    //
    
    [SwizzleManager swizzleOffDisconnected];
}


@end
