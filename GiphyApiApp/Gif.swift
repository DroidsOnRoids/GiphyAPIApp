//
//  Gif.swift
//  GiphyApiApp
//
//  Created by Pawel Chmiel on 08.09.2016.
//  Copyright © 2016 Pawel Chmiel. All rights reserved.
//

import Foundation
import UIKit

struct Gif {
    var id: String?
    let slug: String?
    let url: String?
    let mediaUrl: String?
    
    init(json: [String: AnyObject]?) {
        self.id = json?["id"] as? String
        self.slug = json?["slug"] as? String
        self.url = json?["url"] as? String
        self.mediaUrl = json?["images"]?["fixed_height"]??["url"] as? String
    }
}