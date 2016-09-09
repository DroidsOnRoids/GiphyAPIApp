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
    case StickerSearch(key: String)
    case StickerRoulette()
    case StrickerTrending()
    case StrickerTranslate(key: String)
}

extension StickerService: TargetType {
    
    var baseURL: NSURL {
        return NSURL(string: APIConstants.baseURL)!
    }
    
    var path : String {
        switch self {
        case .StickerSearch(_):
            return "stickers/search"
        case .StickerRoulette():
            return "stickers/random"
        case .StrickerTrending():
            return "stickers/trending"
        case .StrickerTranslate(_):
            return "stickers/translate"
        }
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
        case .StickerSearch(let key):
            return ["q" : key, "api_key" : APIConstants.betaKey]
        case .StrickerTranslate(let key):
            return ["s" : key, "api_key" : APIConstants.betaKey]
        default:
            return ["api_key" : APIConstants.betaKey]
        }
    }
    
    var multipartBody: [MultipartFormData]? {
        return nil
    }
}

struct StickerAPI {
    
    func searchForSticker(searchingKey: String, completion: Result<[String: AnyObject], Error> -> ()) {
        API.stickerService.request(.StickerSearch(key: searchingKey)) { (result) in
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
   
    func translateSticker(searchingKey: String, completion: Result<[String: AnyObject], Error> -> ()) {
        API.stickerService.request(.StrickerTranslate(key: searchingKey)) { (result) in
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
    
    func randomSticker( completion: Result<[String: AnyObject], Error> -> ()) {
        API.stickerService.request(.StickerRoulette()) { (result) in
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
   
    func trendingSticker( completion: Result<[String: AnyObject], Error> -> ()) {
        API.stickerService.request(.StrickerTrending()) { (result) in
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
