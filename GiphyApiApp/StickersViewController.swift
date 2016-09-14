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
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stickers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellGif", for: indexPath) as UITableViewCell
        
        if let sticker = stickers[(indexPath as NSIndexPath).row] {
            cell.textLabel!.text = sticker.id
            
            DispatchQueue.global().async {
            let url = URL(string: sticker.mediaUrl!)
                let data = try? Data(contentsOf: url!)
                let image = UIImage(data: data!)
                DispatchQueue.main.async(execute: {
                    cell.imageView!.image = image
                })
            }
        }
        
        return cell
    }
    


}
