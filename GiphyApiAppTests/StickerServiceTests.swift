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
        let baseURLFromAPiConstants = NSURL(string:APIConstants.baseURL)!
        XCTAssertEqual(baseURLFromAPiConstants, StickerService.StickerSearch(key: "key").baseURL)
    }
    
    
}
//MARK: - Path For Service
extension StickerServiceTests {
    
    func testPathForSearching() {
        XCTAssertEqual(("https://api.giphy.com/v1/stickers/search"), StickerService.StickerSearch(key: "key").baseURL.absoluteString + StickerService.StickerSearch(key: "key").path)
    }
    
    func testPathForTranslating() {
        XCTAssertEqual(("https://api.giphy.com/v1/stickers/translate"), StickerService.StickerSearch(key: "key").baseURL.absoluteString + StickerService.StrickerTranslate(key: "key").path)
    }
    
    func testPathForTrending() {
        XCTAssertEqual(("https://api.giphy.com/v1/stickers/trending"), StickerService.StickerSearch(key: "key").baseURL.absoluteString + StickerService.StrickerTrending().path)
    }
    
    func testPathForRandom() {
        XCTAssertEqual(("https://api.giphy.com/v1/stickers/random"), StickerService.StickerSearch(key: "key").baseURL.absoluteString + StickerService.StickerRoulette().path)
    }
}

//MARK: - Sample Data
extension StickerServiceTests {
    
    func testSampleDataForSearch() {
        XCTAssertNotEqual(NSData(), StickerService.StickerSearch(key: "dog").sampleData)
    }
}

//MARK: - Testing requests for 5 Trending GIFS
extension StickerServiceTests {
    
    func testStickerSearching() {
        let expectation = expectationWithDescription("request for searching dog's stickers ")
        
        let stickerAPI = StickerAPI()
        stickerAPI.searchForSticker("cats") { (result) in
            print(result)
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
    
    func testStickerTranslate() {
        let expectation = expectationWithDescription("request for dog's stickers translate")
        
        let stickerAPI = StickerAPI()
        stickerAPI.translateSticker("dogs", completion: { (result) in
            print(result)
            if let _ = result.error {
                XCTFail()
            } else {
                let str = 200
                XCTAssertEqual(str, result.value!["meta"]!["status"])
            }
            expectation.fulfill()
        })
        
        waitForExpectationsWithTimeout(10) { error in
            if let error = error  {
                print("error \(error.localizedDescription)")
            }
        }
    }
    
    func testRandomSticker() {
        let expectation1 = expectationWithDescription("request for one random sticker")
        let expectation2 = expectationWithDescription("request for one random sticker")
        
        requestRandomSticker(expectation1)
        requestRandomSticker(expectation2)
        
        waitForExpectationsWithTimeout(10) { error in
            if let error = error  {
                print("error \(error.localizedDescription)")
            }
        }
        print(randomStickers)
        XCTAssertTrue(randomStickers.count > 1)

    }
}

extension StickerServiceTests {
    
    func requestRandomSticker(expectation : XCTestExpectation) {
        let stickerAPI = StickerAPI()
        
        stickerAPI.randomSticker() { (result) in
            print(result)
            if result.error == nil {
                if let stickerId = result.value?["data"]?["id"] as? AnyObject as? String {
                    self.randomStickers.insert(stickerId)
                }
            }
            expectation.fulfill()
        }

    }
}

