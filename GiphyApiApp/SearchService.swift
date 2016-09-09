//
//  SearchService.swift
//  GiphyApiApp
//
//  Created by Pawel Chmiel on 20.07.2016.
//  Copyright © 2016 Pawel Chmiel. All rights reserved.
//

import Foundation
import Moya
import Result


enum SearchService {
    case SearchGiphy(key: String)
    case SearchGiphyWithLimit(key: String, limit: Int)
}

extension SearchService: TargetType {
    
    var baseURL: NSURL {
        return NSURL(string: APIConstants.baseURL)!
    }
    
    var path : String {
        return "gifs/search"
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
        case .SearchGiphy(let key):
            return ["api_key" : APIConstants.betaKey, "q" : key]
        case .SearchGiphyWithLimit(let key, let limit):
            return ["api_key" : APIConstants.betaKey, "q" : key, "limit" : limit]
        }
    }
    
    var multipartBody: [MultipartFormData]? {
        return nil
    }
}

struct SearchAPI {

    func searchForKey(searchingKey: String, completion: Result<[String: AnyObject], Error> -> ()) {
        API.searchingService.request(.SearchGiphy(key: searchingKey)) { (result) in
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
   
    func searchForKeyWithLimit(searchingKey: String, limit: Int, completion: Result<[String: AnyObject], Error> -> ()) {
        API.searchingService.request(.SearchGiphyWithLimit(key: searchingKey, limit: limit)) { (result) in
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
