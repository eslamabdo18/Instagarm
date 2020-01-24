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
             setupProfileImage()
        }
    }
    let profileImage:UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
        iv.layer.cornerRadius  = 80/2
        iv.clipsToBounds = true
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        backgroundColor = .blue
        addSubview(profileImage)
        profileImage.Anchor(top: topAnchor, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, height: 80, width: 80)
        
       
        
    }
    func setupProfileImage(){
        guard let image = user?.image else {return}
        let url = URL(string: image)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            print(data)
          let image = UIImage(data: data!)
          DispatchQueue.main.async {
              self.profileImage.image = image
          }

        }.resume()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
