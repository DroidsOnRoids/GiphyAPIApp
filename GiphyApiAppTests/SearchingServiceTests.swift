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
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
}
//MARK: - Url Base
extension SearchingServiceTests {
    
    func testUrlBaseForLimitedTop5() {
        let baseURLFromAPiConstants = URL(string:APIConstants.baseURL)!
        XCTAssertEqual(baseURLFromAPiConstants, SearchService.searchGiphy(key: "").baseURL)
    }
    
    
}
//MARK: - Path For Service
extension SearchingServiceTests {
    
    func testPathForTrending() {
        XCTAssertEqual(("https://api.giphy.com/v1/gifs/search"), SearchService.searchGiphy(key: "key").baseURL.absoluteString + SearchService.searchGiphy(key: "key").path)
    }
    
}

//MARK: - Sample Data
extension SearchingServiceTests {
    
    func testSampleDataForSearch() {
        API.stubbing = true
        XCTAssertNotEqual(Data(), SearchService.searchGiphy(key: "dog").sampleData)
    }
}

//MARK: - Testing requests for 5 Trending GIFS
extension SearchingServiceTests {
    
    func testSearching() {
        let expectation = self.expectation(description: "request for searching dog's gifs")
        
        let searchAPI = SearchAPI()
        var response : Result<[String : AnyObject], Moya.Error>?
        
        searchAPI.searchForKey("dogs") { (result) in
            response = result
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            let status = 200
            XCTAssertEqual(status, response?.value!["meta"]!["status"] as AnyObject as? Int)
            XCTAssertNotEqual(0, response?.value!["pagination"]!["count"] as AnyObject as? Int)
        }
    }
    
    func testCallSearchingWithLimit() {
        let expectation = self.expectation(description: "call request for searching dogs gifs")
        
        let searchAPI = SearchAPI()
        let limitCount = 5
        var response : Result<[String : AnyObject], Moya.Error>?
        
        searchAPI.searchForKeyWithLimit("dogs", limit: limitCount, completion: { (result) in
            response = result
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 10) { error in
            let status = 200
            XCTAssertEqual(status, response?.value!["meta"]!["status"] as AnyObject as? Int)
            XCTAssertEqual(limitCount, response?.value!["pagination"]!["count"] as AnyObject as? Int)
        }
    }
}

