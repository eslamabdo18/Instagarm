//
//  PhotoSelectorHeader.swift
//  instagram
//
//  Created by Eslam Ayman  on 1/29/20.
//  Copyright © 2020 Eslam Ayman . All rights reserved.
//

import UIKit

class PhotoSelectorHeader: UICollectionViewCell {
    
    let headerImageView:UIImageView = {
       
        let iv = UIImageView()
        iv.backgroundColor = .black
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(headerImageView)
        headerImageView.Anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 0, width: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
