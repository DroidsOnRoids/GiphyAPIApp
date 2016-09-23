
//
//  JSONValidator.swift
//  GiphyApiApp
//
//  Created by Pawel Chmiel on 13.09.2016.
//  Copyright © 2016 Pawel Chmiel. All rights reserved.
//

import XCTest
@testable import GiphyApiApp

class JSONValidatorTests: XCTestCase {
    
    var jsonData: Data?
    
    override func setUp() {
        super.setUp()
        let bundle = Bundle(for: self.classForCoder)
        jsonData = try? Data(contentsOf: URL(fileURLWithPath: bundle.path(forResource: "sampleData", ofType: "json", inDirectory: nil)!))
    }
    
    func testParseNotValidJSON() {
        jsonData = "empty data".data(using: .utf8)
        if let jsonData = jsonData, let _ = try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [String: AnyObject] {
            XCTFail()
        }
    }
    
    func testParseValidJSON() {
        do {
            try JSONSerialization.jsonObject(with: jsonData!, options: .allowFragments)
        } catch {
            XCTFail()
        }
    }
    
    func testParseValidJSONintoGIF() {
        if let jsonData = jsonData, let result = try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [String: AnyObject] {
            if let dataValues = result?["data"] as? [AnyObject] {
                let gifs = dataValues.map { Gif(json: $0 as? [String : AnyObject]) }
                XCTAssert(gifs.count > 0, "Cannot validate JSON")
            }
        } else {
            XCTFail()
        }
        
    }
    
    func testParseJSONandVerifyGifsId() {
        if let jsonData = jsonData, let result = try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [String: AnyObject], let dataValues = result?["data"] as? [AnyObject] {
            let gifs = dataValues.map { Gif(json: $0 as? [String : AnyObject]) }
            XCTAssert(gifs.first?.id == "l0HlwcAl6VpzCbrG0", "Cannot validate JSON")
        } else {
            XCTFail()
        }
    }
    
    func testParsePartialyBrokenJSON() {
        jsonData = "{\"data\":[{}]}".data(using: .utf8)
        if let jsonData = jsonData, let result = try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [String: AnyObject], let dataValues = result?["data"] as? [AnyObject] {
            let gifs = dataValues.map { Gif(json: $0 as? [String : AnyObject]) }
            XCTAssertNil(gifs.first?.id, "Cannot validate JSON")
        } else {
                XCTFail()
        }
    }
}
