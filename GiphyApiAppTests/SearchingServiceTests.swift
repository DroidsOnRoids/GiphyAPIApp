//
//  SearchingServiceTests.swift
//  GiphyApiApp
//
//  Created by Pawel Chmiel on 07.09.2016.
//  Copyright © 2016 Pawel Chmiel. All rights reserved.
//

import Foundation
import XCTest
import Moya
import Result
@testable import GiphyApiApp

class SearchingServiceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        API.stubbing = false
    }
}

// MARK: - Url Base
extension SearchingServiceTests {
    
    func testUrlBaseForLimitedTop5() {
        let baseURLFromAPiConstants = URL(string:APIConstants.baseURL)!
        XCTAssertEqual(baseURLFromAPiConstants, SearchService.searchGiphy(key: "").baseURL)
    }
}

// MARK: - Path For Service
extension SearchingServiceTests {
    
    func testPathForTrending() {
        XCTAssertEqual(("https://api.giphy.com/v1/gifs/search"), SearchService.searchGiphy(key: "key").baseURL.absoluteString + SearchService.searchGiphy(key: "key").path)
    }
}

// MARK: - Sample Data
extension SearchingServiceTests {
    
    func testSampleDataForSearch() {
        API.stubbing = true
        XCTAssertNotEqual(Data(), SearchService.searchGiphy(key: "dog").sampleData)
    }
}

// MARK: - Testing requests for 5 Trending GIFS
extension SearchingServiceTests {
    
    func testSearching() {
        let expectation = self.expectation(description: "request for searching dog's gifs")
        var response: Result<[String : AnyObject], Moya.Error>?
        
        SearchAPI.searchForKey("dogs") { result in
            response = result
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { _ in
            let status = 200
            XCTAssertEqual(status, response?.value?["meta"]?["status"] as Any as? Int)
            XCTAssertNotEqual(0, response?.value?["pagination"]?["count"] as Any as? Int)
        }
    }
    
    func testCallSearchingWithLimit() {
        let expectation = self.expectation(description: "call request for searching dogs gifs")
        
        let limitCount = 5
        var response: Result<[String : AnyObject], Moya.Error>?
        
        SearchAPI.searchForKeyWithLimit("dogs", limit: limitCount) { result in
            response = result
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { _ in
            let status = 200
            XCTAssertEqual(status, response?.value?["meta"]?["status"] as Any as? Int)
            XCTAssertEqual(limitCount, response?.value?["pagination"]?["count"] as Any as? Int)
        }
    }
}

