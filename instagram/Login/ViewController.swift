//
//  ViewController.swift
//  instagram
//
//  Created by Eslam Ayman  on 1/22/20.
//  Copyright © 2020 Eslam Ayman . All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    let plusPhotoButton:UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "plus_photo")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addImage), for: .touchUpInside)
        return button
    }()
    @objc func addImage(){
        let imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker,animated: true,completion: nil)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        plusPhotoButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        plusPhotoButton.layer.cornerRadius = plusPhotoButton.frame.width/2
        plusPhotoButton.layer.masksToBounds = true
        plusPhotoButton.layer.borderColor = UIColor.black.cgColor
        plusPhotoButton.layer.borderWidth = 3
        dismiss(animated: true, completion: nil)
    }
    let emailTextField:UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textField.borderStyle  = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return textField
    }()
    let userName:UITextField = {
           let textField = UITextField()
           textField.placeholder = "UserName"
           textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
           textField.borderStyle  = .roundedRect
           textField.font = UIFont.systemFont(ofSize: 14)
           textField.translatesAutoresizingMaskIntoConstraints = false
         textField.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
           return textField
       }()
    let signUpButton:UIButton = {
       
        let bt = UIButton(type: .system)
        bt.setTitle("Sign Up", for: .normal)
        bt.layer.cornerRadius = 5
        bt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        bt.setTitleColor(.white, for: .normal)
        bt.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
        bt.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        bt.isEnabled  = false
        return bt
    }()
    let password:UITextField = {
              let textField = UITextField()
              textField.placeholder = "Password"
              textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
              textField.borderStyle  = .roundedRect
        textField.isSecureTextEntry = true
              textField.font = UIFont.systemFont(ofSize: 14)
              textField.translatesAutoresizingMaskIntoConstraints = false
         textField.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
              return textField
          }()
    let alreadyHaveAccButton:UIButton={
        let bt = UIButton(type: .system)
        let attrTitle = NSMutableAttributedString(string: "already have accoount?", attributes: [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 14),NSAttributedString.Key.foregroundColor:UIColor.lightGray])
        attrTitle.append(NSAttributedString(string: "Login", attributes: [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 14),NSAttributedString.Key.foregroundColor:UIColor.rgb(red: 17, green: 153, blue: 237)]))
        bt.setAttributedTitle(attrTitle, for: .normal)
        bt.addTarget(self, action: #selector(haveAccHandler), for: .touchUpInside)
        return bt
    }()
    @objc func haveAccHandler() {
        navigationController?.popViewController(animated: true)
    }
    @objc func handleTextInputChange(){
        
        let isValidForm = emailTextField.text!.count>0 && password.text!.count>0 && userName.text!.count > 0
        
        if isValidForm{
            signUpButton.backgroundColor = UIColor.rgb(red: 17, green: 154, blue: 237)
            signUpButton.isEnabled = true
        }else{
            signUpButton.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
            signUpButton.isEnabled = false
        }
    }
    @objc func handleSignUp(){
        
        guard let email = emailTextField.text,email.count>0  else {return}
        guard let password = password.text,password.count>0  else {return}
        guard let username = userName.text,username.count>0  else {return}
       Auth.auth().createUser(withEmail: email, password: password) { (user, error) in

       if let error = error {
           print("Failed to create user with error", error.localizedDescription)
           return
       }
        print("added")
        guard let image = self.plusPhotoButton.imageView?.image else{return}
        let uploded = image.jpegData(compressionQuality: 0.3)
        let fileName = NSUUID().uuidString
        Storage.storage().reference().child("profileImage").child(fileName).putData(uploded!, metadata: nil) { (meta, error) in
            
            if let error = error{
                print("error while uploading",error)
                return
            }
            print("done uploading")
            
            guard let userID = Auth.auth().currentUser?.uid else {return}
            let storageImageRef = Storage.storage().reference().child("profileImage").child(fileName)
            storageImageRef.downloadURL { (url, error) in
                if let imageUrl  = url?.absoluteString{
                    let dictionaryValues = ["username":username,"profileImageURL":imageUrl]
                    let values = [userID:dictionaryValues]
                    
                    Database.database().reference().child("users").updateChildValues(values) { (err, ref) in
                        
                        if let err = err{
                            print("failed",err)
                            return
                        }
                            print("Successfully created user and saved information to database")
                        guard let maintab = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController else{return}
                                   maintab.setUpView()
                                   self.dismiss(animated: true, completion: nil)
                    
                    }
                }
            }
        }

     }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .white
        view.addSubview(plusPhotoButton)
        plusPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive=true
        plusPhotoButton.Anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 70, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 140, width: 140)
        setUpInputField()
        
        view.addSubview(alreadyHaveAccButton)
               
               alreadyHaveAccButton.Anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 50, width: 0)
               
        
    }

    fileprivate func setUpInputField(){
       
        let stackView  = UIStackView(arrangedSubviews: [emailTextField,userName,password,signUpButton])
        
       
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        
        view.addSubview(stackView)
        
        stackView.Anchor(top: plusPhotoButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 40, paddingBottom: 0, paddingRight: -40, height: 200, width: 0)
    }

}

extension UIView{
    
    func Anchor(top:NSLayoutYAxisAnchor?,left:NSLayoutXAxisAnchor?,bottom:NSLayoutYAxisAnchor?,right:NSLayoutXAxisAnchor?,paddingTop:CGFloat,paddingLeft:CGFloat,paddingBottom:CGFloat,paddingRight:CGFloat,height:CGFloat,width:CGFloat){
        
         self.translatesAutoresizingMaskIntoConstraints = false
        if let top = top{
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let left = left{
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive  = true
        }
        if let right = right{
            self.rightAnchor.constraint(equalTo: right, constant: paddingRight).isActive = true
        }
        if let bottom = bottom{
            self.bottomAnchor.constraint(equalToSystemSpacingBelow: bottom, multiplier: paddingBottom).isActive = true
        }
        if width != 0{
            self.widthAnchor.constraint(equalToConstant: width).isActive=true
        }
        if height != 0{
            self.heightAnchor.constraint(equalToConstant: height).isActive=true
        }
        
    }
}
