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
    case trendingLimitedTo5
    case trendingLimitedTo10
    case trendingLimitedTo25
    case trendingLimited(limit: Int)
}

extension TrendingService: TargetType {
    
    var baseURL: URL {
        return URL(string: APIConstants.baseURL)!
    }
    
    var path: String {
        return "gifs/trending"
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
        case .trendingLimitedTo5:
            return ["api_key" : APIConstants.betaKey, "limit" : 5]
        case .trendingLimitedTo10:
            return ["api_key" : APIConstants.betaKey, "limit" : 10]
        case .trendingLimitedTo25:
            return ["api_key" : APIConstants.betaKey, "limit" : 25]
        case .trendingLimited(let limit):
            return ["api_key" : APIConstants.betaKey, "limit" : limit]
        }
    }
    
    var task: Task {
        return Task.request
    }
}

struct TrendingAPI {
 
    static func request5TrendingGifs(_ completion: @escaping (Result<[String: AnyObject], Moya.Error>) -> ()) {
        _ = API.trendingService.request(.trendingLimitedTo5) { result in
            switch result {
            case .success(let result):
                do {
                    if let json = try result.mapJSON() as? [String: AnyObject] {
                        completion(.success(json))
                    }
                } catch {
                    completion(.failure(.jsonMapping(result)))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    static func request10TrendingGifs(_ completion: @escaping (Result<[String: AnyObject], Moya.Error>) -> ()) {
        _ = API.trendingService.request(.trendingLimitedTo10) { result in
            switch result {
            case .success(let result):
                do {
                    if let json = try result.mapJSON() as? [String: AnyObject] {
                        completion(.success(json))
                    }
                } catch {
                    completion(.failure(.jsonMapping(result)))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    static func request25TrendingGifs(_ completion: @escaping (Result<[String: AnyObject], Moya.Error>) -> ()) {
        _ = API.trendingService.request(.trendingLimitedTo25) { result in
            switch result {
            case .success(let result):
                do {
                    if let json = try result.mapJSON() as? [String: AnyObject] {
                        completion(.success(json))
                    }
                } catch {
                    completion(.failure(.jsonMapping(result)))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    static func requestLimitedTrendinGifs(_ limit: Int, completion: @escaping (Result<[String: AnyObject], Moya.Error>) -> ()) {
        _ = API.trendingService.request(.trendingLimited(limit: limit)) { result in
            switch result {
            case .success(let result):
                do {
                    if let json = try result.mapJSON() as? [String: AnyObject] {
                        completion(.success(json))
                    }
                } catch {
                    completion(.failure(.jsonMapping(result)))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
 }
