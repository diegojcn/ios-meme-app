//
//  MemeView.swift
//  MemeGenApp
//
//  Created by Diego Neves on 19/08/18.
//  Copyright © 2018 Estudo. All rights reserved.
//

import Foundation
import UIKit

class MemeView : UIView, UITextFieldDelegate{
    
    @IBOutlet weak var imagem: UIImageView!
    
    @IBOutlet weak var cameraBtn: UIButton!
    
    @IBOutlet weak var topText: UITextField!
    
    @IBOutlet weak var bottomText: UITextField!
    
    @IBOutlet weak var shareBtn: UIButton!
    
    @IBOutlet weak var trashBtn: UIButton!
    
    @IBOutlet weak var albumBtn: UIButton!
    
    @IBOutlet weak var imageView: UIView!
    
    @IBOutlet weak var btnView: UIView!
    
    var memedImage : UIImage!
    
    
    let textDefault : String = "Digite o Texto"
    
    func initializer(memeSelected : Meme!){
        self.cameraBtn.isEnabled =  UIImagePickerController.isSourceTypeAvailable(.camera)
        
        self.topText.delegate = self
        self.bottomText.delegate = self
        
        let memeTextAttributes = [
            NSAttributedStringKey.strokeColor.rawValue : UIColor.black,
            NSAttributedStringKey.foregroundColor : UIColor.white,
            NSAttributedStringKey.strokeWidth : 0,
            NSAttributedStringKey.font : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!
            ] as! [String : Any]
        
        self.topText.defaultTextAttributes = memeTextAttributes
        self.bottomText.defaultTextAttributes = memeTextAttributes
        
        if memeSelected != nil {
            self.imagem.image = memeSelected.originalImagem.image
            self.memedImage = memeSelected.memedImage
            self.bottomText.text = memeSelected.bottomText
            self.topText.text = memeSelected.topText
            showTextFields(show: true)
            showButtons(show: true)
        } else {
            
            self.topText.text = textDefault
            self.bottomText.text = textDefault
            self.topText.clearsOnBeginEditing = true
            self.bottomText.clearsOnBeginEditing = true
            self.imagem.image = nil
            self.memedImage = nil
            showTextFields(show: false)
            showButtons(show: false)
            
        }
        
    }
    
    func showButtons(show: Bool){
        
        if show {
            self.shareBtn.isHidden = false
            self.trashBtn.isHidden = false
            self.cameraBtn.isHidden = true
            self.albumBtn.isHidden = true
        } else {
            self.shareBtn.isHidden = true
             self.trashBtn.isHidden = true
            self.cameraBtn.isHidden = false
            self.albumBtn.isHidden = false
        }
        
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {

        if (textField.text?.elementsEqual(""))! {
           textField.text = textDefault
        }
        
        
    }
    
    func showToolBar(show: Bool){
        if(show) {
            self.btnView.isHidden = false
        } else {
            self.btnView.isHidden = true
        }
        
    }
    
    func showTextFields(show: Bool){
        if show {
            
            self.topText.isHidden = false
            self.bottomText.isHidden = false
        } else {
            self.topText.isHidden = true
            self.bottomText.isHidden = true
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dismissKeyboard(tag: textField.tag)
        return true
    }
    
    func dismissKeyboard(tag : Int){
        if tag == 0 {
            self.topText.resignFirstResponder()
        } else if ((tag == 1)) {
            self.bottomText.resignFirstResponder()
        }
    }
    
    @objc func hideKeyboard()
    {
        self.topText.resignFirstResponder()
        self.bottomText.resignFirstResponder()
    }
   
}
