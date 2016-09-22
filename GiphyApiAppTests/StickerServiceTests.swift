//
//  StickerServiceTests.swift
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

class StickerServiceTests: XCTestCase {
    
    var randomStickers: Set<String> = Set<String>()
    
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
extension StickerServiceTests {
    
    func testUrlBaseForStrickerServiceSerach() {
        let baseURLFromAPiConstants = URL(string:APIConstants.baseURL)!
        XCTAssertEqual(baseURLFromAPiConstants, StickerService.stickerSearch(key: "key").baseURL)
    }
    
    
}
//MARK: - Path For Service
extension StickerServiceTests {
    
    func testPathForSearching() {
        XCTAssertEqual(("https://api.giphy.com/v1/stickers/search"), StickerService.stickerSearch(key: "key").baseURL.absoluteString + StickerService.stickerSearch(key: "key").path)
    }
    
    func testPathForTranslating() {
        XCTAssertEqual(("https://api.giphy.com/v1/stickers/translate"), StickerService.stickerSearch(key: "key").baseURL.absoluteString + StickerService.strickerTranslate(key: "key").path)
    }
    
    func testPathForTrending() {
        XCTAssertEqual(("https://api.giphy.com/v1/stickers/trending"), StickerService.stickerSearch(key: "key").baseURL.absoluteString + StickerService.strickerTrending.path)
    }
    
    func testPathForRandom() {
        XCTAssertEqual(("https://api.giphy.com/v1/stickers/random"), StickerService.stickerSearch(key: "key").baseURL.absoluteString + StickerService.stickerRoulette.path)
    }
}

//MARK: - Sample Data
extension StickerServiceTests {
    
    func testSampleDataForSearch() {
        XCTAssertNotEqual(Data(), StickerService.stickerSearch(key: "dog").sampleData)
    }
}

//MARK: - Testing requests for 5 Trending GIFS
extension StickerServiceTests {
    
    func testStickerSearching() {
        let expectation = self.expectation(description: "request for searching dog's stickers ")
        
        let stickerAPI = StickerAPI()
        var response : Result<[String : AnyObject], Moya.Error>?
        
        
        stickerAPI.searchForSticker("cats") { (result) in
            response = result
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { _ in
            let status = 200
            XCTAssertEqual(status, response?.value!["meta"]!["status"] as AnyObject as? Int)
        }
    }
    
    func testStickerTranslate() {
        let expectation = self.expectation(description: "request for dog's stickers translate")
        
        let stickerAPI = StickerAPI()
        var response : Result<[String : AnyObject], Moya.Error>?
        
        stickerAPI.translateSticker("dogs", completion: { (result) in
            response = result
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 10) { _ in
            let status = 200
            XCTAssertEqual(status, response?.value!["meta"]!["status"] as AnyObject as? Int)
        }
    }
    
    func testRandomSticker() {
        let expectation1 = expectation(description: "request for one random sticker")
        let expectation2 = expectation(description: "request for one random sticker")
        
        requestRandomSticker(expectation1)
        requestRandomSticker(expectation2)
        
        waitForExpectations(timeout: 10) { error in
            if let error = error  {
                print("error \(error.localizedDescription)")
            }
        }
        print(randomStickers)
        XCTAssertTrue(randomStickers.count > 1)
        
    }
}

extension StickerServiceTests {
    
    func requestRandomSticker(_ expectation : XCTestExpectation) {
        let stickerAPI = StickerAPI()
        
        stickerAPI.randomSticker() { (result) in
            print(result)
            if result.error == nil {
                if let stickerId = result.value?["data"]?["id"] as AnyObject as? String {
                    self.randomStickers.insert(stickerId)
                }
            }
            expectation.fulfill()
        }
        
    }
}

