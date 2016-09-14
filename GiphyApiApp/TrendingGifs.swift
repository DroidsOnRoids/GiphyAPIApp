//
//  TrendingGifs.swift
//  GiphyApiApp
//
//  Created by Pawel Chmiel on 08.09.2016.
//  Copyright © 2016 Pawel Chmiel. All rights reserved.
//

import Foundation
import UIKit


class TrendingGifs: UITableViewController {

    override func viewDidLoad() {
        
        let trendingAPI = TrendingAPI()
        let treindingLimit = 5
        trendingAPI.requestLimitedTrendinGifs(treindingLimit) { (result) in
            if let dataValues = result.value?["data"] as? [AnyObject] {
                for jsonObject in dataValues {
                    self.gifs.append(Gif(json: jsonObject as? [String : AnyObject]))
                }
            }
        }
    }
    
    var gifs: [Gif?] = [Gif?]() {
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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellGif", for: indexPath) as UITableViewCell

        if let gif = gifs[(indexPath as NSIndexPath).row] {
            cell.textLabel!.text = gif.id
            DispatchQueue.global().async {
                let url = URL(string: gif.mediaUrl!)
                let data = try? Data(contentsOf: url!)
                let image = UIImage(data: data!)
                DispatchQueue.main.async(execute: {
                    let cellForUpdate = tableView.cellForRow(at: indexPath)
                    cellForUpdate!.imageView!.image = image
                    
                })
            }
        }

        return cell
    }
    
}
