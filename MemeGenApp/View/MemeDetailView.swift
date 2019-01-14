//
//  MemeDetailView.swift
//  MemeGenApp
//
//  Created by Diego Neves on 13/01/19.
//  Copyright © 2019 Estudo. All rights reserved.
//

import Foundation
import UIKit

class MemeDetailView : UIView {
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var btnEdit: UIButton!
    
    func initilizer (meme : Meme) {
        
        self.image.image = meme.memedImage
        
    }
    
}
