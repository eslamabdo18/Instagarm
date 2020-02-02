//
//  PhotoCell.swift
//  instagram
//
//  Created by Eslam Ayman  on 1/29/20.
//  Copyright © 2020 Eslam Ayman . All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    var images = [UIImage]()
    let imageView:UIImageView = {
       let image  = UIImageView()
        image.backgroundColor = .lightGray
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.alpha = 1
        return image
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
