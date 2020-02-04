//
//  SharePhotoController.swift
//  instagram
//
//  Created by Eslam Ayman  on 2/2/20.
//  Copyright © 2020 Eslam Ayman . All rights reserved.
//

import UIKit
import Firebase

class SharePhotoController:UIViewController {
    
    var selectedImage:UIImage?{
        didSet {
            imageView.image = self.selectedImage
        }
    }
    
    let imageView:UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .red
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    let textView:UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 14)
        tv.backgroundColor = .white
        tv.textColor = .black
        return tv
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.rgb(red: 240, green: 240, blue: 240)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(handleShare))
        
        setupViews()
        
    }
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    func setupViews() {
        
        let containerView = UIView()
        containerView.backgroundColor = .white
        view.addSubview(containerView)
        containerView.Anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 100, width: 0)
        
        containerView.addSubview(imageView)
        imageView.Anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 0, height: 0, width: 84)
        
        containerView.addSubview(textView)
        textView.Anchor(top: view.safeAreaLayoutGuide.topAnchor, left: imageView.rightAnchor, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 4, paddingBottom: 0, paddingRight: 0, height: 0, width: 0)
    }
    @objc func handleShare() {
       
        //code here to share in fireBase
        guard let image = selectedImage else{return}
        guard let uploadedImage = image.jpegData(compressionQuality: 0.5) else{return}
        navigationItem.rightBarButtonItem?.isEnabled = false
        let fileName = NSUUID().uuidString
        Storage.storage().reference().child("posts").child(fileName).putData(uploadedImage, metadata: nil) { (meta, error) in
            
            if let error = error {
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                print("error while uploading",error)
                return
            }
            
            let ref = Storage.storage().reference().child("posts").child(fileName)
            ref.downloadURL(completion: { (url, err) in
                if let err = err {
                    
                    print("failed to download",err)
                    return
                }
                guard let url = url?.absoluteString else  {return}
                self.saveToDataBaseWithImage(url: url)
            })
        }
        
    }
    
    func saveToDataBaseWithImage(url:String){
        guard let postImage = selectedImage else{return}
        guard let caption = textView.text else {return}
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let userPostRef = Database.database().reference().child("posts").child(uid)
        let ref = userPostRef.childByAutoId()
        let values = ["imageUrl":url, "caption":caption,"imageWidth":postImage.size.width, "imageHeight":postImage.size.height, "date":Date().timeIntervalSince1970] as [String : Any]
        ref.updateChildValues(values) { (err, database) in
            if let err = err {
                print("error",err)
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                return
            }
            
            print("success")
            self.navigationItem.rightBarButtonItem?.isEnabled = true
            self.dismiss(animated: true, completion: nil)
            
        }
        
    }
}
