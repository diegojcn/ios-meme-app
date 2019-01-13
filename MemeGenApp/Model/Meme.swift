//
//  Meme.swift
//  MemeGenApp
//
//  Created by Diego Neves on 16/09/18.
//  Copyright © 2018 Estudo. All rights reserved.
//

import Foundation
import UIKit


struct Meme {
    
    let topText: String
    
    let bottomText: String
    
    let originalImagem: UIImageView
    
    let memedImage : UIImage
    
    var index: Int
    
    init(topText: String, bottomText: String, originalImagem: UIImageView, memedImage: UIImage){
        self.topText = topText
        self.bottomText = bottomText
        self.originalImagem = originalImagem
        self.memedImage = memedImage
        self.index = 0
    }
    
    
    func memeText() -> String{
        return "\(topText) \(bottomText)"
    }

}
