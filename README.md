# XCTestSwizzleSample
This is a sample project to use for showing the swizzle not being called in a Pod implementation of a class.

You may need to run a pod install before running the test

Run this code by opening the swizzleXCTestCase.xcworkspace file and then using cmd+U to test it.

Check the comments in testIsDisconnected that show what is happening incorrectly with the Reachability object when the selector currentReachabilityStatus is swizzled.
