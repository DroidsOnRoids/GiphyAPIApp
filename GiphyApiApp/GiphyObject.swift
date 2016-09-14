//
//  Gif.swift
//  GiphyApiApp
//
//  Created by Pawel Chmiel on 08.09.2016.
//  Copyright © 2016 Pawel Chmiel. All rights reserved.
//

import Foundation
import UIKit

protocol GiphyObject {
    var id : String? { get set }
    var slug:  String? { get set }
    var url:  String? { get set }
    var mediaUrl: String? { get set }
}