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
    case searchGiphy(key: String)
    case searchGiphyWithLimit(key: String, limit: Int)
}

extension SearchService: TargetType {
    
    var baseURL: URL {
        return URL(string: APIConstants.baseURL)!
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
    
    var sampleData: Data {
        guard let stubFile = stubFileName(forStatusCode: stubStatusCode), let data = try? Data(contentsOf: URL(fileURLWithPath: stubFile)) else { return Data() }
     
        return data
    }

    var parameters: [String: Any]? {
        switch self {
        case .searchGiphy(let key):
            return ["api_key" : APIConstants.betaKey as AnyObject, "q" : key as AnyObject]
        case .searchGiphyWithLimit(let key, let limit):
            return ["api_key" : APIConstants.betaKey as AnyObject, "q" : key as AnyObject, "limit" : limit as AnyObject]
        }
    }
    
    var task : Task{
        return Task.request
    }
}

struct SearchAPI {

    func searchForKey(_ searchingKey: String, completion: @escaping (Result<[String: AnyObject], Moya.Error>) -> ()) {
        _ = API.searchingService.request(.searchGiphy(key: searchingKey)) { (result) in
            switch result {
            case let .success(result):
                do {
                    let json: [String: AnyObject]? = try result.mapJSON() as? [String: AnyObject]
                    if let json = json {
                        completion(.success(json))
                    }
                } catch {
                    completion(.failure(Moya.Error.jsonMapping(result)))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
   
    func searchForKeyWithLimit(_ searchingKey: String, limit: Int,  completion: @escaping (Result<[String: AnyObject], Moya.Error>) -> ()) {
       _ = API.searchingService.request(.searchGiphyWithLimit(key: searchingKey, limit: limit)) { (result) in
            switch result {
            case let .success(result):
                do {
                    let json: [String: AnyObject]? = try result.mapJSON() as? [String: AnyObject]
                    if let json = json {
                        completion(.success(json))
                    }
                } catch {
                    completion(.failure(Error.jsonMapping(result)))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    
}
