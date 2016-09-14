//
//  APIConstant.swift
//  GiphyApiApp
//
//  Created by Pawel Chmiel on 20.07.2016.
//  Copyright © 2016 Pawel Chmiel. All rights reserved.
//

import Foundation
import Moya

struct APIConstants {
    
    static let betaKey = "dc6zaTOxFJmzC"
    static let baseURL = "https://api.giphy.com/v1/"
    static let stubsPath: String? = {
        guard let infoPlist = Bundle.main.infoDictionary,
            let stubsPath = infoPlist["StubsDirectoryPath"] as? String else { return nil }
        
        return stubsPath
    }()

}

extension TargetType {
    
    func stubFileName(forStatusCode statusCode: String) -> String? {
        guard let stubsPath = APIConstants.stubsPath else { return nil }
        if let selfString = "\(self)".components(separatedBy: "(").first {
            return "\(stubsPath)\(type(of: self))_\(selfString)_\(statusCode).json"
        } else {
            return "\(stubsPath)\(type(of: self))_\(self)_\(statusCode).json"
        }
    }
}



