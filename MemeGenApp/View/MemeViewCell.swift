//
//  MemeCellView.swift
//  MemeGenApp
//
//  Created by Diego Neves on 19/09/18.
//  Copyright © 2018 Estudo. All rights reserved.
//

import Foundation
import UIKit

class MemeViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    
    func customCell () {
        let bcolor : UIColor = UIColor( red: 0.2, green: 0.2, blue:0.2, alpha: 0.3 )
        
        self.layer.borderColor = bcolor.cgColor
        
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 3
        self.backgroundColor=UIColor.white
        
        
    }
  
}
