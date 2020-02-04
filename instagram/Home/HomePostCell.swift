//
//  HomePostCell.swift
//  instagram
//
//  Created by Eslam Ayman  on 2/4/20.
//  Copyright © 2020 Eslam Ayman . All rights reserved.
//

import UIKit

class HomePostCell:UICollectionViewCell{
    var post:Post?{
        didSet{
            guard let image = post?.imageUrl else{return}
            photoImageView.loadImage(urlString: image)
        }
    }
    let photoImageView:CustomImageView = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    let userProfileImageView:CustomImageView={
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .blue
        return iv
    }()
    let usernameLabel:UILabel = {
        let label = UILabel()
        label.text = "Username"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    let optionsButton:UIButton={
        let bt = UIButton(type: .system)
        bt.setTitle("•••", for: .normal)
        bt.setTitleColor(.black, for: .normal)
        return bt
    }()
    let likeButton:UIButton={
        let bt = UIButton(type: .system)
        bt.setImage(UIImage(named: "like_unselected")?.withRenderingMode(.alwaysOriginal), for: .normal)
        
        return bt
    }()
    let commentButton:UIButton={
        let bt = UIButton(type: .system)
        bt.setImage(UIImage(named: "comment")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return bt
    }()
    let sendButton:UIButton={
        let bt = UIButton(type: .system)
        bt.setImage(UIImage(named: "send2")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return bt
    }()
    let saveButton:UIButton={
        let bt = UIButton(type: .system)
        bt.setImage(UIImage(named: "ribbon")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return bt
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(userProfileImageView)
        addSubview(usernameLabel)
        addSubview(optionsButton)
        addSubview(photoImageView)
        addSubview(likeButton)
        
        userProfileImageView.Anchor(top:topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, height: 40, width: 40)
        
        userProfileImageView.layer.cornerRadius = 40/2
        
        usernameLabel.Anchor(top: topAnchor, left: userProfileImageView.rightAnchor, bottom: photoImageView.topAnchor, right: optionsButton.leftAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, height: 0, width: 0)
        
        optionsButton.Anchor(top: topAnchor, left: nil, bottom: photoImageView.topAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 0, width: 50)
        
        photoImageView.Anchor(top: userProfileImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 0, width: 0)
        
        photoImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
       
        setupActionButtons()
        
    }
    
    func setupActionButtons(){
        let stackView = UIStackView(arrangedSubviews: [likeButton,commentButton,sendButton])
        stackView.distribution = .fillEqually
        addSubview(stackView)
        
        stackView.Anchor(top: photoImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, height: 50, width: 120)
        
        addSubview(saveButton)
        saveButton.Anchor(top: photoImageView.bottomAnchor, left:nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 50, width: 40)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
