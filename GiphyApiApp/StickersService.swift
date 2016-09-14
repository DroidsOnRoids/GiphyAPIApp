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
    case stickerRoulette()
    case strickerTrending()
    case strickerTranslate(key: String)
}

extension StickerService: TargetType {
    
    var baseURL: URL {
        return URL(string: APIConstants.baseURL)!
    }
    
    var path : String {
        switch self {
        case .stickerSearch(_):
            return "stickers/search"
        case .stickerRoulette():
            return "stickers/random"
        case .strickerTrending():
            return "stickers/trending"
        case .strickerTranslate(_):
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
            return ["q" : key as AnyObject, "api_key" : APIConstants.betaKey as AnyObject]
        case .strickerTranslate(let key):
            return ["s" : key as AnyObject, "api_key" : APIConstants.betaKey as AnyObject]
        default:
            return ["api_key" : APIConstants.betaKey as AnyObject]
        }
    }
    
    var task: Task {
        return Task.request
    }
}

struct StickerAPI {
    
    func searchForSticker(_ searchingKey: String, completion: @escaping (Result<[String: AnyObject], Moya.Error>) -> ()) {
       _ = API.stickerService.request(.stickerSearch(key: searchingKey)) { (result) in
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
   
    func translateSticker(_ searchingKey: String, completion: @escaping (Result<[String: AnyObject], Moya.Error>) -> ()) {
        _ = API.stickerService.request(.strickerTranslate(key: searchingKey)) { (result) in
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
    
    func randomSticker( _ completion: @escaping (Result<[String: AnyObject], Moya.Error>) -> ()) {
       _ = API.stickerService.request(.stickerRoulette()) { (result) in
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
   
    func trendingSticker( _ completion: @escaping (Result<[String: AnyObject], Moya.Error>) -> ()) {
       _ = API.stickerService.request(.strickerTrending()) { (result) in
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
