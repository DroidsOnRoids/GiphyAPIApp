//
//  TrendingService.swift
//  GiphyApiApp
//
//  Created by Pawel Chmiel on 20.07.2016.
//  Copyright © 2016 Pawel Chmiel. All rights reserved.
//

import Foundation
import Moya
import Result

enum TrendingService {
    case TrendingLimitedTo5
    case TrendingLimitedTo10
    case TrendingLimitedTo25
    case TrendingLimited(limit: Int)
}

extension TrendingService: TargetType {
    
    var baseURL: NSURL {
        return NSURL(string: APIConstants.baseURL)!
    }
    
    var path : String {
        return "gifs/trending"
    }
    
    var method: Moya.Method {
        return .GET
    }
    
    var stubStatusCode: String {
        return "200"
    }
    
    var sampleData: NSData {
        guard let stubFile = stubFileName(forStatusCode: stubStatusCode),
            data = NSData(contentsOfFile: stubFile) else { return NSData() }
        
        return data
    }
    
    var parameters: [String: AnyObject]? {
        switch self {
        case .TrendingLimitedTo5:
            return ["api_key" : APIConstants.betaKey, "limit" : 5]
        case .TrendingLimitedTo10:
            return ["api_key" : APIConstants.betaKey, "limit" : 10]
        case .TrendingLimitedTo25:
            return ["api_key" : APIConstants.betaKey, "limit" : 25]
        case .TrendingLimited(let limit):
            return ["api_key" : APIConstants.betaKey, "limit" : limit]
        }
    }
    
    var multipartBody: [MultipartFormData]? {
        return nil
    }
}

struct TrendingAPI {
 
    func request5TrendingGifs(completion: Result<[String: AnyObject], Error> -> ()) {
        API.trendingService.request(.TrendingLimitedTo5) { (result) in
            switch result {
            case let .Success(result):
                do {
                    let json: [String: AnyObject]? = try result.mapJSON() as? [String: AnyObject]
                    if let json = json {
                        completion(.Success(json))
                    }
                } catch {
                    completion(.Failure(Error.JSONMapping(result)))
                }
            case let .Failure(error):
                completion(.Failure(error))
            }
        }
    }
    
    func request10TrendingGifs(completion: Result<[String: AnyObject], Error> -> ()) {
        API.trendingService.request(.TrendingLimitedTo10) { (result) in
            switch result {
            case let .Success(result):
                do {
                    let json: [String: AnyObject]? = try result.mapJSON() as? [String: AnyObject]
                    if let json = json {
                        completion(.Success(json))
                    }
                } catch {
                    completion(.Failure(Error.JSONMapping(result)))
                }
            case let .Failure(error):
                completion(.Failure(error))
            }
        }
    }
    
    func request25TrendingGifs(completion: Result<[String: AnyObject], Error> -> ()) {
        API.trendingService.request(.TrendingLimitedTo25) { (result) in
            switch result {
            case let .Success(result):
                do {
                    let json: [String: AnyObject]? = try result.mapJSON() as? [String: AnyObject]
                    if let json = json {
                        completion(.Success(json))
                    }
                } catch {
                    completion(.Failure(Error.JSONMapping(result)))
                }
            case let .Failure(error):
                completion(.Failure(error))
            }
        }
    }
    
    func requestLimitedTrendinGifs(limit: Int, completion: Result<[String: AnyObject], Error> -> ()) {
        API.trendingService.request(.TrendingLimited(limit: limit)) { (result) in
            switch result {
            case let .Success(result):
                do {
                    let json: [String: AnyObject]? = try result.mapJSON() as? [String: AnyObject]
                    if let json = json {
                        completion(.Success(json))
                    }
                } catch {
                    completion(.Failure(Error.JSONMapping(result)))
                }
            case let .Failure(error):
                completion(.Failure(error))
            }
        }
    }

 }
