//
//  StickersService.swift
//  GiphyApiApp
//
//  Created by Pawel Chmiel on 20.07.2016.
//  Copyright © 2016 Pawel Chmiel. All rights reserved.
//

import Foundation
import Moya
import Result

enum StickerService {
    case stickerSearch(key: String)
    case stickerRoulette
    case strickerTrending
    case strickerTranslate(key: String)
}

extension StickerService: TargetType {
    
    var baseURL: URL {
        return URL(string: APIConstants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .stickerSearch:
            return "stickers/search"
        case .stickerRoulette:
            return "stickers/random"
        case .strickerTrending:
            return "stickers/trending"
        case .strickerTranslate:
            return "stickers/translate"
        }
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
        case .stickerSearch(let key):
            return ["q" : key, "api_key" : APIConstants.betaKey]
        case .strickerTranslate(let key):
            return ["s" : key, "api_key" : APIConstants.betaKey]
        default:
            return ["api_key" : APIConstants.betaKey]
        }
    }
    
    var task: Task {
        return Task.request
    }
}

struct StickerAPI {
    
    static func searchForSticker(_ searchingKey: String, completion: @escaping (Result<[String: AnyObject], Moya.Error>) -> ()) {
       _ = API.stickerService.request(.stickerSearch(key: searchingKey)) { result in
            switch result {
            case .success(let result):
                do {
                    if let json = try result.mapJSON() as? [String: AnyObject] {
                        completion(.success(json))
                    }
                } catch {
                    completion(.failure(.jsonMapping(result)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
   
    static func translateSticker(_ searchingKey: String, completion: @escaping (Result<[String: AnyObject], Moya.Error>) -> ()) {
        _ = API.stickerService.request(.strickerTranslate(key: searchingKey)) { result in
            switch result {
            case .success(let result):
                do {
                    if let json = try result.mapJSON() as? [String: AnyObject]  {
                        completion(.success(json))
                    }
                } catch {
                    completion(.failure(.jsonMapping(result)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    static func randomSticker(_ completion: @escaping (Result<[String: AnyObject], Moya.Error>) -> ()) {
       _ = API.stickerService.request(.stickerRoulette) { result in
            switch result {
            case .success(let result):
                do {
                    if let json = try result.mapJSON() as? [String: AnyObject] {
                        completion(.success(json))
                    }
                } catch {
                    completion(.failure(.jsonMapping(result)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
   
    static func trendingSticker(_ completion: @escaping (Result<[String: AnyObject], Moya.Error>) -> ()) {
       _ = API.stickerService.request(.strickerTrending) { result in
            switch result {
            case .success(let result):
                do {
                    if let json = try result.mapJSON() as? [String: AnyObject] {
                        completion(.success(json))
                    }
                } catch {
                    completion(.failure(.jsonMapping(result)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
