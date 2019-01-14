//
//  MemeCollectionViewController.swift
//  MemeGenApp
//
//  Created by Diego Neves on 19/09/18.
//  Copyright © 2018 Estudo. All rights reserved.
//

import Foundation
import UIKit

class MemeCollectionViewController: UICollectionViewController{

    var memes = [Meme]()
    
    var memeSelected : Meme!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        self.collectionView?.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "viewSegue" {
            let controller = segue.destination as! MemeDetailViewController
            controller.memeToEdit = self.memeSelected
            
        }
    }
    
}

extension MemeCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.memeSelected = self.memes[(indexPath as NSIndexPath).row]
        performSegue(withIdentifier: "viewSegue", sender: nil)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCell", for: indexPath) as! MemeViewCell
        cell.customCell()
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        cell.imageView?.image = meme.memedImage
        cell.label.text = meme.memeText()
        
        return cell
        
    }
    
}
