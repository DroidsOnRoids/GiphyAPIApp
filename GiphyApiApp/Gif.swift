//
//  Gif.swift
//  GiphyApiApp
//
//  Created by Pawel Chmiel on 08.09.2016.
//  Copyright © 2016 Pawel Chmiel. All rights reserved.
//

import Foundation
import UIKit

struct Gif : GiphyObject {
    var id: String?
    var slug: String?
    var url: String?
    var mediaUrl: String?
    
    init(json: [String: AnyObject]?) {
        slug = json?["slug"] as? String
        url = json?["url"] as? String
        id = json?["id"] as? String
       
        guard let json = json else { return }
       
         if let images = json["images"] as? [String: Any],
            let fixedHeight = images["fixed_height"] as? [String: Any] {
            mediaUrl = fixedHeight["url"] as? String
        }
        
    
    }
}
