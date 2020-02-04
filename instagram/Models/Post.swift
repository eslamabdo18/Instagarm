//
//  Post.swift
//  instagram
//
//  Created by Eslam Ayman  on 2/3/20.
//  Copyright © 2020 Eslam Ayman . All rights reserved.
//

import Foundation

struct Post {
    let imageUrl:String
    
    init(dict:[String:Any]) {
        imageUrl = dict["imageUrl"] as? String ?? ""
    }
}
