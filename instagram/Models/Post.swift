//
//  Post.swift
//  instagram
//
//  Created by Eslam Ayman  on 2/3/20.
//  Copyright © 2020 Eslam Ayman . All rights reserved.
//

import Foundation

struct Post {
    let user:User
    let imageUrl:String
    let caption:String
    init(user:User,dict:[String:Any]) {
        self.user = user
        imageUrl = dict["imageUrl"] as? String ?? ""
        caption = dict["caption"] as? String ?? ""
    }
}
