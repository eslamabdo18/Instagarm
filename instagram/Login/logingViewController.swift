//
//  logingViewController.swift
//  instagram
//
//  Created by Eslam Ayman  on 1/26/20.
//  Copyright © 2020 Eslam Ayman . All rights reserved.
//

import UIKit
import Firebase
class logingViewController:UIViewController {
    
    let logoContainer:UIView = {
        let view = UIView()
        
        let logoImageView = UIImageView(image: UIImage(named: "Instagram_logo_white"))
        logoImageView.contentMode = .scaleAspectFill
        view.addSubview(logoImageView)
        logoImageView.Anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 50, width: 200)
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        view.backgroundColor = UIColor.rgb(red: 0, green: 120, blue: 175)
        return view
    }()
    
    let emailTextField:UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.backgroundColor = UIColor(white: 0, alpha: 0.04)
        textField.borderStyle  = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.textColor = .black
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return textField
    }()
    let password:UITextField = {
                 let textField = UITextField()
        textField.placeholder = "password"
        
        textField.textColor = .black
                 textField.backgroundColor = UIColor(white: 0, alpha: 0.03)
                 textField.borderStyle  = .roundedRect
           textField.isSecureTextEntry = true
                 textField.font = UIFont.systemFont(ofSize: 14)
                 textField.translatesAutoresizingMaskIntoConstraints = false
            textField.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
                 return textField
    }()
    let loginButton:UIButton = {
       
        let bt = UIButton(type: .system)
        bt.setTitle("Login", for: .normal)
        bt.layer.cornerRadius = 5
        bt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        bt.setTitleColor(.white, for: .normal)
        bt.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
        bt.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        bt.isEnabled  = false
        return bt
    }()
    let signUpButton:UIButton={
        let bt = UIButton(type: .system)
        let attrTitle = NSMutableAttributedString(string: "Don't have an account ?", attributes: [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 14),NSAttributedString.Key.foregroundColor:UIColor.lightGray])
        attrTitle.append(NSAttributedString(string: "Sign Up", attributes: [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 14),NSAttributedString.Key.foregroundColor:UIColor.rgb(red: 17, green: 153, blue: 237)]))
        bt.setAttributedTitle(attrTitle, for: .normal)
        bt.addTarget(self, action: #selector(signup), for: .touchUpInside)
        return bt
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(logoContainer)
        logoContainer.Anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 150, width: 0)
        
        
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .white
        view.addSubview(signUpButton)
        
        signUpButton.Anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 50, width: 0)
        
        setupInfo()
    }
    
    @objc func handleLogin() {
        guard let email =  emailTextField.text, email.count > 0 else{return}
        guard let pass = password.text, pass.count > 0 else{return}
        Auth.auth().signIn(withEmail: email, password: pass) { (result, error) in
            
            if let error = error {
                print(error)
                return
            }
            print("done",result?.user.uid ?? "")
            guard let maintab = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController else{return}
            maintab.setUpView()
            self.dismiss(animated: true, completion: nil)
            
        }
    }
    @objc func handleTextInputChange() {
        
        let isValidForm = emailTextField.text!.count>0 && password.text!.count>0
        
        if isValidForm{
                   loginButton.backgroundColor = UIColor.rgb(red: 17, green: 154, blue: 237)
                   loginButton.isEnabled = true
               }else{
                   loginButton.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
                   loginButton.isEnabled = false
               }
    }
    
    func setupInfo() {
        
        let stack = UIStackView(arrangedSubviews: [emailTextField,password,loginButton])
        stack.distribution = .fillEqually
        stack.axis = .vertical
        stack.spacing = 10
         view.addSubview(stack)
        stack.Anchor(top: logoContainer.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 40, paddingLeft: 40, paddingBottom: 0, paddingRight: -40, height: 140, width: 0)
    }
    @objc func signup(){
        DispatchQueue.main.async {
            let sign = ViewController()
            sign.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(sign, animated: true)
        }
       
    }
    
    
}

