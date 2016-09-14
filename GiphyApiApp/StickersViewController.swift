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
        
        let stickerAPI = StickerAPI()
        stickerAPI.searchForSticker("dogs") { (result) in
            if (result.error == nil) {
                if let dataValues = result.value?["data"] as? [AnyObject] {
                    for jsonObject in dataValues {
                        let sticker = Sticker(json: jsonObject as? [String : AnyObject])
                        self.stickers.append(sticker)
                    }
                }
            } else {
                print("error: \(result.error.debugDescription)")
            }
        }
    }
    
    var stickers: [Sticker?] = [Sticker?]() {
        didSet(newValue) {
            tableView.reloadData()
        }
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stickers.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellGif", forIndexPath: indexPath) as UITableViewCell
        
        if let sticker = stickers[indexPath.row] {
            cell.textLabel!.text = sticker.id
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                let url = NSURL(string: sticker.mediaUrl!)
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
