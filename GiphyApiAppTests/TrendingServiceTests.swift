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
        let baseURLFromAPiConstants = URL(string:APIConstants.baseURL)!
        XCTAssertEqual(baseURLFromAPiConstants, TrendingService.trendingLimitedTo5.baseURL)
    }
    
    func testUrlBaseForLimitedTop10() {
        let baseURLFromAPiConstants = URL(string:APIConstants.baseURL)!
        XCTAssertEqual(baseURLFromAPiConstants, TrendingService.trendingLimitedTo10.baseURL)
    }
    
    func testUrlBaseForLimitedTop25() {
        let baseURLFromAPiConstants = URL(string:APIConstants.baseURL)!
        XCTAssertEqual(baseURLFromAPiConstants, TrendingService.trendingLimitedTo25.baseURL)
    }
    
}
//MARK: - Path For Service
extension TrendingServiceTests {
    
    func testPathForTrending() {
        XCTAssertEqual(("https://api.giphy.com/v1/gifs/trending"), TrendingService.trendingLimitedTo5.baseURL.absoluteString + TrendingService.trendingLimitedTo5.path)
    }
    
}

//MARK: - Parameters
extension TrendingServiceTests {
    
    func testParametersForTop5() {
        let parameters = ["api_key": APIConstants.betaKey , "limit": 5] as [String : Any]
        let p = TrendingService.trendingLimitedTo5.parameters
        XCTAssertEqual(parameters as NSDictionary , p! as NSDictionary)
    }
    
    
    func testParametersForTop10() {
        let parameters = ["api_key": APIConstants.betaKey, "limit": 10] as [String : Any]
        XCTAssertEqual(parameters as NSDictionary, TrendingService.trendingLimitedTo10.parameters! as NSDictionary)
    }
    
    func testParametersForTop25() {
        let parameters = ["api_key": APIConstants.betaKey, "limit": 25] as [String : Any]
        XCTAssertEqual(parameters as NSDictionary, TrendingService.trendingLimitedTo25.parameters! as NSDictionary)
    }
}

//MARK: - Sample Data
extension TrendingServiceTests {
    
    func testSampleDataForTop5() {
        XCTAssertNotEqual(Data(), TrendingService.trendingLimitedTo5.sampleData)
    }
    
    func testSampleDataForTop10() {
        XCTAssertNotEqual(Data(), TrendingService.trendingLimitedTo10.sampleData)
    }
    
    func testSampleDataForTop25() {
        XCTAssertNotEqual(Data(), TrendingService.trendingLimitedTo25.sampleData)
    }
}

//MARK: - Testing requests for 5 Trending GIFS
extension TrendingServiceTests {
    
    func testCall5TrendingGifs() {
        let expectation = self.expectation(description: "call request for 5 trending Gifs")
        
        let trendingAPI = TrendingAPI()
        var response : Result<[String : AnyObject], Moya.Error>?
        
        trendingAPI.request5TrendingGifs { result in
            response = result
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            let status = 200
            XCTAssertEqual(status, response?.value!["meta"]!["status"]! as AnyObject as? Int)
        }
    }
    
    func testStatus200() {
        let expectation = self.expectation(description: "Check result of request for 5 trending Gifs")
        
        let trendingAPI = TrendingAPI()
        var response : Result<[String : AnyObject], Moya.Error>?
        
        trendingAPI.request5TrendingGifs { result in
            response = result
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            let status = 200
            XCTAssertEqual(status, response?.value!["meta"]!["status"]! as AnyObject as? Int)
        }
    }
    
    func testZReadFromStubFor5() {
        let expectation = self.expectation(description: "Read stub from disk")
        
        API.stubbing = true
        let trendingAPI = TrendingAPI()
        var response : Result<[String : AnyObject], Moya.Error>?
        
        trendingAPI.request5TrendingGifs { result in
            response = result
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            let status = 200
            XCTAssertEqual(status, response?.value!["meta"]!["status"] as AnyObject as? Int)
        }
        
    }
}

//MARK: - Testing requests for 10 Trending GIFS
extension TrendingServiceTests {
    
    //TEST FOR 10
    
    func testCall10TrendingGifs() {
        let expectation = self.expectation(description: "call request for 5 trending Gifs")
        
        let trendingAPI = TrendingAPI()
        var response : Result<[String : AnyObject], Moya.Error>?
        
        trendingAPI.request10TrendingGifs { result in
            response = result
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            if let _ = response?.error {
                XCTFail()
            }
        }
    }
    
    func testStatus200For10() {
        let expectation = self.expectation(description: "Check result of request for 5 trending Gifs")
        
        let trendingAPI = TrendingAPI()
        var response : Result<[String : AnyObject], Moya.Error>?
        
        trendingAPI.request10TrendingGifs { result in
            response = result
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            let status = 200
            XCTAssertEqual(status, response?.value!["meta"]!["status"] as AnyObject as? Int)
            
        }
    }
    
    func testReadFromStubFor10() {
        let expectation = self.expectation(description: "Read empty stub from disk")
        
        API.stubbing = true
        let trendingAPI = TrendingAPI()
        var response : Result<[String : AnyObject], Moya.Error>?
        
        trendingAPI.request10TrendingGifs { result in
            response = result
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            let status = 200
            XCTAssertEqual(status, response?.value!["meta"]!["status"] as AnyObject as? Int)
        }
        
    }
}

//MARK: - Testing requests for 25 Trending GIFS
extension TrendingServiceTests {
    
    func testCall25TrendingGifs() {
        let expectation = self.expectation(description: "call request for 5 trending Gifs")
        
        let trendingAPI = TrendingAPI()
        var response : Result<[String : AnyObject], Moya.Error>?
        
        trendingAPI.request25TrendingGifs { result in
            response = result
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            if let _ = response?.error {
                XCTFail()
            }
        }
    }
    
    func testStatus200For25() {
        let expectation = self.expectation(description: "Check result of request for 5 trending Gifs")
        
        let trendingAPI = TrendingAPI()
        var response : Result<[String : AnyObject], Moya.Error>?
        
        trendingAPI.request25TrendingGifs { result in
            response = result
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            let status = 200
            XCTAssertEqual(status, response?.value!["meta"]!["status"] as AnyObject as? Int)
        }
    }
    
    func testReadFromStubFor25() {
        let expectation = self.expectation(description: "Read cleaned stub from disk")
        
        API.stubbing = true
        let trendingAPI = TrendingAPI()
        var response : Result<[String : AnyObject], Moya.Error>?
        
        trendingAPI.request25TrendingGifs { result in
            response = result
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            let status = 200
            XCTAssertEqual(status, response?.value!["meta"]!["status"] as AnyObject as? Int)
        }
    }
    
}

// Limit provided by user
extension TrendingServiceTests {
    
    func testRequestLimitedTrendingGifs() {
        let expectation = self.expectation(description: "request for 12 trending Gifs")
        
        let trendingAPI = TrendingAPI()
        var response : Result<[String : AnyObject], Moya.Error>?
        
        trendingAPI.requestLimitedTrendinGifs(12) { result in
            response = result
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            XCTAssertEqual(12, response?.value!["pagination"]!["count"] as AnyObject as? Int)
        }
        
    }
}
