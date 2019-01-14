//
//  MemeDetailViewController.swift
//  MemeGenApp
//
//  Created by Diego Neves on 13/01/19.
//  Copyright © 2019 Estudo. All rights reserved.
//

import Foundation
import UIKit

class MemeDetailViewController : UIViewController {
    
    @IBOutlet var detailView: MemeDetailView!
    
    var memeToEdit : Meme! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.detailView.initilizer(meme: self.memeToEdit)
        
    }
    
    @IBAction func edit(_ sender: Any) {
        performSegue(withIdentifier: "editSegue", sender: nil)
    }
    
}

extension MemeDetailViewController {
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "editSegue" {
            let controller = segue.destination as! MemeViewController
            controller.memeToEdit = self.memeToEdit
            
        }
        
    }
}
