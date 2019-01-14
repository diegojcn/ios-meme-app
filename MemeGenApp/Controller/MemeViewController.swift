//
//  ViewController.swift
//  MemeGenApp
//
//  Created by Diego Neves on 19/08/18.
//  Copyright © 2018 Estudo. All rights reserved.
//

import UIKit

class MemeViewController: UIViewController , UIImagePickerControllerDelegate,
UINavigationControllerDelegate{

    @IBOutlet var memeView: MemeView!
    
    let imagePicker = UIImagePickerController()
    
    var memeToEdit : Meme! = nil

    override func viewWillDisappear(_ animated: Bool) {
        unsubscribeFromKeyboardNotifications()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self

        if memeView  != nil {
            memeView.initializer(memeSelected: memeToEdit)
        }
       
    }
    override func viewWillAppear(_ animated: Bool) {
        subscribeToKeyboardNotifications()

    }
    
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(MemeViewController.keyboardChange(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(MemeViewController.keyboardChange(_:)), name: .UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(MemeViewController.keyboardChange(_:)), name: .UIKeyboardWillChangeFrame, object: nil)
        
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillChangeFrame, object: nil)
    }
    
    deinit {
        unsubscribeFromKeyboardNotifications()
    }
    
    

    @objc func keyboardChange(_ notification:Notification) {
        view.frame.origin.y = 0
        if(notification.name == Notification.Name.UIKeyboardWillShow || notification.name == Notification.Name.UIKeyboardWillChangeFrame ){
            
            if self.memeView.bottomText.isFirstResponder {
                view.frame.origin.y -= getKeyboardHeight(notification)
            }
            let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self.memeView, action: #selector(self.memeView.hideKeyboard))
            tapGesture.cancelsTouchesInView = false
            
            self.view.addGestureRecognizer(tapGesture)
            
        } else {
            view.frame.origin.y = 0
        }
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height/2
    }
    
    func showToolBarAndNavBar(show: Bool){
      
        if(show){
        self.navigationController?.setNavigationBarHidden(false, animated: false)
            memeView.showToolBar(show: true)
        } else {
            self.navigationController?.setNavigationBarHidden(true, animated: false)
            memeView.showToolBar(show: false)
        }
        
        
    }
    
    func generateMemedImage() -> UIImage {
        
        showToolBarAndNavBar(show: false)
        
        UIGraphicsBeginImageContext(self.memeView.imageView.frame.size)
        memeView.imageView.drawHierarchy(in: self.memeView.imageView.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        showToolBarAndNavBar(show: true)
        
        return memedImage
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            self.memeView.imagem.image = image
            self.memeView.showTextFields(show: true)
            self.memeView.showButtons(show: true)
            
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cleanMeme(_ sender: Any) {
        
        self.memeView.initializer(memeSelected: nil)
    }
    
    private func back() {
        
        performSegue(withIdentifier: "back", sender: nil)
        
    }
    
    @IBAction func pickOrChoosePhoto(_ sender: UIButton) {
        
        if sender.tag == 0{
            imagePicker.sourceType = .photoLibrary
        } else if sender.tag == 1{
            imagePicker.sourceType = .camera
        }
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func shareMeme(_ sender: UIButton){
        memeView.memedImage = generateMemedImage()
        let meme = Meme(topText: memeView.topText.text!, bottomText: memeView.bottomText.text!, originalImagem: memeView.imagem, memedImage: memeView.memedImage)
       
        let controller = UIActivityViewController(activityItems: [meme.memedImage], applicationActivities: nil)
        
        controller.completionWithItemsHandler = {(activityType: UIActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
            if completed {
                
                if self.memeToEdit == nil {
                    self.save(meme: meme)
                } else {
                    let object = UIApplication.shared.delegate
                    let appDelegate = object as! AppDelegate
                    appDelegate.memes.remove(at: self.memeToEdit.index)
                    appDelegate.memes.append(meme)
                }
                
                self.back()
                return
            }
        }
        
       self.present(controller, animated: true, completion: nil)
        
        
    }
    
    func save(meme : Meme){
        
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
    
    }
    
    
}

