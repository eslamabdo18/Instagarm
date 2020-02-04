//
//  ProfilePhotoCell.swift
//  instagram
//
//  Created by Eslam Ayman  on 2/3/20.
//  Copyright © 2020 Eslam Ayman . All rights reserved.
//

import UIKit

class ProfilePhotoCell:UICollectionViewCell{
    var post:Post? {
        didSet{
            guard let image = post?.imageUrl else {return}
            imageView.loadImage(urlString: image)
        }
    }
    let imageView:CustomImageView = {
          
           let iv = CustomImageView()
           iv.backgroundColor = .black
           iv.contentMode = .scaleAspectFill
           iv.clipsToBounds = true
           return iv
       }()
    override init(frame: CGRect) {
        super.init(frame:frame)
        addSubview(imageView)
        imageView.Anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 0, width: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
