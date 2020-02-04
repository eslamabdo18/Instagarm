//
//  UserProfileHeader.swift
//  instagram
//
//  Created by Eslam Ayman  on 1/24/20.
//  Copyright © 2020 Eslam Ayman . All rights reserved.
//

import UIKit
import Firebase
class UserProfileHeader: UICollectionViewCell {
    
    var user:User?{
        didSet{
            guard let image = user?.image else {return}
            profileImage.loadImage(urlString: image)
            usernameLabel.text = user?.username
        }
    }
    let profileImage:CustomImageView = {
        let iv = CustomImageView()
        iv.backgroundColor = .red
        iv.layer.cornerRadius  = 80/2
        iv.clipsToBounds = true
        return iv
    }()

    let gridButton:UIButton = {
        let bt = UIButton(type: .system)
        bt.setImage(UIImage(named: "grid"), for: .normal)
        bt.tintColor = UIColor(white: 0, alpha: 0.2)
        return bt
    }()
    let listButton:UIButton = {
           let bt = UIButton(type: .system)
           bt.setImage(UIImage(named: "list"), for: .normal)
        bt.tintColor = UIColor(white: 0, alpha: 0.2)
           return bt
    }()
    let saveButton:UIButton = {
           let bt = UIButton(type: .system)
           bt.setImage(UIImage(named: "ribbon"), for: .normal)
        bt.tintColor = UIColor(white: 0, alpha: 0.2)
           return bt
    }()
  
     let usernameLabel : UILabel = {
          let label = UILabel()
           label.text = "username"
        label.textColor = .black
           return label
       }()
    
    let postLabel:UILabel = {
       let label = UILabel()
        let atteText = NSMutableAttributedString(string: "11\n", attributes: [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 14)])
        atteText.append(NSAttributedString(string: "posts", attributes: [NSAttributedString.Key.foregroundColor:UIColor.lightGray,NSAttributedString.Key.font:UIFont.systemFont(ofSize: 14)]))
        label.attributedText = atteText
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    let followersLabel:UILabel = {
          let label = UILabel()
           let atteText = NSMutableAttributedString(string: "0\n", attributes: [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 14)])
           atteText.append(NSAttributedString(string: "Followers", attributes: [NSAttributedString.Key.foregroundColor:UIColor.lightGray,NSAttributedString.Key.font:UIFont.systemFont(ofSize: 14)]))
           label.attributedText = atteText
           label.textColor = .black
           label.textAlignment = .center
        label.numberOfLines = 0
           return label
       }()
    let followingLabel:UILabel = {
          let label = UILabel()
        let atteText = NSMutableAttributedString(string: "0\n", attributes: [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 14)])
        atteText.append(NSAttributedString(string: "following", attributes: [NSAttributedString.Key.foregroundColor:UIColor.lightGray,NSAttributedString.Key.font:UIFont.systemFont(ofSize: 14)]))
        label.attributedText = atteText
           label.textColor = .black
           label.textAlignment = .center
        label.numberOfLines = 0
           return label
       }()
    
    let editProfileButton:UIButton = {
        let bt = UIButton(type: .system)
        bt.setTitle("Edit  profile", for: .normal)
        bt.setTitleColor(.black, for: .normal)
        bt.titleLabel?.font  = UIFont.boldSystemFont(ofSize: 14)
        bt.layer.borderColor = UIColor.lightGray.cgColor
        bt.layer.borderWidth = 1
        bt.layer.cornerRadius = 3
        return bt
    }()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        addSubview(profileImage)
        profileImage.Anchor(top: topAnchor, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, height: 80, width: 80)
        
        setBottomToBar()
       addSubview(usernameLabel)
        usernameLabel.Anchor(top: profileImage.bottomAnchor, left: leftAnchor, bottom: gridButton.topAnchor, right: rightAnchor, paddingTop: 4, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, height: 0, width: 0)
        
        setupUserStats()
        
        addSubview(editProfileButton)
        editProfileButton.Anchor(top: postLabel.bottomAnchor, left: postLabel.leftAnchor, bottom: nil, right: followingLabel.rightAnchor, paddingTop: 2, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 34, width: 0)
    }
    fileprivate func setupUserStats(){
         let stackView = UIStackView(arrangedSubviews: [postLabel,followersLabel,followingLabel])
         stackView.distribution = .fillEqually
        stackView.axis = .horizontal
         addSubview(stackView)
        stackView.Anchor(top: topAnchor, left: profileImage.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: -20, height: 50, width: 0)
    }
    fileprivate func setBottomToBar(){
        
        let topDiv = UIView()
        topDiv.backgroundColor = UIColor.lightGray
        
        let bottomDiv = UIView()
        bottomDiv.backgroundColor = UIColor.lightGray
        
        let stackView = UIStackView(arrangedSubviews: [gridButton,listButton,saveButton])
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        addSubview(topDiv)
        addSubview(bottomDiv)
        
        stackView.Anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 50, width: 0)
        
        topDiv.Anchor(top: stackView.topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 0.5, width: 0)
        
         bottomDiv.Anchor(top: stackView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 0.5, width: 0)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
