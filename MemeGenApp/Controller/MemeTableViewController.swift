//
//  MemeTableViewController.swift
//  MemeGenApp
//
//  Created by Diego Neves on 20/09/18.
//  Copyright © 2018 Estudo. All rights reserved.
//

import Foundation
import UIKit

class MemeTableViewController : UITableViewController {
    
    var memes = [Meme]()
    
    var memeSelected : Meme!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.memes = appDelegate.memes
        
        tableView.reloadData()
    }
    @IBAction func newMeme(_ sender: Any) {
        
        print("NewMeme")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "viewSegue" {
        
            let controller = segue.destination as! MemeDetailViewController
            controller.memeToEdit = self.memeSelected
            
        }
    }

}

extension MemeTableViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.memeSelected = self.memes[(indexPath as NSIndexPath).row]
        performSegue(withIdentifier: "viewSegue", sender: nil)
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell")
        let meme = self.memes[(indexPath as NSIndexPath).row]
        cell?.textLabel?.text = meme.memeText()
        cell?.imageView?.image = meme.memedImage
        
        return cell!
        
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
        let index : Int = (indexPath as NSIndexPath).row
        self.memeSelected = self.memes[index]
        self.memeSelected.index = index
        return indexPath
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }
    
}
