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
        self.id = json?["id"] as? String
        self.slug = json?["slug"] as? String
        self.url = json?["url"] as? String
        self.mediaUrl = json?["images"]?["fixed_height"]??["url"] as? String
    }
}