//
//  DeviceCheckerTests.swift
//  DeviceCheckerTests
//
//  Created by KraferdMBP31 on 6/24/16.
//  Copyright © 2016 Kraferd. All rights reserved.
//

import XCTest
@testable import DeviceChecker

class DeviceCheckerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            let expectation = self.expectationWithDescription("Complete request");
            
            let checker = DeviceChecker(url: NSURL(string: "http://example.org/")!, deviceID: "123", appID: "456", testing: true);
            
            checker.mainTask(nil, completion: {() -> Void in
                expectation.fulfill();
            })
            
            self.waitForExpectationsWithTimeout(5.0, handler: {(error) -> Void in
                if let error = error {
                    print(error);
                }
            })
        }
    }
    
}
