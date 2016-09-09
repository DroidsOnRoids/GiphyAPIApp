//
//  TrendingServiceTests.swift
//  GiphyApiApp
//
//  Created by Pawel Chmiel on 20.07.2016.
//  Copyright © 2016 Pawel Chmiel. All rights reserved.
//

import Foundation
import XCTest
import Moya
import Result
@testable import GiphyApiApp

class TrendingServiceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
}
//MARK: - Url Base
extension TrendingServiceTests {

    func testUrlBaseForLimitedTop5() {
        let baseURLFromAPiConstants = NSURL(string:APIConstants.baseURL)!
        XCTAssertEqual(baseURLFromAPiConstants, TrendingService.TrendingLimitedTo5.baseURL)
    }
    
    func testUrlBaseForLimitedTop10() {
        let baseURLFromAPiConstants = NSURL(string:APIConstants.baseURL)!
        XCTAssertEqual(baseURLFromAPiConstants, TrendingService.TrendingLimitedTo10.baseURL)
    }
    
    func testUrlBaseForLimitedTop25() {
        let baseURLFromAPiConstants = NSURL(string:APIConstants.baseURL)!
        XCTAssertEqual(baseURLFromAPiConstants, TrendingService.TrendingLimitedTo25.baseURL)
    }
    
}
//MARK: - Path For Service
extension TrendingServiceTests {
   
    func testPathForTrending() {
        XCTAssertEqual(("https://api.giphy.com/v1/gifs/trending"), TrendingService.TrendingLimitedTo5.baseURL.absoluteString + TrendingService.TrendingLimitedTo5.path)
    }
   
}

//MARK: - Parameters
extension TrendingServiceTests {
    
    func testParametersForTop5() {
        let parameters = ["api_key": APIConstants.betaKey, "limit": 5]
        XCTAssertEqual(parameters, TrendingService.TrendingLimitedTo5.parameters)
    }
    
    func testParametersForTop10() {
        let parameters = ["api_key": APIConstants.betaKey, "limit": 10]
        XCTAssertEqual(parameters, TrendingService.TrendingLimitedTo10.parameters)
    }

    func testParametersForTop25() {
        let parameters = ["api_key": APIConstants.betaKey, "limit": 25]
        XCTAssertEqual(parameters, TrendingService.TrendingLimitedTo25.parameters)
    }
}

//MARK: - Sample Data
extension TrendingServiceTests {

    func testSampleDataForTop5() {
        XCTAssertNotEqual(NSData(), TrendingService.TrendingLimitedTo5.sampleData)
    }
    
    func testSampleDataForTop10() {
        XCTAssertNotEqual(NSData(), TrendingService.TrendingLimitedTo10.sampleData)
    }
    
    func testSampleDataForTop25() {
        XCTAssertNotEqual(NSData(), TrendingService.TrendingLimitedTo25.sampleData)
    }
}

//MARK: - Testing requests for 5 Trending GIFS
extension TrendingServiceTests {
   
    func testCall5TrendingGifs() {
        let expectation = expectationWithDescription("call request for 5 trending Gifs")

        let trendingAPI = TrendingAPI()
        
        trendingAPI.request5TrendingGifs { result in
            if let _ = result.error {
                XCTFail()
            } else {
                
            }
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(10) { error in
            if let error = error  {
                print("error \(error.localizedDescription)")
            }
        }
    }
    
    func testStatus200() {
        let expectation = expectationWithDescription("Check result of request for 5 trending Gifs")
        
        let trendingAPI = TrendingAPI()
        
        trendingAPI.request5TrendingGifs { result in
            if let _ = result.error {
                XCTFail()
            } else {
                let str = 200
                XCTAssertEqual(str, result.value!["meta"]!["status"])
            }
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(10) { error in
            if let error = error  {
                print("error \(error.localizedDescription)")
            }
        }
    }

    func testZReadFromStubFor5() {
        let expectation = expectationWithDescription("Read stub from disk")
        
        API.stubbing = true
        let trendingAPI = TrendingAPI()
        
        trendingAPI.request5TrendingGifs { result in
            if let _ = result.error {
                XCTFail()
            } else {
                let str = 200
                XCTAssertEqual(str, result.value!["meta"]!["status"])
            }
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(10) { error in
            if let error = error  {
                print("error \(error.localizedDescription)")
            }
        }

    }
}

//MARK: - Testing requests for 10 Trending GIFS
extension TrendingServiceTests {
   
    //TEST FOR 10
    
    func testCall10TrendingGifs() {
        let expectation = expectationWithDescription("call request for 5 trending Gifs")
        
        let trendingAPI = TrendingAPI()
        
        trendingAPI.request10TrendingGifs { result in
            if let _ = result.error {
                XCTFail()
            } else {
                
            }
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(10) { error in
            if let error = error  {
                print("error \(error.localizedDescription)")
            }
        }
    }
    
    func testStatus200For10() {
        let expectation = expectationWithDescription("Check result of request for 5 trending Gifs")
       
        let trendingAPI = TrendingAPI()
        
        trendingAPI.request10TrendingGifs { result in
            if let _ = result.error {
                XCTFail()
            } else {
                let str = 200
                XCTAssertEqual(str, result.value!["meta"]!["status"])
            }
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(10) { error in
            if let error = error  {
                print("error \(error.localizedDescription)")
            }
        }
    }
    
    func testReadFromStubFor10() {
        let expectation = expectationWithDescription("Read empty stub from disk")
       
        API.stubbing = true
        let trendingAPI = TrendingAPI()
        
        trendingAPI.request10TrendingGifs { result in
            if let _ = result.error {
                XCTFail()
            } else {
                let str = 200
                XCTAssertEqual(str, result.value!["meta"]!["status"])
            }
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(10) { error in
            if let error = error  {
                print("error \(error.localizedDescription)")
            }
        }
        
    }
}

//MARK: - Testing requests for 25 Trending GIFS
extension TrendingServiceTests {
    
    func testCall25TrendingGifs() {
        let expectation = expectationWithDescription("call request for 5 trending Gifs")

        let trendingAPI = TrendingAPI()
       
        trendingAPI.request25TrendingGifs { result in
            if let _ = result.error {
                XCTFail()
            } else {
                
            }
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(10) { error in
            if let error = error  {
                print("error \(error.localizedDescription)")
            }
        }
    }
    
    func testStatus200For25() {
        let expectation = expectationWithDescription("Check result of request for 5 trending Gifs")
        
        let trendingAPI = TrendingAPI()
        
        trendingAPI.request25TrendingGifs { result in
            if let _ = result.error {
                XCTFail()
            } else {
                let str = 200
                XCTAssertEqual(str, result.value!["meta"]!["status"])
            }
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(10) { error in
            if let error = error  {
                print("error \(error.localizedDescription)")
            }
        }
    }
    
    func testReadFromStubFor25() {
        let expectation = self.expectationWithDescription("Read cleaned stub from disk")
       
        API.stubbing = true
        let trendingAPI = TrendingAPI()
        
        trendingAPI.request25TrendingGifs { result in
            if let _ = result.error {
                XCTFail()
            } else {
                let str = 200
                XCTAssertEqual(str, result.value!["meta"]!["status"])
            }
            expectation.fulfill()
        }
        
        self.waitForExpectationsWithTimeout(10) { error in
            if let error = error  {
                print("error \(error.localizedDescription)")
            }
        }
    }

}

// Limit provided by user
extension TrendingServiceTests {
    
    func testRequestLimitedTrendingGifs() {
        let expectation = expectationWithDescription("request for 12 trending Gifs")
        
        let trendingAPI = TrendingAPI()
        
        trendingAPI.requestLimitedTrendinGifs(12) { result in
            if let _ = result.error {
                XCTFail()
            } else {
                XCTAssertEqual(12, result.value!["pagination"]!["count"])
            }
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(10) { error in
            if let error = error  {
                print("error \(error.localizedDescription)")
            }
        }

    }
}
