//
//  TrendingGifs.swift
//  GiphyApiApp
//
//  Created by Pawel Chmiel on 08.09.2016.
//  Copyright © 2016 Pawel Chmiel. All rights reserved.
//

import Foundation
import UIKit

class GifCell: UITableViewCell {
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var gifImage: UIImageView!
}

class TrendingGifs: UITableViewController {

    override func viewDidLoad() {
        tableView.contentInset.top = 20.0
        
        let trendingAPI = TrendingAPI()
        let treindingLimit = 10
        trendingAPI.requestLimitedTrendinGifs(treindingLimit) { (result) in
            if let dataValues = result.value?["data"] as? [AnyObject] {
                for jsonObject in dataValues {
                    self.gifs.append(Gif(json: jsonObject as? [String : AnyObject]))
                }
            }
        }
    }
    
    var gifs = [Gif?]() {
        didSet(newValue) {
            tableView.reloadData()
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gifs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> GifCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellGif", for: indexPath) as! GifCell

        if let gif = gifs[indexPath.row] {
            cell.id.text = gif.id
           
            guard let mediaURL = gif.mediaUrl, let url = URL(string: mediaURL) else { return cell }
            
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async(execute: {
                        cell.gifImage.image = image
                    })
                }
            }
        }

        return cell
    }
    
}
