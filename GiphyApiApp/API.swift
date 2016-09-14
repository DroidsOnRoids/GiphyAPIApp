//
//  API.swift
//  GiphyApiApp
//
//  Created by Pawel Chmiel on 20.07.2016.
//  Copyright © 2016 Pawel Chmiel. All rights reserved.
//

import Foundation
import Moya
import Result

struct API {
    
    static var stubbing = false
    static var disableRecording = false
    
    static var trendingService = API.service(TrendingService.self)
    static var searchingService = API.service(SearchService.self)
    static var stickerService = API.service(StickerService.self)
    
    fileprivate static func service<T: TargetType>(_ target: T.Type) ->  MoyaProvider<T> {
        if stubbing && !disableRecording {
            return MoyaProvider<T>(stubClosure: MoyaProvider.ImmediatelyStub)
        } else if !stubbing {
            return MoyaProvider<T>(plugins: [NetworkRecorderPlugin()])
        } else {
            return MoyaProvider<T>()
        }
    }
}

public final class NetworkRecorderPlugin : PluginType {
    
    public func willSendRequest(_ request: RequestType, target: TargetType) {
    
    }
    
    public func didReceiveResponse(_ result: Result<Moya.Response, Moya.Error>, target: TargetType) {
        switch result {
        case .failure(_): ()
        case .success(let response):
            do {
                let text = try response.mapString()
                if let stubsPath = target.stubFileName(forStatusCode: "\(response.statusCode)") {
                    try text.write(toFile: stubsPath, atomically: true, encoding: String.Encoding.utf8)
                }
            } catch {
                print("There was a problem with recording the request. Check your recording path or disable recording!")
            }
        }
    }
}

extension String {
    var URLEscapedString: String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
    }
}
