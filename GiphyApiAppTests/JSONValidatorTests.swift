
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
    
    var jsonData : NSData?
 
    override func setUp() {
        super.setUp()
        let bundle = NSBundle(forClass: self.classForCoder)
        jsonData = NSData(contentsOfFile: bundle.pathForResource("sampleData", ofType: "json", inDirectory: nil)!)
    }
    

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testParseNotValidJSON() {
        
        jsonData = "empty data".dataUsingEncoding(NSUTF8StringEncoding)
        if let jsonData = jsonData, let _ = try? NSJSONSerialization.JSONObjectWithData(jsonData, options: .AllowFragments) as? [String: AnyObject] {
            XCTFail()
            
        }
    }
    
    func testParseValidJSON() {
        do {
         try NSJSONSerialization.JSONObjectWithData(jsonData!, options: .AllowFragments) as? [String: AnyObject]
        } catch {
            XCTFail()
        }
    }
    
    func testParseValidJSONintoGIF() {
        var gifs = [Gif]()
        
        if let jsonData = jsonData, let result = try? NSJSONSerialization.JSONObjectWithData(jsonData, options: .AllowFragments) as? [String: AnyObject]{
          
            if let dataValues = result!["data"] as? [AnyObject] {
                for jsonObject in dataValues {
                    let gif = Gif(json: jsonObject as? [String : AnyObject])
                    gifs.append(gif)
                }
            }
            
            XCTAssert(gifs.count > 0, "Cannot validate JSON")
            
        } else {
            XCTFail()
        }

    }
    
    func testParseJSONandVerifyGifsId() {
        var gifs = [Gif]()
        
        if let jsonData = jsonData, let result = try? NSJSONSerialization.JSONObjectWithData(jsonData, options: .AllowFragments) as? [String: AnyObject]{
            
            if let dataValues = result!["data"] as? [AnyObject] {
                for jsonObject in dataValues {
                    let gif = Gif(json: jsonObject as? [String : AnyObject])
                    gifs.append(gif)
                }
            }
          XCTAssert(gifs.first?.id == "l0HlwcAl6VpzCbrG0", "Cannot validate JSON")
         
            
        } else {
            XCTFail()
        }
        
    }
    
    func testParsePartialyBrokenJSON() {
        var gifs = [Gif]()
        
        jsonData = "{\"data\":[{}]}".dataUsingEncoding(NSUTF8StringEncoding)
        if let jsonData = jsonData, let result = try? NSJSONSerialization.JSONObjectWithData(jsonData, options: .AllowFragments) as? [String: AnyObject]{
            
            if let dataValues = result!["data"] as? [AnyObject] {
                for jsonObject in dataValues {
                    let gif = Gif(json: jsonObject as? [String : AnyObject])
                    gifs.append(gif)
                }
            } else {
                XCTFail()
            }
            
            XCTAssert(gifs.first?.id == nil, "Cannot validate JSON")
        }
        
    }
}
