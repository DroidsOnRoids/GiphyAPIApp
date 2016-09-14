//
//  Sticker.swift
//  GiphyApiApp
//
//  Created by Pawel Chmiel on 13.09.2016.
//  Copyright © 2016 Pawel Chmiel. All rights reserved.
//

import Foundation

struct Sticker: GiphyObject {
    var id: String?
    var slug: String?
    var url: String?
    var mediaUrl: String?
    
    init(json: [String: AnyObject]?) {
        id = json?["id"] as? String
        slug = json?["slug"] as? String
        url = json?["url"] as? String
    
        guard let json = json else { return }
        
        if let images = json["images"] as? [String: Any],
            let fixedHeight = images["fixed_height"] as? [String: Any] {
            mediaUrl = fixedHeight["url"] as? String
        }
    }
}
