//
//  UserSearchCell.swift
//  instagram
//
//  Created by Eslam Ayman  on 2/6/20.
//  Copyright © 2020 Eslam Ayman . All rights reserved.
//

import UIKit

class UserSearchCell: UICollectionViewCell {
    
    var user:User?{
        didSet{
            guard let imageString = user?.image else{return}
            guard let username = user?.username else{return}
            customUserImage.loadImage(urlString: imageString)
            usernameLabbel.text = username
        }
    }
    
    let customUserImage:CustomImageView = {
        let image = CustomImageView()
        image.backgroundColor = .red
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    let usernameLabbel:UILabel = {
        let label = UILabel()
        label.text = "username"
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 13)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        addSubview(customUserImage)
        addSubview(usernameLabbel)
        
        customUserImage.Anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, height: 50, width: 50)
        customUserImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        customUserImage.layer.cornerRadius = 50/2
        
        usernameLabbel.Anchor(top: topAnchor, left: customUserImage.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, height: 0, width: 0)
        
        let  sep = UIView()
        sep.backgroundColor = UIColor(white: 0, alpha: 0.5)
        addSubview(sep)
        sep.Anchor(top: nil, left: usernameLabbel.leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 0.5, width: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
