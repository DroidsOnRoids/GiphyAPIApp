//
//  FirstViewController.swift
//  GiphyApiApp
//
//  Created by Pawel Chmiel on 20.07.2016.
//  Copyright © 2016 Pawel Chmiel. All rights reserved.
//

import UIKit
import Foundation

class StickersViewController : UITableViewController{

    override func viewDidLoad() {
        
        let trendingAPI = TrendingAPI()
        let treindingLimit = 25
        trendingAPI.requestLimitedTrendinGifs(treindingLimit) { (result) in
            for jsonObject in result.value!["data"]! as! [AnyObject] {
                self.gifs.append(Gif(json: jsonObject as? [String : AnyObject]))
            }
        }
    }
    
    var gifs: [Gif?] = [Gif?]() {
        didSet(newValue) {
            tableView.reloadData()
        }
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gifs.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellGif", forIndexPath: indexPath) as UITableViewCell
        
        if let gif = gifs[indexPath.row] {
            cell.textLabel!.text = gif.id
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                let url = NSURL(string: gif.mediaUrl!)
                let data = NSData(contentsOfURL: url!)
                let image = UIImage(data: data!)
                dispatch_async(dispatch_get_main_queue(), {
                    cell.imageView!.image = image
                })
            }
        }
        
        return cell
    }
    


}
